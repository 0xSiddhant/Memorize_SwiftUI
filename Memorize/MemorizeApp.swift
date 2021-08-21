//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Siddhant Kumar on 21/08/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let model = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: model)
        }
    }
}
