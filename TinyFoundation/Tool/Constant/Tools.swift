//
//  Tools.swift
//  TinyFoundation
//
//  Created by JY on 16/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

func getCurrentTimeStamp() -> String {
    let nowDate = Date.init()
    //10位数时间戳
    let interval = Int(nowDate.timeIntervalSince1970)
    //13位数时间戳 (13位数的情况比较少见)
    // let interval = CLongLong(round(nowDate.timeIntervalSince1970*1000))
    return "\(interval)"
}

func getWindow() -> UIWindow? {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    return delegate.keyWindows()
}

func getSplitViewController() -> UISplitViewController {
    guard
      let splitViewController = getWindow()?.rootViewController as? UISplitViewController
      else { fatalError() }
    return splitViewController
}
func getPrimaryViewController() -> PrimaryTableViewController {
    guard
      let splitViewController = getWindow()?.rootViewController as? UISplitViewController,
      let primaryViewController = (splitViewController.viewControllers[0] as? UINavigationController)?.topViewController as? PrimaryTableViewController
      else { fatalError() }
    return primaryViewController
}
func getPrimaryNavViewController() -> UINavigationController {
    guard
      let splitViewController = getWindow()?.rootViewController as? UISplitViewController,
      let primaryNavViewController = splitViewController.viewControllers[0] as? UINavigationController
      else { fatalError() }
    return primaryNavViewController
}
func getSuppleMentViewController() -> SupplementViewController {
    guard
      let splitViewController = getWindow()?.rootViewController as? UISplitViewController,
      let suppleMentViewController = (splitViewController.viewControllers[1] as? UINavigationController)?.topViewController as? SupplementViewController
      else { fatalError() }
    return suppleMentViewController
}
func getSuppleMentNavViewController() -> UINavigationController {
    guard
      let splitViewController = getWindow()?.rootViewController as? UISplitViewController,
      let suppleMentNavViewController = splitViewController.viewControllers[1] as? UINavigationController
      else { fatalError() }
    return suppleMentNavViewController
}
func getSecondaryViewController() -> SecondaryViewController {
    guard
      let splitViewController = getWindow()?.rootViewController as? UISplitViewController,
      let secondaryViewController = (splitViewController.viewControllers[2] as? UINavigationController)?.topViewController as? SecondaryViewController
      else { fatalError() }
    return secondaryViewController
}
func getSecondaryNavViewController() -> UINavigationController {
    guard
      let splitViewController = getWindow()?.rootViewController as? UISplitViewController,
      let secondaryNavViewController = splitViewController.viewControllers[2] as? UINavigationController
      else { fatalError() }
    return secondaryNavViewController
}
