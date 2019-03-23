//
//  Constant.swift
//  HealthApp
//
//  Created by MisnikovRoman on 23/03/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import Foundation

struct MqttUser {
	let login: String
	let password: String
}

struct RTObject {
	let clientID: String
	let login: String
	let password: String
}

enum VC {
	static let test = "TestVC"
}

enum API {
	static let base = "https://sandbox.rightech.io/"
	static let auth = "api/v1/auth"
	static let testUser = MqttUser(login: "testApi", password: "Tr1n1tr0b3nz0l")
}

enum MQTT {
	static let host = "sandbox.rightech.io"
	static let port = 1883
	static let securePort = 8883
	static let iphoneObject = RTObject(clientID: "iphoneobjectid", login: "iphonelogin", password: "iphonepass")
}

enum MqttTopic {
	static let enable = "/state/on"
	static let heartRate = "/state/hr"
}
