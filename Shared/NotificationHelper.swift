//
//  NotificationHelper.swift
//  dotclock
//
//  Created by Chris McElroy on 5/28/22.
//

import SwiftUI

struct Notifications {
	static func ifAllowed(_ run: @escaping () -> Void) {
		let current = UNUserNotificationCenter.current()
		current.getNotificationSettings(completionHandler: { settings in
			if settings.authorizationStatus == .authorized {
				run()
			}
		})
	}
	
	static func ifUndetermined(_ run: @escaping () -> Void) {
		let current = UNUserNotificationCenter.current()
		current.getNotificationSettings(completionHandler: { settings in
			if settings.authorizationStatus == .notDetermined {
				run()
			}
		})
	}
	
	static func ifDenied(_ run: @escaping () -> Void) {
		let current = UNUserNotificationCenter.current()
		current.getNotificationSettings(completionHandler: { settings in
			if settings.authorizationStatus == .denied {
				run()
			}
		})
	}
	
	static func turnOn(callBack: @escaping (Bool) -> Void = {_ in }) {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
			if let error = error { print(error.localizedDescription) }
			callBack(success)
		}
	}
}
