//
//  ContentView.swift
//  VisionExperiments
//
//  Created by Dwight Benignus on 7/22/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var appData: AppData
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    var body: some View {
        let contactsName = appData.count >= 0 ? appData.contactsArray[appData.count].name : appData.contactsArray[appData.contactsArray.count + appData.count].name
        VStack {
            Text("\(contactsName)")
                .foregroundStyle(.yellow)
                .font(.custom("Menlo", size: 100))
                .bold()
        }
        .task {
            await openImmersiveSpace(id: "ImmersiveSpace" )
        }
    }

}

#Preview(windowStyle: .automatic) {
    ContentView(appData: AppData())
}
