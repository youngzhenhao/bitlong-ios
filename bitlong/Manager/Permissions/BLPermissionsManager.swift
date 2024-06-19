//
//  BLPermissionsManager.swift
//  bitlong
//
//  Created by 微链通 on 2024/5/8.
//

import CoreLocation

@objcMembers class BLPermissionsManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = BLPermissionsManager()
    
    override init() {
        super.init()
    }
    
    /*
     Location 定位
     */
    func requestLocation(){
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            NSSLog(msg: "Latitude: \(latitude), Longitude: \(longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSSLog(msg: String.init(format: "Failed to get user's location: \(error.localizedDescription)"))
    }
    
    /*
     Network 网络
     */
    func requestNetwork(){
        let manager : AFNetworkReachabilityManager = AFNetworkReachabilityManager.shared()
        manager.startMonitoring()
        manager.setReachabilityStatusChange { status in
            switch (status) {
            case .unknown:
                NSSLog(msg: "Network unknown")
                break
            case .notReachable:
                NSSLog(msg: "Network notReachable")
                break
            case .reachableViaWWAN:
                NSSLog(msg: "Network reachableViaWWAN")
                break
            case .reachableViaWiFi:
                NSSLog(msg: "Network reachableViaWiFi")
                break
            default:
                break
            }
        }
    }
}

