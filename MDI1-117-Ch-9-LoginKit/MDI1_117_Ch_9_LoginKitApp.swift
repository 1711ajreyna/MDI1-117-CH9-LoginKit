//
//  MDI1_117_Ch_9_LoginKitApp.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import SwiftUI
import UIKit

@main
struct MDI1_117_Ch_9_LoginKitApp: App {

    init() {

        if ProcessInfo.processInfo.arguments.contains("-UITesting-Reset") {
            UIView.setAnimationsEnabled(false)
        }
        if ProcessInfo.processInfo.arguments.contains("-UITesting-NoAnimations") {
            UIView.setAnimationsEnabled(false)
        }

    }

    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
