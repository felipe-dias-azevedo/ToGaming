//
//  UserConfigHelper.swift
//  ToGaming
//
//  Created by felipe azevedo on 10/04/22.
//

import Foundation
import CoreData

class UserConfigHelper {
    
    static func convert(_ user: UserConfig, _ context: NSManagedObjectContext) -> UserConfigCore {
        let userConfig = UserConfigCore(context: context)
        userConfig.clientId = user.clientId
        userConfig.preferredPlatform = user.preferredPlatform
        userConfig.secretKey = user.secretKey
        userConfig.userName = user.userName
        return userConfig
    }
    
    static func convert(_ userConfig: UserConfigCore) -> UserConfig {
        return UserConfig(
            userName: userConfig.userName!,
            preferredPlatform: userConfig.preferredPlatform!,
            clientId: userConfig.clientId!,
            secretKey: userConfig.secretKey!)
    }
}
