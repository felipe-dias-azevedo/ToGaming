//
//  StatusToIcon.swift
//  ToGaming
//
//  Created by felipe azevedo on 28/03/22.
//

import Foundation

class StatusToIcon {
    
    static func name(_ status: Game.Status?) -> String {
        switch (status) {
            case .toBuy:
                return "cart.fill"
            case .playing:
                return "play.fill"
            case .played:
                return "checkmark.circle.fill"
            case .toPlay:
                return "forward.frame.fill"
            default:
                return "questionmark.circle.fill"
        }
    }
    
    static func name(_ value: String) -> String {
        let status = Game.Status(rawValue: value)
        return name(status)
    }
}
