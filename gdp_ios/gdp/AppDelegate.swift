//
//  AppDelegate.swift
//  gdp
//
//  Created by edagarli on 15/12/8.
//  Copyright © 2015年 gdp. All rights reserved.
//

import UIKit
import WebKit

let gHost = "gdp98.com"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GDWebViewControllerDelegate {

    var window: UIWindow?

    // MARK: Private Properties
    var webVC = GDWebViewController()
    var navVC = UINavigationController()
    
    
    func webViewController(webViewController: GDWebViewController, didChangeTitle newTitle: NSString?) {
        navVC.navigationBar.topItem?.title = newTitle as? String
    }
    
    func webViewController(webViewController: GDWebViewController, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if let URL = navigationAction.request.URL as NSURL?,
            host = URL.host as NSString?
        {
            let testSubdomain = "." + gHost
            if host as String == gHost || host.rangeOfString(testSubdomain, options: .CaseInsensitiveSearch).location != NSNotFound {
                decisionHandler(.Allow)
                return
            }
        }
        
        print(navigationAction.request.URL?.host)
        decisionHandler(.Cancel)
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        navVC.setViewControllers([webVC], animated: false)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        webVC.delegate = self
        webVC.loadURLWithString(gHost)
        webVC.toolbar.toolbarTintColor = UIColor.darkGrayColor()
        webVC.toolbar.toolbarBackgroundColor = UIColor.whiteColor()
        webVC.toolbar.toolbarTranslucent = false
        webVC.allowsBackForwardNavigationGestures = true
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(1 * Double(NSEC_PER_SEC))),dispatch_get_main_queue(), {
//            self.webVC.showToolbar(true, animated: true)
//        })
    
//        NSThread.sleepForTimeInterval(1.0)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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


}

