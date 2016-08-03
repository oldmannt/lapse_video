//
//  ViewController.swift
//  lapse
//
//  Created by dyno on 7/21/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var m_viewbtns: UIView!
    @IBOutlet weak var btn_lapse: UIButton!
    @IBOutlet weak var btn_library: UIButton!
    @IBOutlet weak var btn_stop: UIButton!
    @IBOutlet weak var btn_ratio: UIButton!
    @IBOutlet weak var btn_more: UIButton!
    @IBOutlet weak var btn_pause: UIButton!
    @IBOutlet weak var btn_capture: UIButton!
    @IBOutlet weak var btn_resume: UIButton!
    @IBOutlet weak var btn_switch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //btn_show(nil)
        
        GBInstanceGetterGen.setPlatformUtility(GBPlatformUtilityImp())
        let camera_controller:GBCameraControllerImp = GBCameraControllerImp()
        camera_controller.initializ_swif(self.view)
        camera_controller.startCamera()
        GBInstanceGetterGen.setCameraController(camera_controller)
        
        GBViewFactoryImp.instance.addIOSViewToUIMgr(m_viewbtns, id: "camera_view_btns", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_lapse, id: "camera_btn_lapse", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_library, id: "camera_btn_library", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_stop, id: "camera_btn_stop", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_ratio, id: "camera_btn_ratio", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_more, id: "camera_btn_more", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_pause, id: "camera_btn_pause", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_capture, id: "camera_btn_capture", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_resume, id: "camera_btn_resume", constroller: self)
        GBViewFactoryImp.instance.addIOSViewToUIMgr(btn_switch, id: "camera_btn_switch", constroller: self)
        
        LPALogicGen.instance()?.initialize("user.json")
        LPAUilogicGen.instance()?.initialize(LPALapseUiScene.Camera)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.bringSubviewToFront(m_viewbtns)
        self.view.bringSubviewToFront(btn_switch)
    }
    
    @IBAction func stop(sender: UIButton) {
        //btn_show(sender)
    }

    @IBAction func resume(sender: UIButton) {
        //btn_show(sender)
    }
    
    @IBAction func capture(sender: UIButton) {
        //btn_show(sender)
    }
    
    @IBAction func pause(sender: UIButton) {
        //btn_show(sender)
    }
    
    @IBAction func lapse(sender: UIButton) {
    }

    @IBAction func ratio(sender: AnyObject) {
    }

    @IBAction func more_camera_setting(sender: UIButton) {
    }
    
    @IBAction func library(sender: AnyObject) {
    }
    @IBAction func switch_camer(sender: UIButton) {
    }
    
    private func btn_show(btn: UIButton?){
        if btn == btn_capture {
            btn_capture.hidden = true;
            btn_library.hidden = true;
            btn_pause.hidden = false;
            btn_stop.hidden = false;
        }
        else if btn == btn_pause {
            btn_resume.hidden = false;
            btn_pause.hidden = true;
        }
        else if btn == btn_resume {
            btn_resume.hidden = true;
            btn_pause.hidden = false;
        }
        else if btn == btn_stop {
            btn_capture.hidden = false;
            btn_library.hidden = false;
            btn_pause.hidden = true;
            btn_stop.hidden = true;
            btn_resume.hidden = true;
        }
        else if btn == nil {
            btn_pause.hidden = true;
            btn_stop.hidden = true;
            btn_resume.hidden = true;
        }
    }
}

