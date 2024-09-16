//
//  CampusLostAndFoundApp.swift
//  CampusLostAndFound
//
//  Created by Vrishin Patel on 9/15/24.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import MapKit

@main
struct CampusLostAndFoundApp: App {
    // Register AppDelegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
