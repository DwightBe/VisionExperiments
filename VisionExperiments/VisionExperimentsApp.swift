//
//  VisionExperimentsApp.swift
//  VisionExperiments
//
//  Created by Dwight Benignus on 7/22/24.
//

import SwiftUI

@main
struct VisionExperimentsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
