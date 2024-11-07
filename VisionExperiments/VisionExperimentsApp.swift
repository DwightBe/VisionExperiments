//
//  VisionExperimentsApp.swift
//  VisionExperiments
//
//  Created by Dwight Benignus on 7/22/24.
//

import SwiftUI
struct ContactInfo {
   let name: String
   let phoneNumber: String
    let email: String
}
@Observable
class AppData {
    var count = 0
    var contactsArray:Array<ContactInfo> = [  ContactInfo(name: "Alan Apple", phoneNumber: "(123) 555-5324", email: "alanapple@apple.com"),
                                             ContactInfo(name: "Annie Huell", phoneNumber: "(123) 555-9876", email: "anniehuell@apple.com"),
                                             ContactInfo(name: "Arlo Guthrie", phoneNumber: "(123) 555-1234", email: "arloguthrie@apple.com"),
                                             ContactInfo(name: "Ben Babbit", phoneNumber: "(125) 555-1235", email: "benbabbit@apple.com"),
                                             ContactInfo(name: "Bob Dylan", phoneNumber: "(125) 555-6667", email: "bobdylan@apple.com"),
                                             ContactInfo(name: "Charlene Greenholt", phoneNumber: "(125) 555-6117", email: "charlenegreenholt@apple.com"),
                                             ContactInfo(name: "Chaplin Charles", phoneNumber: "(125) 555-6317", email: "chaplincharles@apple.com"),
                                             ContactInfo(name: "Drew Cole", phoneNumber: "(125) 555-1417", email: "drewcole@apple.com"),
                                             ContactInfo(name: "Erin Eagle", phoneNumber: "(125) 555-1477", email: "erineagle@apple.com"),
                                             ContactInfo(name: "Fred Flintstone", phoneNumber: "(125) 555-1479", email: "fredflintstone@apple.com"),
                                             ContactInfo(name: "Grady Jones", phoneNumber: "(125) 555-1479", email: "gradyjones@apple.com"),
                                             ContactInfo(name: "James Jameson", phoneNumber: "(125) 555-1999", email: "jamesjameson@apple.com"),
                                             ContactInfo(name: "Ken Coolidge", phoneNumber: "(125) 555-1969", email: "kencoolidge@apple.com"),
                                             ContactInfo(name: "Logan Jones", phoneNumber: "(125) 555-1989", email: "loganjones@apple.com"),
                                             ContactInfo(name: "Milton Martin", phoneNumber: "(125) 555-2069", email: "miltonmartin@apple.com"),
                                             ContactInfo(name: "Orlando Brine", phoneNumber: "(125) 555-2269", email: "orlandobrine@apple.com"),
                                             ContactInfo(name: "Priya Runchal", phoneNumber: "(125) 555-2569", email: "priyapardo@apple.com"),
                                             ContactInfo(name: "Randy Marsh", phoneNumber: "(125) 555-3569", email: "randymarsh@apple.com"),
                                             ContactInfo(name: "Sally Smith", phoneNumber: "(125) 555-5569", email: "sallysmith@apple.com"),
                                             ContactInfo(name: "Tim Apple", phoneNumber: "(125) 555-1169", email: "timapple@apple.com"),
                                             ContactInfo(name: "Tina Mitchell", phoneNumber: "(125) 555-1111", email: "tinamitchell@apple.com"),
                                             ContactInfo(name: "Valerie Vix", phoneNumber: "(125) 555-2222", email: "valerievix@apple.com"),
                                             ContactInfo(name: "Zachary Bean", phoneNumber: "(125) 555-3333", email: "zacharybean@apple.com"),
                                       ]
}

@main
struct VisionExperimentsApp: App {
    @State var appData = AppData()

    var body: some Scene {
        WindowGroup {
            ContentView(appData: appData)
        }
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(appData: appData )
        }
    }
}
