//
//  LapseSetterView.swift
//  lapse_app
//
//  Created by dyno on 8/27/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class LapseSetterView: PopupViewController {

    @IBOutlet weak var m_lblTittle: UILabel!
    @IBOutlet weak var m_txtInterval: UITextField!
    @IBOutlet weak var m_segUnit: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        m_lblTittle.text = GBLanguageStoreGen.instance()?.getString("capture_interval")
        let value:Int32 = (LPADataGen.instance()?.getCaptureInteval())!
        m_txtInterval.text = "\(value)"
        let unit:String = (LPADataGen.instance()?.getCaptureIntevalUnit())!
        switch unit {
        case "mill_sec":
            m_segUnit.selectedSegmentIndex = 0
            break
        case "second":
            m_segUnit.selectedSegmentIndex = 1
            break
        case "minute":
            m_segUnit.selectedSegmentIndex = 2
            break
        default:
            break
        }
        
        m_segUnit.setTitle(GBLanguageStoreGen.instance()?.getString("capture_mill_second"), forSegmentAtIndex: 0)
        m_segUnit.setTitle(GBLanguageStoreGen.instance()?.getString("capture_second"), forSegmentAtIndex: 1)
        m_segUnit.setTitle(GBLanguageStoreGen.instance()?.getString("capture_minute"), forSegmentAtIndex: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func txtChange(sender: UITextField) {
        
    }
    
    @IBAction func selectSegment(sender: UISegmentedControl) {
        
    }
    
    @IBAction func btn_cancel_tap(sender: UIButton) {
        self.dissmissPopup(.Fade)
    }

    @IBAction func btnSaveTap(sender: AnyObject) {
        var unit:String = "second"
        switch m_segUnit.selectedSegmentIndex {
        case 0:
            unit = "mill_sec"
            break
        case 1:
            unit = "second"
            break
        case 2:
            unit = "minute"
            break
        default:
            break
        }
        LPADataGen.instance()?.setCaptureInteval(Int32(m_txtInterval.text!)!, unit: unit)
        self.dissmissPopup(.Fade)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
