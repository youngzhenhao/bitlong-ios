//
//  BLConfig.swift
//  TVLive
//
//  Created by Slc on 2020/9/29.
//  Copyright © 2020 dianshijia_ios. All rights reserved.
//

import Foundation

var SCREEN_HEIGHT       =   UIScreen.main.bounds.size.height
var SCREEN_WIDTH        =   UIScreen.main.bounds.size.width

var StatusBarHeight     =   (BLTools.haveDynamicIsland() ? 54.0 : ((isiphoneX() ? 44.0 : 20.0)))
var Device              =   UIDevice.current
var SCALE               =   (Device.userInterfaceIdiom == .pad ? SCREEN_WIDTH/768 : SCREEN_WIDTH/375)
var SafeAreaBottomHeight  =  (isiphoneX() ? 34.0 : 0)
//tabBar的高度
var TabBarHeight = (isiphoneX() ? 83.0 : 49.0)
//导航栏的高度
var NavBarHeight = (BLTools.haveDynamicIsland() ? 59.0 : 44.0)
//状态栏和导航栏的高度
var TopHeight  = (StatusBarHeight + NavBarHeight)

var appDelegate : BLAppDelegate = UIApplication.shared.delegate as! BLAppDelegate

var userDefaults = UserDefaults.standard

func COLORFROMRGB(r:CGFloat,_ g:CGFloat,_ b:CGFloat, alpha:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
}

/****************************************************************
                     颜色
 ******************************************************************/

func UIColorRGBA(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat) -> UIColor{
    return UIColor.init(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}

func UIColorHex(hex: Int,a:CGFloat) -> (UIColor) {
        return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0,
                 green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0,
                  blue: ((CGFloat)(hex & 0xFF)) / 255.0,
                  alpha: a)
}

//
///****************************************************************
//                        字体
// ******************************************************************/
func FONT_NORMAL(s:Float) -> UIFont{
    return UIFont.systemFont(ofSize: CGFloat(s))
}

func FONT_BOLD(s:Float) -> UIFont{
    return UIFont.init(name:"Helvetica-Bold", size: CGFloat(s))!
}

func MainThemeColor() -> (UIColor) {
    return UIColorHex(hex: 0x2469FE,a: 1.0)
}

func imagePic(name : String) -> UIImage{
    return UIImage(named: name)!
}

func isiphoneX() -> Bool {
    if 812.0 <= SCREEN_HEIGHT && Device.userInterfaceIdiom == .phone {
        return true;
    }
    return false;
}

func isipad() -> Bool {
    if Device.userInterfaceIdiom == .pad {
        return true;
    }
    return false;
}

func NSSLog<T>(msg: T) {
#if DEBUG
    print(msg)
#endif
}

func KNSDocumentPath(name : String) -> String{
    let pathArr : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
    let pathStr : NSString = pathArr.lastObject as! NSString
    return pathStr.appendingPathComponent(name)
}


/*
 typealias
 */
typealias ChangePasswordBlock = () ->()
