//
//  ReceivedMessagesView.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import SwiftUI

struct ReceivedMessagesView: View {
    let content: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(GetPropertyList.shared.getGPTModel())
                    .textCase(.uppercase)
                
                Text(content)
                    .padding()
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .frame(maxWidth: 500, alignment: .leading)
                
            }
            .padding(.bottom)
            
            Spacer()
        }
    }
}

#Preview {
    ReceivedMessagesView(content: "受信したメッセージを表示します\nこんにちは")
}
