//
//  TPCConst.swift
//  WKCC
//
//  Created by tripleCC on 15/11/21.
//  Copyright © 2015年 tripleCC. All rights reserved.
//

import UIKit


#if GanHuoShareExtension
let TPCStatusBarHeight = CGFloat(20)
#else
let TPCStatusBarHeight: CGFloat = Swift.min(UIApplication.sharedApplication().statusBarFrame.size.height, UIApplication.sharedApplication().statusBarFrame.size.width)
#endif

let TPCNavigationBarHeight: CGFloat = 44.0
let TPCNavigationBarAndStatusBarHeight = TPCNavigationBarHeight + TPCStatusBarHeight
let TPCTabBarHeight: CGFloat = 49.0 - 1.0
let TPCScreenWidth = UIScreen.mainScreen().bounds.width
let TPCScreenHeight = UIScreen.mainScreen().bounds.height
let TPCRefreshControlOriginHeight: CGFloat = 60.0

let TPCGankIOURLString = "http://gank.io/"

let TPCTechnicalReloadDataNotification = "TPCTechnicalReloadDataNotification"
let TPCFavoriteGanHuoChangeNotification = "TPCFavoriteGanHuoChangeNotification"

let TPCCurrentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String


let TPCLoadGanHuoDataOnce: Int = 14
