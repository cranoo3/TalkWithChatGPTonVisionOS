//
//  TalkWithChatGPTonVisionOSApp.swift
//  TalkWithChatGPTonVisionOS
//
//  Created by cranoo on 2024/02/08.
//

import SwiftUI

@main
struct TalkWithChatGPTonVisionOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        .immersionStyle(selection: .constant(.progressive), in: .progressive)
    }
}
