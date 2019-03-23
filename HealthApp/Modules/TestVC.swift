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

	var mqttService: MqttService?

	override func viewDidLoad() {
		super.viewDidLoad()
		mqttService = RightechService(mqtt: createMQTT())
		mqttService?.connect()
		//mqttService?.subscribe(to: MqttTopic.heartRate)
	}

	@IBAction func enable(_ sender: Any) {
		mqttService?.publish(to: MqttTopic.enable, message: "on")
	}

	@IBAction func disable(_ sender: Any) {
		mqttService?.publish(to: MqttTopic.enable, message: "off")
	}
}

private extension TestVC {
	func createMQTT() -> CocoaMQTT {
		let mqtt = CocoaMQTT(clientID: MQTT.iphoneObject.clientID,
						 host: MQTT.host,
						 port: UInt16(MQTT.port))
		mqtt.delegate = self
		return mqtt
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
		print("MQTT: disconnect with error: \(err?.localizedDescription ?? "...")")
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
