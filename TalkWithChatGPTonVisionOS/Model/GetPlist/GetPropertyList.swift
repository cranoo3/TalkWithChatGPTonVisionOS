//
//  GetPropertyList.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import Foundation

/// plistに入力されたURL、GPTModel、APIKey、OrganizationIDを取得する構造体
struct GetPropertyList {
    static let shared = GetPropertyList()
    
    /// plistからURLの文字列を取得して返す関数
    /// - Returns: String型を返します。URLとして使用する時は変換してください
    func getUrlString() -> String{
        // plistからurlの文字列を取得
        guard let urlString = Common.shared.getValue(key: "url") else {
            return "String Converting Error"
        }
        
        return urlString
    }
    
    /// plistからGPTModelの文字列を取得して返す関数
    /// - Returns: String型を返します。URLとして使用する時は変換してください
    func getGPTModel() -> String {
        // plistからurlの文字列を取得
        guard let model = Common.shared.getValue(key: "model") else {
            return "String Converting Error"
        }
        
        return model
    }
    
    /// plistからAPIKeyを取得する関数
    /// - Returns: String型を返す
    func getApiKey() -> String {
        // plistからAPIKeyを取得
        guard let apiKey = Common.shared.getValue(key: "apikey") else {
            return "API Key Error"
        }
        
        return apiKey
    }
    
    /// plistからをOrganizationID取得する関数
    /// - Returns: String型を返す
    func getOrganizationID() -> String {
        guard let orgId = Common.shared.getValue(key: "orgId") else {
            return "Error Can't get OrganizationID"
        }
        
        return orgId
    }
}
