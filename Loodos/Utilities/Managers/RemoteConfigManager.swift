//
//  RemoteConfigManager.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 1.03.2024.
//

import FirebaseRemoteConfig

enum RemoteConfigManager {
    
    private static var remoteConfig: RemoteConfig = {
        var remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        return remoteConfig
    }()
    
    static func configure(exprationDuration: TimeInterval = 0) {
        remoteConfig.fetch(withExpirationDuration: exprationDuration) { status, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            RemoteConfig.remoteConfig().activate(completion: nil)
        }
    }
    
    static func value(forKey key: String) -> String {
        return remoteConfig.configValue(forKey: key).stringValue!
    }
}
