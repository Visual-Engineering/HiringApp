//
//  AnalyticsManager.swift
//  HiringApp
//
//  Created by Margareta Kusan on 10/07/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import Foundation
import FirebaseAnalytics

class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    private init() {}
    
    func configureFirebase() {
        FirebaseApp.configure()
    }
    
    func logEventWithFirebase(name: String, parameters: [String: AnyObject]?) {
        Analytics.logEvent(name, parameters: parameters)
    }
    
    func setUserPropertyWithFirebase(object: String, name: String) {
        Analytics.setUserProperty(object, forName: name)
    }
}
