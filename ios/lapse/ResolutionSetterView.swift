//
//  ResolutionSetterView.swift
//  lapse_app
//
//  Created by dyno on 8/28/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class ResolutionSetterView: PopupViewController {

    @IBOutlet weak var m_tittle: UILabel!
    @IBOutlet weak var m_resolution: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        m_tittle.text = GBLanguageStoreGen.instance()?.getString("resolution_tittle")
        
        let reso = GBCameraControllerImp.instance.getQuality()
        switch (reso) {
        case GBCameraQuality.P360:
            m_resolution.selectedSegmentIndex = 0
        case GBCameraQuality.P480:
            m_resolution.selectedSegmentIndex = 1
        case GBCameraQuality.P720:
            m_resolution.selectedSegmentIndex = 2
        case GBCameraQuality.P1080:
            m_resolution.selectedSegmentIndex = 3
        default:
            GBLogGen.instance()?.logerrf("resolution error:\(reso)")
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func save(_ sender: AnyObject) {
        switch m_resolution.selectedSegmentIndex {
        case 0:
            GBCameraControllerImp.instance.setQuality(GBCameraQuality.P360)
            break
        case 1:
            GBCameraControllerImp.instance.setQuality(GBCameraQuality.P480)
            break
        case 2:
            GBCameraControllerImp.instance.setQuality(GBCameraQuality.P720)
            break
        case 3:
            GBCameraControllerImp.instance.setQuality(GBCameraQuality.P1080)
            break
        default:
            break
        }
        self.dissmissPopup(animationType: .fade)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        self.dissmissPopup(animationType: .fade)
    }
}
