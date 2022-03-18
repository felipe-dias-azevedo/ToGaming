//
//  ModelData.swift
//  ToGaming
//
//  Created by felipe azevedo on 18/03/22.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var userConfig = UserConfig(userName: "", clientId: "", secretKey: "")
}
