//
//  MessageManager.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import Foundation

/// トーク履歴を管理するクラス
class MessageManager: Codable {
    static let shared = MessageManager()
    /// メッセージの履歴
    var messages: [Message]
    
    init () {
        messages = []
    }
    
    // MARK: - ユーザーが送信した文字列を追加する
    /// ユーザーが送信した文字列をMessage配列へ追加する
    /// - Parameter content: 入力した文字列を入れてください
    func setUserContent(content: String) {
        messages.append(Message(role: "user", content: "\(content)"))
        print("append is success! (content: \(content))")
    }
    
    // MARK: - ChatGPTからのメッセージを追加する
    /// ChatGPTからの返答をMessage配列へ追加します
    /// - Parameter message: 返答はMessage型になっているので`Message`を引数で受け取る
    func assistantContent(message: Message) {
        messages.append(message)
        print("append is success! (content: \(message.content))")
    }
}
