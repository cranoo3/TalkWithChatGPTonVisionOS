//
//  SendChatView.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import SwiftUI

struct SendChatView: View {
    let content: String
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("YOU")
                
                Text(content)
                    .padding()
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .frame(maxDepth: 30)
                    .frame(maxWidth: 500, alignment: .trailing)
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    SendChatView(content: "ユーザーが送信したテキスト\nこんにちは")
}
