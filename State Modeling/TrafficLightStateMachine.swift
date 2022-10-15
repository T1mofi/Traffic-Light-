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
        case redAndYellow
        case green
        case yellow
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

    func redTimerElapsed() {
        switch state {
        case .red:
            state = .redAndYellow
        case .redAndYellow, .yellow, .green, .flashingRed:
            print("Error: Invalid state transition")
            state = .flashingRed
        }
    }

    func redAndYelloyTimerElapsed() {
        switch state {
        case .redAndYellow:
            state = .green
        case .red, .yellow, .green, .flashingRed:
            print("Error: Invalid state transition")
            state = .flashingRed
        }
    }

    func greenTimerElapsed() {
        switch state {
        case .green:
            state = .yellow
        case .red, .redAndYellow, .yellow, .flashingRed:
            print("Error: Invalid state transition")
            state = .flashingRed
        }
    }

    func yellowTimerElapsed() {
        switch state {
        case .yellow:
            state = .red
        case .red, .redAndYellow, .green, .flashingRed:
            print("Error: Invalid state transition")
            state = .flashingRed
        }
    }

}
