//
//  ViewController.swift
//  HealthApp
//
//  Created by MisnikovRoman on 23/03/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit
import CocoaMQTT

class TestVC: UIViewController {

	var mqtt: CocoaMQTT?

	@IBOutlet weak var debugMsgLbl: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func test(_ sender: Any) {
		
	}
}

private extension TestVC {
	func connectMQTT() {
		let clientID = "CocoaMQTT-" + String(ProcessInfo().processIdentifier)
		mqtt = CocoaMQTT(clientID: clientID, host: "localhost", port: 1883)
		guard let mqtt = mqtt else {
			assertionFailure("Не удалось создать MQTT объект")
			return
		}

		mqtt.username = "test"
		mqtt.password = "public"
		mqtt.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
		mqtt.keepAlive = 60
		mqtt.delegate = self
		mqtt.connect()
	}
}

extension TestVC: CocoaMQTTDelegate {
	func mqttDidPing(_ mqtt: CocoaMQTT) {
		print("MQTT: ping")
	}

	func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
		print("MQTT: receive pong")
	}

	func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
		print("MQTT: disconnect")
	}

	func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
		print("MQTT: connect \(ack)")
	}

	func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
		print("MQTT: published message: \(message))")
	}

	func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
		print("MQTT: publish ack with id: \(id)")
	}

	func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
		print("MQTT: received message \(message) with id: \(id)")
	}

	func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
		print("MQTT: subsribed to topic: \(topic)")
	}

	func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
		print("MQTT: unsubscribed from topic: \(topic)")
	}
}
