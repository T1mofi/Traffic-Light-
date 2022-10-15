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
        redView.backgroundColor = .red.withAlphaComponent(Constants.inactiveColorAlpha)
        yellowView.backgroundColor = .yellow.withAlphaComponent(Constants.inactiveColorAlpha)
        greenView.backgroundColor = .green.withAlphaComponent(Constants.inactiveColorAlpha)
    }

    func handleStateChange(newState: TrafficLightStateMachine.TrafficLightState) {
        resetViewColors()
        switch newState {
        case .red:
            redView.backgroundColor = .red.withAlphaComponent(Constants.activeColorAlpha)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in self.stateMachine.redTimerElapsed()})
        case .yellow:
            yellowView.backgroundColor = .yellow.withAlphaComponent(Constants.activeColorAlpha)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in self.stateMachine.yellowTimerElapsed()})
        case .green:
            greenView.backgroundColor = .green.withAlphaComponent(Constants.activeColorAlpha)
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in self.stateMachine.greenTimerElapsed()})
        case .flashingRed:
            resetViewColors()
            flashRedLight()
        }
    }

    func flashRedLight() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.redView.backgroundColor = .red.withAlphaComponent(Constants.activeColorAlpha)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.redView.backgroundColor = .red.withAlphaComponent(Constants.inactiveColorAlpha)
            }
        })
    }
}

