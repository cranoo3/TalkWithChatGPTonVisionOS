//
//  ContentView.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ChatView(viewModel: self.viewModel)
                
                Spacer()
                
                TextFieldAndSendButtonView(viewModel: self.viewModel)
            }
            .navigationTitle("Talk With ChatGPT on VisionOS")
        }
        .padding()
        // エラーが発生した時のアラート
        .alert("エラーが発生しました", isPresented: $viewModel.isShowAlert) {
            Button(role: .cancel) {
                // 何もしないので処理はなし
            } label: {
                Text("何もしない")
            }
            Button {
                exit(-1)
            } label: {
                Text("アプリを終了する")
            }
        } message: {
            Text(viewModel.alertMessage ?? "エラーです")
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
