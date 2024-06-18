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
            print("Latitude: \(latitude), Longitude: \(longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error.localizedDescription)")
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
                print("Network unknown")
                break
            case .notReachable:
                print("Network notReachable")
                break
            case .reachableViaWWAN:
                print("Network reachableViaWWAN")
                break
            case .reachableViaWiFi:
                print("Network reachableViaWiFi")
                break
            default:
                break
            }
        }
    }
}

