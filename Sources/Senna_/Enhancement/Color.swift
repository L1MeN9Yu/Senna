//
// Created by Mengyu Li on 2020/8/12.
//

public struct Color {
	let red: UInt8
	let green: UInt8
	let blue: UInt8
}

extension Color: EscapeCode {
	public var value: [UInt8] {
		[red, green, blue]
	}
}

// MARK: - Text Color

public extension Color {
	static let traceText = Color(red: 150, green: 150, blue: 150)
}

// MARK: - Background Color

public extension Color {
	static let criticalBackground = Color(red: 255, green: 0, blue: 0)
}
