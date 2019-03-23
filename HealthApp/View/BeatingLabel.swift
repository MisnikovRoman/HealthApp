//
//  BeatingLabel.swift
//  HealthApp
//
//  Created by MisnikovRoman on 23/03/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit

protocol HeartAnimatable where Self: UIView {
	func startBeating()
	func stopBeating()
}

extension HeartAnimatable {
	func startBeating() {
		let pulse1 = CASpringAnimation(keyPath: "transform.scale")
		pulse1.duration = 0.6
		pulse1.fromValue = 1.0
		pulse1.toValue = 1.12
		pulse1.autoreverses = true
		pulse1.repeatCount = 1
		pulse1.initialVelocity = 0.5
		pulse1.damping = 0.8

		let animationGroup = CAAnimationGroup()
		animationGroup.duration = 2.7
		animationGroup.repeatCount = 1000
		animationGroup.animations = [pulse1]

		self.layer.add(animationGroup, forKey: "pulse")
	}

	func stopBeating() {
		self.layer.removeAllAnimations()
	}
}

class BeatingLabel: UILabel, HeartAnimatable { }
