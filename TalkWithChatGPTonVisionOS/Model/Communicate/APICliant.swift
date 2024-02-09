//
//  APICliant.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import Foundation

/// OpenAIへリクエストを送信するための構造体。
/// PlistからURLやAPIKeyを取得し、リクエストを送信する。
struct APICliant {
    // MARK: - Plistから値を取得する
    let urlString = GetPropertyList.shared.getUrlString()
    let apiKey = GetPropertyList.shared.getApiKey()
    let organizationID = GetPropertyList.shared.getOrganizationID()
    let model = GetPropertyList.shared.getGPTModel()
    
    // MARK: - 取得したurlStringをURL型に変換する
    var urlResult: Result<URL, Error> {
        if let tmpURL = URL(string: urlString) {
            // url型に変換できた場合 -> 変換したものを返す
            return .success(tmpURL)
        } else {
            // 変換できなかった場合 -> エラーを返す
            return .failure(CommunicationError.badURL)
        }
    }
    
    // MARK: - URLコンポーネントを作成
    private func makeURLComponents() throws -> URLComponents {
        switch urlResult {
        case .success(let url):
            // コンポーネントを作成
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                // 作成に失敗 -> エラー
                throw CommunicationError.cannnotCreateURLComponents
            }
            // 作成したURLコンポーネントを返す
            return components
            
        case .failure(let failure):
            throw failure
        }
    }
    
    // MARK: - 情報を取得(フェッチ)する
    func fetch() async -> Result<APIResponse, Error>{
        do {
            // URLコンポーネントからurlを生成
            guard let url = try makeURLComponents().url else {
                return .failure(CommunicationError.cannotCreateURL)
            }
            
            // POSTリクエストを送信するため、ボディーに格納するデータを作成する
            // メッセージはMessageManagerが管理を行っているのでMessageManagerを使用する
            // 形式はJSONなので`RequestHttpBody`を使用し、エンコードを行う
            var requestBody: Data? {
                let encodeValue = RequestHttpBody(model: self.model, messages: MessageManager.shared.messages)
                return try? JSONEncoder().encode(encodeValue)
            }
            
            // リクエストを作成
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.allHTTPHeaderFields = ["Authorization" : "Bearer \(apiKey)"
                                              ,"OpenAI-Organization": organizationID
                                              ,"Content-Type" : "application/json"]
            urlRequest.httpBody = requestBody
            
            // リクエストを送信
            guard let (data, urlRequest) = try? await URLSession.shared.data(for: urlRequest) else {
                return .failure(CommunicationError.couldNotCreateRequest)
            }
            
            // 情報を受け取る
            guard let response = urlRequest as? HTTPURLResponse else {
                return .failure(CommunicationError.responseNotReturned)
            }
            // 帰ってきた情報のステータスコードが正常ではない場合 -> エラーを出す
            guard 200..<300 ~= response.statusCode else {
                return .failure(CommunicationError.badStatusCode(response.statusCode))
            }
            
            // 受け取ったJSONをStructに格納する
            let decodeData = try JSONDecoder().decode(APIResponse.self, from: data)
            return .success(decodeData)
            
        } catch {
            return .failure(error)
        }
    }
}
