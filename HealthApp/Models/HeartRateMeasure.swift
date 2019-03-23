//
//  HeartRateMeasure.swift
//  HealthApp
//
//  Created by MisnikovRoman on 23/03/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import Foundation

struct HeartRateMeasure {
	let date: Date
	let value: Int

	func getDate() -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd MM hh:mm"
		formatter.locale = Locale(identifier: "ru_RU")
		return formatter.string(from: date)
	}
}
