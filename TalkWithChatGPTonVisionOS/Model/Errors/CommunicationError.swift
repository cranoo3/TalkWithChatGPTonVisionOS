//
//  CommunicationError.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import Foundation

enum CommunicationError: Error {
    case badURL
    case cannnotCreateURLComponents
    case cannotCreateURL
    case responseNotReturned
    case badStatusCode(Int)
    case fetchError
    
    case cannotExportData
    case couldNotCreateRequest
    
    var message: String {
        switch self {
        case .badURL:
            return "無効なURLです"
        case .cannnotCreateURLComponents:
            return "コンポーネントが作成できませんでした"
        case .cannotCreateURL:
            return "URLが作成できませんでした"
        case .responseNotReturned:
            return "通信ができませんでした"
        case .badStatusCode(let statusCode):
            return "通信ができませんでした\(statusCode)"
        case .fetchError:
            return "解析できませんでした"
        case .cannotExportData:
            return "データをエクスポートできませんでした"
        case .couldNotCreateRequest:
            return "リクエストを作成できませんでした"
        }
    }
}
