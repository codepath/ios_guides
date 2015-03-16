//
//  AppDelegate.swift
//  PeristenceDemo
//
//  Created by Ben Sandofsky on 3/14/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var todoViewController:TodoListTableViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSLog("Documents Directory: \(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first)")
        let nav = window!.rootViewController as UINavigationController
        todoViewController = nav.viewControllers.first! as TodoListTableViewController
        todoViewController.items = self.itemsFromDisk()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {
        self.saveToDisk()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    private func itemsFromDisk() -> [TodoItem] {
        return Array()
    }

    private func saveToDisk(){
        
    }

    private var pathForKeyedArchive:String {
        get {
            return (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as NSString).stringByAppendingPathComponent("archive.bin")
        }
    }

    // MARK: Core Data Stack
    private var pathForCoreDataStore:String {
        get {
            return (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as NSString).stringByAppendingPathComponent("archive.sqlite")
        }
    }

    var persistentStoreCoordinator:NSPersistentStoreCoordinator!
    var managedObjectContext:NSManagedObjectContext!

    private func setupCoreDataStack(){
        let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOfURL: modelURL)!
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: NSURL(fileURLWithPath: pathForCoreDataStore), options: nil, error: nil)
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    }

}