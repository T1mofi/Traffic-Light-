//
//  TrafficLightLampView.swift
//  State Modeling
//
//  Created by Tsimafei Sikorski on 15/10/2022.
//

import Foundation
import UIKit

struct Constants {
    static let activeColorAlpha: CGFloat = 1.0
    static let inactiveColorAlpha: CGFloat = 0.2
}

enum TrafficLightLampType: CaseIterable {
    case red
    case yellow
    case green

    private var color: UIColor {
        switch self {
        case .red:
            return .red
        case .yellow:
            return .yellow
        case .green:
            return .green
        }
    }

    var activeColor: UIColor {
        return self.color.withAlphaComponent(Constants.activeColorAlpha)
    }

    var inactiveColor: UIColor {
        return self.color.withAlphaComponent(Constants.inactiveColorAlpha)
    }
}

class TrafficLightLampView: UIView {
    var type: TrafficLightLampType = .red

    func turnOn() {
        self.backgroundColor = type.activeColor
    }

    func turnOff() {
        self.backgroundColor = type.inactiveColor
    }
}
