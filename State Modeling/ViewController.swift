//
//  ViewController.swift
//  State Modeling
//
//  Created by Tsimafei Sikorski on 15/10/2022.
//

import UIKit



class ViewController: UIViewController {
    struct Constants {
        static let activeColorAlpha: CGFloat = 1.0
        static let inactiveColorAlpha: CGFloat = 0.2
    }

    enum TrafficLightLamp: CaseIterable {
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

        var timeout: TimeInterval {
            switch self {
            case .red:
                return 2
            case .yellow:
                return 2
            case .green:
                return 3
            }
        }
    }

    @IBOutlet private weak var redView: UIView!
    @IBOutlet private weak var yellowView: UIView!
    @IBOutlet private weak var greenView: UIView!

    private var stateMachine: TrafficLightStateMachine!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetViewColors()
        stateMachine = TrafficLightStateMachine(stateChangedCallback: handleStateChange(newState:))
        stateMachine.start()
    }

    func resetViewColors() {
        for lamp in TrafficLightLamp.allCases {
            let lampView = viewForLamp(lamp)
            lampView.backgroundColor = lamp.inactiveColor
        }
    }

    func handleStateChange(newState: TrafficLightStateMachine.TrafficLightState) {
        resetViewColors()
        switch newState {
        case .red:
            turnLamp(.red)
            Timer.scheduledTimer(withTimeInterval: TrafficLightLamp.red.timeout, repeats: false, block: { _ in self.stateMachine.redTimerElapsed()})
        case .yellow:
            turnLamp(.yellow)
            Timer.scheduledTimer(withTimeInterval: TrafficLightLamp.red.timeout, repeats: false, block: { _ in self.stateMachine.yellowTimerElapsed()})
        case .green:
            turnLamp(.green)
            Timer.scheduledTimer(withTimeInterval: TrafficLightLamp.red.timeout, repeats: false, block: { _ in self.stateMachine.greenTimerElapsed()})
        case .flashingRed:
            flashRedLight()
        }
    }
}

private extension ViewController {
    func flashRedLight() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.turnLamp(.red)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.turnOffLamp(.red)
            }
        })
    }

    func turnLamp(_ lamp: TrafficLightLamp) {
        let lampView = viewForLamp(lamp)
        lampView.backgroundColor = lamp.activeColor
    }

    func turnOffLamp(_ lamp: TrafficLightLamp) {
        let lampView = viewForLamp(lamp)
        lampView.backgroundColor = lamp.inactiveColor
    }

    func viewForLamp(_ lamp: TrafficLightLamp) -> UIView {
        switch lamp {
        case .red:
            return redView
        case .yellow:
            return yellowView
        case .green:
            return greenView
        }
    }
}

