//
//  ChatView.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ContentViewModel
    // ScrollViewを一番下まで移動させるためのID
    @Namespace var bottomId
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    ForEach(MessageManager.shared.messages, id: \.self) { message in
                        // 誰から送信されたかで表示されるViewを分ける
                        if message.role == "user" {
                            // 送信したメッセージのロールが"ユーザー"だった場合
                            // 送信したメッセージ
                            SendChatView(content: message.content)
                            
                        } else if message.role == "assistant" {
                            // 受け取った文字列
                            ReceivedMessagesView(content: message.content)
                        }
                    }
                    
                    
                    // フェッチ中はProgressViewを表示する
                    if viewModel.isFetched {
                        ProgressView()
                    }
                    
                    // 一番下に表示されている透明なView
                    // TextViewの下の部分に空間を開けるためにも使用しています
                    VStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 70)
                            .id(bottomId)
                    }
                }
            }
            .onChange(of: MessageManager.shared.messages) { _, _ in
                withAnimation(.spring) {
                    // viewModel.messageManager.messagesの値が変更された時、一番下まで移動する
                    proxy.scrollTo(bottomId)
                }
            }
        }
    }
}

#Preview {
    ChatView(viewModel: ContentViewModel())
}
