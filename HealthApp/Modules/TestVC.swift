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

	@IBOutlet weak var heartRateLbl: UILabel!
	@IBOutlet weak var heartLbl: BeatingLabel!

	var mqttService: MqttService?

	override func viewDidLoad() {
		super.viewDidLoad()
		mainSetup()
		mqttService = RightechService(mqtt: createMQTT())
		mqttService?.connect()
		//mqttService?.subscribe(to: MqttTopic.heartRate)
	}

	@IBAction func enable(_ sender: Any) {
		mqttService?.publish(to: MqttTopic.enable, message: "on")
		mqttService?.subscribe(to: MqttTopic.heartRate)
		heartLbl.isHidden = false
		heartLbl.startBeating()
	}

	@IBAction func disable(_ sender: Any) {
		mqttService?.publish(to: MqttTopic.enable, message: "off")
		heartLbl.stopBeating()
		heartLbl.isHidden = true
	}
	@IBAction func setRandomHR(_ sender: Any) {
		showHeartRate(value: Int.random(in: 50...83))
	}
}

private extension TestVC {
	func mainSetup() {
		title = "Снятие ЭКГ"
	}

	func createMQTT() -> CocoaMQTT {
		let mqtt = CocoaMQTT(clientID: MQTT.iphoneObject.clientID,
						 host: MQTT.host,
						 port: UInt16(MQTT.port))
		mqtt.delegate = self
		return mqtt
	}

	func showHeartRate(value: Int) {
//		heartRateLbl.text = "\(value)"
	}
}

extension TestVC: CocoaMQTTDelegate {
	func mqttDidPing(_ mqtt: CocoaMQTT) {
		print("MQTT: ping")
	}

	func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
		print("MQTT: pong")
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
		//print("MQTT: received message \(message) with id: \(id)")
		guard message.topic == MqttTopic.heartRate else { return }
		let heartRateString = message.string ?? "-1"
		print("❤️", heartRateString)
		showHeartRate(value: Int(heartRateString) ?? -1)

	}

	func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
		print("MQTT: subsribed to topic: \(topic)")
	}

	func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
		print("MQTT: unsubscribed from topic: \(topic)")
	}
}
