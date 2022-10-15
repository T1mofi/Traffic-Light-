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
    static let inactiveColorAlpha: CGFloat = 0.4
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
    var type: TrafficLightLampType = .red {
        didSet {
            resetColor()
        }
    }
    var colorView: UIView

    // TODO: - Review initialization logic
    override init(frame: CGRect) {
        self.colorView = UIView()
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        self.colorView = UIView()
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        self.backgroundColor = .black
        self.addSubview(colorView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.frame = self.bounds
        self.layer.cornerRadius = self.frame.height / 2
        colorView.layer.cornerRadius = self.layer.cornerRadius
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.systemGray.cgColor
    }

    func turnOn() {
        colorView.backgroundColor = type.activeColor
    }

    func turnOff() {
        colorView.backgroundColor = type.inactiveColor
    }

    func resetColor() {
        colorView.backgroundColor = type.inactiveColor
    }
}
