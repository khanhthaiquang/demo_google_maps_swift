//
//  StreetViewController.swift
//  DemoMaps
//
//  Created by Khánh's Mac on 3/9/20.
//  Copyright © 2020 Khánh's Mac. All rights reserved.
//

import UIKit
import GoogleMaps

class StreetViewController: UIViewController, GMSMapViewDelegate,GMSPanoramaViewDelegate {

    var panoView: GMSPanoramaView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let panoView = GMSPanoramaView(frame: .zero)
        panoView.delegate = self
        self.view = panoView
        panoView.moveNearCoordinate(CLLocationCoordinate2DMake(10.8128578, 106.6640161))
        panoView.setAllGesturesEnabled(false)

        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            self.panoView.animate(to: GMSPanoramaCamera(heading: 90, pitch: 0, zoom: 1), animationDuration: 2.0)
//        }
//    }

}
