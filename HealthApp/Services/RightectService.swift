//
//  RightectService.swift
//  HealthApp
//
//  Created by MisnikovRoman on 23/03/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import Foundation
import CocoaMQTT

protocol MqttService {
	func connect()
	func disconnect()
	func publish(to topic: String, message: String)
	func subscribe(to topic: String)
}

class RightechService: MqttService {
	let mqtt: CocoaMQTT

	init(mqtt: CocoaMQTT) {
		self.mqtt = mqtt
	}

	func connect() {
		mqtt.username = MQTT.iphoneObject.login
		mqtt.password = MQTT.iphoneObject.password
		mqtt.keepAlive = 60
		mqtt.connect()
	}

	func disconnect() {
		mqtt.disconnect()
	}

	func publish(to topic: String, message: String) {
		mqtt.publish(topic, withString: message)
	}

	func subscribe(to topic: String) {
		mqtt.subscribe(topic)
	}
}
