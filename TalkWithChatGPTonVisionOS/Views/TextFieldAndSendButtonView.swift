//
//  SendMessageView.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import SwiftUI

struct TextFieldAndSendButtonView: View {
    @ObservedObject var viewModel: ContentViewModel
    @FocusState var focus: Bool
    
    var body: some View {
        ZStack {
            HStack {
                // テキストフィールド
                TextField("送信するテキストを入力", text: $viewModel.content)
                    .textFieldStyle(.roundedBorder)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .focused($focus)
                    .onSubmit {
                        if viewModel.fetchDecision() {
                            viewModel.fetchData()
                        }
                    }
                
                Button {
                    // キーボードのフォーカスを外す
                    focus = false
                    // データ取得
                    if viewModel.fetchDecision() {
                        viewModel.fetchData()
                    }
                } label: {
                    Image(systemName: "paperplane")
                        .font(.title)
                }
                .disabled(!viewModel.fetchDecision())
            }
            .padding(5)
            
        }
        .background(content: {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.background)
        })
    }
}

#Preview {
    TextFieldAndSendButtonView(viewModel: ContentViewModel())
}
