//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Deivid Willyan Rodrigues Fabiano on 11/12/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EmojiMemoryGame())
        }
    }
}
