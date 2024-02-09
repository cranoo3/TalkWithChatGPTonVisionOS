//
//  ContentViewModel.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import Foundation

class ContentViewModel: ObservableObject {
    // APIクライアントのインスタンス
    let client = APICliant()
    // レスポンスが格納される
    var data: APIResponse
    /// ユーザーが入力したcontent
    @Published var content: String
    /// ChatGPTからの返答
    @Published var receivedContent: String
    /// フェッチ中かどうかのフラグ
    @Published var isFetched: Bool
    /// アラート表示用フラグ
    @Published var isShowAlert: Bool
    /// アラートに表示するメッセージ
    @Published var alertMessage: String?
    
    // MARK: - init
    init() {
        data = APIResponse(id: "", object: "", created: 0, model: "",
                               choices: [
                                Choice(index: 0, message: Message(role: "", content: "未取得"),finishReason: "")
                               ],
                               usage: Usage(promptTokens: 0, completionTokens: 0, totalTokens: 0),
                               systemFingerprint: JSONNull())
        
        content = ""
        receivedContent = ""
        isFetched = false
        isShowAlert = false
        alertMessage = ""
    }
    
    // MARK: - データを取得しdataに代入する
    @MainActor
    func fetchData() {
        Task {
            // フェッチ中のフラグを立てる
            isFetched = true
            
            // ユーザーが入力したContentをMessageManagerに追加する
            addUserContent()
            
            // データ取得
            let result = await client.fetch()
            
            // 正しいデータが戻ってるか確認
            switch result {
            case .success(let data):
                self.data = data
                
            case .failure(let error):
                isShowAlert = true
                if let error = error as? CommunicationError {
                    alertMessage = error.message
                } else {
                    alertMessage = error.localizedDescription
                }
            }
            
            // 受け取ったデータをMessageManagerに追加する
            addReceivedContent()
            
            // ロード終了
            isFetched = false
        }
    }
    
    // MARK: データ取得可能な状態か確認する
    /// fetchが行えるか判定する
    func fetchDecision() -> Bool {
        // フェッチ中でもなくユーザーの入力が空でもない場合に行えるようにする
        if !(isFetched || content.isEmpty) {
            return true
        }
        return false
    }
    
    // MARK: - ユーザーが入力したContentをMessageManagerに追加する
    private func addUserContent() {
        // MessageManagerのMessageに入力された文字を代入する
        MessageManager.shared.setUserContent(content: self.content)
        // コンテントを空にしてテキストフィールドから文字を消す
        content.removeAll()
    }
    
    // MARK: - メッセージを受信した時の処理
    private func addReceivedContent() {
        guard let message = data.choices.first?.message else {
            // 正しくデータが変換できなかった場合は何もしないで帰ってもらう
            // 一応printして失敗したことだけ伝えておく
            print("残念! メッセージ取得に失敗したよ!")
            return
        }
        // MessageManagerに受け取ったメッセージデータを代入する
        MessageManager.shared.assistantContent(message: message)
    }
}
