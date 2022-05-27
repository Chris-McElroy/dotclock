//
//  dotclockApp.swift
//  Shared
//
//  Created by Chris McElroy on 5/17/22.
//

import SwiftUI

@main
struct dotclockApp: App {
    var body: some Scene {
		WindowGroup {
			ContentView()
				.background(.black)
				.onAppear {
					if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first {
						window.rootViewController?.view.backgroundColor = .black
					}
				}
		}
    }
}
public extension UIApplication {

	func clearLaunchScreenCache() {
		do {
			try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
		} catch {
			print("Failed to delete launch screen cache: \(error)")
		}
	}

}
