//
//  RequestHttpBody.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import Foundation

/// メッセージをHTTPBodyに格納するための構造体です
/// JSON形式にエンコードして送信します。それ以外の用途では使用しません
struct RequestHttpBody: Codable {
    let model: String
    let messages: [Message]
}
