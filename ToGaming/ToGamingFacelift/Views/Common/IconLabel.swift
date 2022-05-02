//
//  IconLabel.swift
//  ToGamingFacelift
//
//  Created by felipe azevedo on 02/05/22.
//

import SwiftUI

struct IconLabel: View {
    
    let title: String
    let icon: IconSymbol
    
    var body: some View {
        Label(title, systemImage: icon.rawValue)
    }
}

struct IconLabel_Previews: PreviewProvider {
    static var previews: some View {
        IconLabel(title: "Gear", icon: .gear)
    }
}
