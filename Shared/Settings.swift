//
//  Settings.swift
//  dotclock
//
//  Created by Chris McElroy on 5/21/22.
//

import Foundation

class Settings: ObservableObject {
	static let main = Settings()
	
	@Published var dayMode = true
	@Published var minuteHand = false
}
