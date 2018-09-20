//
//  AppDelegate.swift
//  MOJ
//
//  Created by patcharat on 3/26/2560 BE.
//  Copyright © 2560 patcharats. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let SW_REVEAL_VIEW_CONTROLLER = "SWRevealViewController"
    let HOWTO_VIEW_CONTROLLER = "HowToViewController"
    let FACEBOOK_APP_ID = "1803458506649088"
    let account = AccountData()

    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        setupNavigationBar()
        IQKeyboardManager.sharedManager().enable = true
        FBSDKSettings.setAppID(FACEBOOK_APP_ID)
        setRootView(isShowHowto: account.isShowHowto())

        if #available(iOS 9.0, *) {
            let attributes = [
                NSForegroundColorAttributeName : UIColor.black,
                NSFontAttributeName : UIFont(name: "Quark-Bold", size: 17)
            ]
            UIBarButtonItem.appearance(whenContainedInInstancesOf:[UISearchBar.self]).tintColor = UIColor.blue
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).leftView = nil
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "Quark-Bold", size: 17 )
            UISearchBar.appearance().searchTextPositionAdjustment = UIOffsetMake(10, 0)
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        
        
    }

    func setRootView(isShowHowto:Bool){
        let rootView:String
        
        if isShowHowto{
            rootView = SW_REVEAL_VIEW_CONTROLLER
        }
        else{
            rootView = HOWTO_VIEW_CONTROLLER
        }
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = mainStoryBoard.instantiateViewController(withIdentifier:rootView)
        if let window = self.window{
            window.rootViewController =  rootViewController
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    
    
    func setupNavigationBar(){
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "Quark-Bold", size: 20)!,
            NSForegroundColorAttributeName : UIColor.white
        ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSFontAttributeName : UIFont(name: "Quark-Bold", size: 20)!,
                NSForegroundColorAttributeName : UIColor.white
            ],
            for: .normal)
        
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MOJ")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }

}

