//
//  FirebaseManager.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 1.03.2024.
//

import Firebase

class FirebaseManager {
    static let shared = FirebaseManager()

    var remoteConfig: RemoteConfig!

    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        setupDefaults()
    }

    private func setupDefaults() {
        let defaults: [String: NSObject] = [
            "splash_title": "loodos" as NSObject
        ]
        remoteConfig.setDefaults(defaults)
    }

    func fetchRemoteConfig() {
        let settings = RemoteConfigSettings()
        remoteConfig.configSettings = settings

        remoteConfig.fetch { [weak self] (status, error) in
            if status == .success {
                self?.remoteConfig.activate { _, _ in }
            } else {
                print("Error fetching remote config: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    func loodosText() -> String {
        return remoteConfig["splash_title"].stringValue ?? "loodos"
    }
}
