import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var todoViewController:TodoListTableViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSLog("Documents Directory: \(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first)")
        let nav = window!.rootViewController as! UINavigationController
        todoViewController = nav.viewControllers.first! as! TodoListTableViewController
        todoViewController.items = self.itemsFromDisk()
        return true
    }

    func applicationDidEnterBackground(application: UIApplication) {
        self.saveToDisk()
    }

    private func itemsFromDisk() -> [TodoItem] {
        return Array()
    }

    private func saveToDisk(){
        
    }

    private var pathForKeyedArchive:String {
        return (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString).stringByAppendingPathComponent("archive.bin")
    }

    // MARK: Core Data Stack
    var persistentStoreCoordinator:NSPersistentStoreCoordinator!
    var managedObjectContext:NSManagedObjectContext!
    private var pathForCoreDataStore:String {
        get {
            return (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString).stringByAppendingPathComponent("archive.sqlite")
        }
    }

    private func setupCoreDataStack(){
        let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOfURL: modelURL)!
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: NSURL(fileURLWithPath: pathForCoreDataStore), options: nil)
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    }

}