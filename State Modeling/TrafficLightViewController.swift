//
//  TrafficLightViewController.swift
//  State Modeling
//
//  Created by Tsimafei Sikorski on 15/10/2022.
//

import UIKit

class TrafficLightViewController: UIViewController {
    struct Constants {
        static let redLightTimeout: TimeInterval = 2
        static let redAndYellowLightTimeout: TimeInterval = 1
        static let greenLightTimeout: TimeInterval = 3
        static let yellowLightTimeout: TimeInterval = 1
        static let redLightFlashTimeout: TimeInterval = 1
    }

    // TODO: - Incapsulate trafficLightView
    @IBOutlet private weak var trafficLightView: UIView!
    @IBOutlet private weak var redLamp: TrafficLightLampView! { didSet { redLamp.type = .red }}
    @IBOutlet private weak var yellowLamp: TrafficLightLampView! { didSet { yellowLamp.type = .yellow }}
    @IBOutlet private weak var greenLamp: TrafficLightLampView! { didSet { greenLamp.type = .green }}

    private var stateMachine: TrafficLightStateMachine!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetViewColors()
        stateMachine = TrafficLightStateMachine(stateChangedCallback: handleStateChange(newState:))
        stateMachine.start()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        trafficLightView.layer.cornerRadius = trafficLightView.frame.width / 4
        trafficLightView.layer.borderWidth = 2.0
        trafficLightView.layer.borderColor = UIColor.systemGray.cgColor
    }

    func resetViewColors() {
        redLamp.turnOff()
        yellowLamp.turnOff()
        greenLamp.turnOff()
    }

    func handleStateChange(newState: TrafficLightStateMachine.TrafficLightState) {
        resetViewColors()
        switch newState {
        case .red:
            redLamp.turnOn()
            Timer.scheduledTimer(withTimeInterval: Constants.redLightTimeout, repeats: false, block: { _ in self.stateMachine.redTimerElapsed()})
        case .redAndYellow:
            redLamp.turnOn()
            yellowLamp.turnOn()
            Timer.scheduledTimer(withTimeInterval: Constants.redAndYellowLightTimeout, repeats: false, block: { _ in self.stateMachine.redAndYelloyTimerElapsed()})
        case .green:
            greenLamp.turnOn()
            Timer.scheduledTimer(withTimeInterval: Constants.greenLightTimeout, repeats: false, block: { _ in self.stateMachine.greenTimerElapsed()})
        case .yellow:
            yellowLamp.turnOn()
            Timer.scheduledTimer(withTimeInterval: Constants.yellowLightTimeout, repeats: false, block: { _ in self.stateMachine.yellowTimerElapsed()})
        case .flashingRed:
            flashRedLight()
        }
    }
}

private extension TrafficLightViewController {
    func flashRedLight() {
        Timer.scheduledTimer(withTimeInterval: Constants.redLightFlashTimeout, repeats: true, block: { _ in
            self.redLamp.turnOn()
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.redLightFlashTimeout / 2) {
                self.redLamp.turnOff()
            }
        })
    }
}

