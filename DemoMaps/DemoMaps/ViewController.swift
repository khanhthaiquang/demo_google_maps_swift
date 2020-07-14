//
//  ViewController.swift
//  DemoMaps
//
//  Created by Khánh's Mac on 3/2/20.
//  Copyright © 2020 Khánh's Mac. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabbar: UITabBar!
    
    var mapsView : GoogleMapsManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbar.delegate = self
        initLayout()
        
        print("BASE_URL : \(Bundle.main.infoDictionary!["BASE_URL"] as? String ?? "")")
    }
    
    func initLayout(){
        mapsView = GoogleMapsManager()
        containerView.addSubview(mapsView.initWithFrame(frame: CGRect(x: 0, y: 0, width: containerView.width, height: containerView.height)))
    }
}

extension ViewController: UITabBarDelegate, UITabBarControllerDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
            case 0:
                mapsView.changeTypeMaps(type: .Normal)
            case 1:
                mapsView.changeTypeMaps(type: .Hybrid)
            case 2:
                mapsView.changeTypeMaps(type: .Satellite)
            case 3:
                mapsView.changeTypeMaps(type: .Terrain)
            case 4:
                mapsView.moveToListLocations(markers: DummyData.share.createListMarker())
               break
            default:
                break
        }
    }
}

