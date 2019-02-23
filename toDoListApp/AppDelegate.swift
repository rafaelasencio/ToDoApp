//
//  AppDelegate.swift
//  toDoListApp
//
//  Created by Rafael Asencio on 20/10/2018.
//  Copyright © 2018 Rafael Asencio. All rights reserved.
//

import UIKit
import  RealmSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        
        let myDatabase = FIRDatabase.database().reference()
        myDatabase.setValue("We have data")
//        print(Realm.Configuration.defaultConfiguration.fileURL)

        
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }


}

