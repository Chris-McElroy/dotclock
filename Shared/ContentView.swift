//
//  ContentView.swift
//  Shared
//
//  Created by Chris McElroy on 5/17/22.
//

import SwiftUI

struct ContentView: View {
	@State var time: Int = 0
	@State var mode: Mode = .brightness
	@State var brightness: Double = 1.0
	@State var alarm: Int? = nil
	@State var timeOffset: Int = 0
	@State var flash: Bool = true
	@State var lastTime: Int = 0
	@State var timer: Bool = false
	@State var timerOffset = 0
	@State var zoomingTimer: Timer? = nil
	@ObservedObject var settings = Settings.main
	
    var body: some View {
//		VStack(spacing: 0) {
//			Spacer()
//			HStack(spacing: 0) {
//				Spacer()
//				Circle()
//					.foregroundColor(.black)
//					.shadow(color: .white, radius: 4, x: 0, y: 0)
//					.frame(width: 35)
//					.onTapGesture {
//						if let zoomingTimer = zoomingTimer {
//							zoomingTimer.invalidate()
//							self.zoomingTimer = nil
//							return
//						}
//						switch mode {
//						case .brightness:
//							mode = .alarm
//						case .alarm, .time, .alerting:
//							mode = .brightness
//						}
//					}
//				Spacer().frame(width: 40)
//				Circle()
//					.foregroundColor(.black)
//					.shadow(color: .white, radius: 4, x: 0, y: 0)
//					.frame(width: 35)
//					.onTapGesture {
//						if let zoomingTimer = zoomingTimer {
//							zoomingTimer.invalidate()
//							self.zoomingTimer = nil
//							return
//						}
//						switch mode {
//						case .brightness:
//							mode = .time
//						case .alarm, .time, .alerting:
//							mode = .brightness
//						}
//					}
//				Spacer().frame(width: 40)
//				Circle()
//					.foregroundColor(.black)
//					.shadow(color: .white, radius: 4, x: 0, y: 0)
//					.frame(width: 35)
//					.onTapGesture {
//						if let zoomingTimer = zoomingTimer {
//							zoomingTimer.invalidate()
//							self.zoomingTimer = nil
//							return
//						}
//						switch mode {
//						case .brightness:
//							brightness = min(1, brightness + 0.1)
//						case .alarm:
//							if alarm == nil {
//								alarm = time
//							}
//							alarm! += 1
//						case .time:
//							timeOffset += 1
//							getTime()
//						case .alerting:
//							mode = .brightness
//						}
//					}
//					.onLongPressGesture {
//						zoomingTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: { _ in
//							switch mode {
//							case .brightness:
//								brightness = min(1, brightness + 0.1)
//								if brightness == 1 { zoomingTimer?.invalidate() }
//							case .alarm:
//								if alarm == nil {
//									alarm = time
//								}
//								alarm! += 1
//							case .time:
//								timeOffset += 1
//								getTime()
//							case .alerting:
//								return
//							}
//						})
//					}
//				Spacer().frame(width: 40)
//				Circle()
//					.foregroundColor(.black)
//					.shadow(color: .white, radius: 4, x: 0, y: 0)
//					.frame(width: 35)
//					.onTapGesture {
//						if let zoomingTimer = zoomingTimer {
//							zoomingTimer.invalidate()
//							self.zoomingTimer = nil
//							return
//						}
//						switch mode {
//						case .brightness:
//							brightness = max(0, brightness - 0.1)
//						case .alarm:
//							if alarm == nil {
//								alarm = time
//							}
//							alarm! -= 1
//						case .time:
//							timeOffset -= 1
//							getTime()
//						case .alerting:
//							mode = .brightness
//							alarm = nil
//						}
//					}
//					.onLongPressGesture {
//						zoomingTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: { _ in
//							switch mode {
//							case .brightness:
//								brightness = max(0, brightness - 0.1)
//								if brightness == 0 { zoomingTimer?.invalidate() }
//							case .alarm:
//								if alarm == nil {
//									alarm = time
//								}
//								alarm! -= 1
//							case .time:
//								timeOffset -= 1
//								getTime()
//							case .alerting:
//								return
//							}
//						})
//					}
//				Spacer()
//			}
//			.opacity(max(brightness, 0.4))
//			.frame(height: 60)
//			Spacer().frame(height: 50)
		VStack(spacing: 0) {
			Spacer().frame(height: 22)
			Spacer()
			if timer {
				HStack {
					Spacer()
					Circle()
						.foregroundColor(getColor(time: timerOffset - time, mod: 8, div: 180))
						.frame(width: 30, height: 30)
						.onTapGesture {
							timerOffset += 180
						}
					Circle()
						.foregroundColor(getColor(time: timerOffset - time, mod: 6, div: 30))
						.frame(width: 30, height: 30)
						.onTapGesture {
							timerOffset += 30
						}
					Circle()
						.foregroundColor(getColor(time: timerOffset - time, mod: 6, div: 5))
						.frame(width: 30, height: 30)
						.onTapGesture {
							timerOffset += 5
						}
					Circle()
						.foregroundColor(getColor(time: timerOffset - time, mod: 5, div: 1))
						.frame(width: settings.minuteHand ? 30 : 0, height: 30)
						.onTapGesture {
							timerOffset += 1
						}
					Spacer()
				}
				.frame(height: 30)
				Spacer().frame(height: 20)
			}
			HStack(spacing: 10) {
				Spacer()
				Circle()
					.foregroundColor(getColor(time: time, mod: settings.dayMode ? 8 : 4, div: 180))
					.frame(width: 30, height: 30)
					.onTapGesture {
						settings.dayMode.toggle()
					}
				Circle()
					.foregroundColor(getColor(time: time, mod: 6, div: 30))
					.frame(width: 30, height: 30)
					.onTapGesture {
						if timer {
							timer = false
							lastTime = timerOffset - time
						} else {
							timerOffset = time + lastTime
							timer = true
						}
					}
				Circle()
					.foregroundColor(getColor(time: time, mod: 6, div: 5))
					.frame(width: 30, height: 30)
					.onTapGesture {
						Settings.main.minuteHand.toggle()
					}
				Circle()
					.foregroundColor(getColor(time: time, mod: 5, div: 1))
					.frame(width: settings.minuteHand ? 30 : 0, height: 30)
				
				Spacer()
			}
			.frame(height: 30)
			Spacer()
		}
		.onAppear {
			getTime()
			Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
				getTime()
			})
		}
    }
	
	func getColor(time: Int, mod: Int, div: Int) -> Color {
		let disp = mode == .alarm ? alarm ?? time : time
		
		return [
			Color(.displayP3, red: 0.9, green: 0.1, blue: 0.1, opacity: 1.0),
			Color(.displayP3, red: 1.0, green: 1.0, blue: 0.0, opacity: 1.0),
			Color(.displayP3, red: 0.0, green: 1.0, blue: 0.0, opacity: 1.0),
			Color(.displayP3, red: 0.0, green: 1.0, blue: 1.0, opacity: 1.0),
			Color(.displayP3, red: 0.1, green: 0.35, blue: 1.0, opacity: 1.0),
			Color(.displayP3, red: 1.0, green: 0.0, blue: 1.0, opacity: 1.0),
			Color(.displayP3, red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0),
			Color(.displayP3, red: 0.0, green: 0.0, blue: 0.0, opacity: 1.0)
		][(((disp/div) % mod) + mod) % mod]
	}
	
	func getTime() {
		let hours = Calendar.current.component(.hour, from: Date())
		let minutes = Calendar.current.component(.minute, from: Date())
		time = minutes + 60*hours + timeOffset
		
		flash = Calendar.current.component(.second, from: Date()) % 2 == 0
		
		if time == alarm {
			mode = .alerting
			alarm = nil
		}
	}
	
	enum Mode {
		case brightness, time, alarm, alerting
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.previewInterfaceOrientation(.landscapeLeft)
    }
}
