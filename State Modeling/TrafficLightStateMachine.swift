//
//  TrafficLightStateMachine.swift
//  State Modeling
//
//  Created by Tsimafei Sikorski on 15/10/2022.
//

import Foundation
import UIKit

class TrafficLightStateMachine {
    enum TrafficLightState {
        case red
        case yellow
        case green
        case flashingRed
    }

    // Public
    let stateChangedCallback: (TrafficLightState) -> Void

    // Private
    private var state: TrafficLightState = .green {
        didSet {
            stateChangedCallback(state)
        }
    }

    init(stateChangedCallback: @escaping (TrafficLightState) -> Void) {
        self.stateChangedCallback = stateChangedCallback
    }

    func start() {
        stateChangedCallback(state)
    }

    func greenTimerElapsed() {
        switch state {
        case .green:
            state = .yellow
        case .yellow,.red, .flashingRed:
            print("Error: Invalid state transition")
            state = .flashingRed
        }
    }

    func yellowTimerElapsed() {
        switch state {
        case .yellow:
            state = .red
        case .green,.red, .flashingRed:
            print("Error: Invalid state transition")
            state = .flashingRed
        }
    }

    func redTimerElapsed() {
        switch state {
        case .red:
            state = .green
        case .green,.yellow, .flashingRed:
            print("Error: Invalid state transition")
            state = .flashingRed
        }
    }
}
