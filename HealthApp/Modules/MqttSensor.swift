//
//  MqttSensor.swift
//  HealthApp
//
//  Created by MisnikovRoman on 23/03/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import Foundation

struct Sensor: CustomStringConvertible {
	let id: String
	let name: String
	var value: Double
	let source: String
	let units: String

	var description: String {
		return "\(name) sensor: value \(value)\(units)"
	}
}
