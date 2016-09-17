//
//  ViewController.swift
//  lapse
//
//  Created by dyno on 7/21/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class ViewController: PopbaseUIViewController ,CapturePictureHandler , GBTaskExcuserGen{
    @IBOutlet weak var m_debug_info: UILabel!
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
    @IBOutlet weak var m_btn_LapseStop: UIButton!
    @IBOutlet weak var m_btn_LapseResume: UIButton!
    @IBOutlet weak var m_view_lapse_ctrl: UIView!
    
    @IBOutlet weak var m_focus_sel: UIImageView!
    @IBOutlet weak var m_exposure_sel: UIImageView!
    @IBOutlet weak var m_exposure_ctx: NSLayoutConstraint!
    @IBOutlet weak var m_exposure_cty: NSLayoutConstraint!
    @IBOutlet weak var m_focus_ctx: NSLayoutConstraint!
    @IBOutlet weak var m_focus_cty: NSLayoutConstraint!
    
    var m_updateDebugInfo:GBTimerGen?
    var m_lapseSetterView:LapseSetterView?
    var m_resolutionSetterView:ResolutionSetterView?
    var m_moreCameraSetterView:MoreCameraSetterView?
    
    let camera_controller:GBCameraControllerImp = GBCameraControllerImp.instance
    
    func captureOutput(image:UIImage?, error:String?) -> Void{
        let preview:PicturePreviewViewController? = GBPlatformUtilityImp.sharedInstance.getViewController("pictrue_preview") as? PicturePreviewViewController
        
        if preview == nil {
            GBLogGen.instance()?.logerrf("captureOutput preview nil \(#file) \(#function) \(#line)");
            return
        }
        preview?.setPreviewImage(image!)
        self.presentViewController(preview!, animated: false, completion: nil)
    }
    
    @objc func excuse(info: GBTaskInfoGen?){
        debuginfo()
    }
    
    private func debuginfo(){
        var text:String = ""

        let duration = GBCameraControllerImp.instance.getExposureDurationCMT()
        let duration_max:Float = GBCameraControllerImp.instance.getExposureMaxDuration()
        let duration_min:Float = GBCameraControllerImp.instance.getExposureMinDuration()
        let duration_model = GBCameraControllerImp.instance.getExposureMode()
        
        let iso = GBCameraControllerImp.instance.getISO()
        let iso_max = GBCameraControllerImp.instance.getISOMax()
        let iso_min = GBCameraControllerImp.instance.getISOMin()
        

        let focus:Float = GBCameraControllerImp.instance.getFocusLens()
        let focus_max:Float = GBCameraControllerImp.instance.getFocusMax()
        let focus_min:Float = GBCameraControllerImp.instance.getFocusMin()
        let focus_model = GBCameraControllerImp.instance.getFocusMode()
        let focus_range = GBCameraControllerImp.instance.getFocusAutoRange()
        
        let zoom:Float = GBCameraControllerImp.instance.getZoom()
        let zoom_max:Float = GBCameraControllerImp.instance.getZoomMax()
        
        text = String("dration: \(duration!.value):\(duration!.timescale) second:\(duration!.seconds) max:\(duration_max) min:\(duration_min) mode:\(duration_model.rawValue)\n")
        text += String("iso: \(iso) max:\(iso_max) min:\(iso_min)\n")
        text += String("focus: \(focus) max:\(focus_max) min:\(focus_min) mode:\(focus_model.rawValue) range:\(focus_range.rawValue)\n")
        
        text += String("zoom: \(zoom) max:\(zoom_max)\n")
        
        m_debug_info.text = text
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btn_show(nil)
        m_exposure_sel.hidden = true
        m_focus_sel.hidden = true
        
        GBInstanceGetterGen.setPlatformUtility(GBPlatformUtilityImp.sharedInstance)
        camera_controller.initializ_swif(self.view)
        camera_controller.startCamera()
        camera_controller.setCapturePictureHandler(self)
        GBInstanceGetterGen.setCameraController(camera_controller)
        
        GBUiManagerGen.instance()?.initialize("", factory: GBViewFactoryImp.instance)
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
        
        LogicTaskExcuserImp.sharedInstance.m_capture_vc = self
        GBTaskManagerGen.instance()?.addTaskExcuser(LogicTaskExcuserImp.sharedInstance)
        
        m_updateDebugInfo = GBTimerGen.create(0, interval: 300, repeatTimes: -1, hander: self)
    }

    private func initViews(){
        m_lapseSetterView = LapseSetterView(nibName: "LapseSetterView", bundle: nil)
        m_lapseSetterView?.setPopbase(self)
        
        m_resolutionSetterView = ResolutionSetterView(nibName: "ResolutionSetterView", bundle: nil)
        m_resolutionSetterView?.setPopbase(self)
        
        m_moreCameraSetterView = MoreCameraSetterView(nibName: "MoreCameraSetterView", bundle: nil)
        m_moreCameraSetterView?.setPopbase(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.bringSubviewToFront(m_debug_info)
        self.view.bringSubviewToFront(m_view_lapse_ctrl)
        self.view.bringSubviewToFront(m_viewbtns)
        self.view.bringSubviewToFront(btn_switch)
        self.view.bringSubviewToFront(m_exposure_sel)
        self.view.bringSubviewToFront(m_focus_sel)
        self.view.bringSubviewToFront(m_btn_LapseStop)
        self.view.bringSubviewToFront(m_btn_LapseResume)
        m_updateDebugInfo?.start()
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        m_updateDebugInfo?.pause()
        super.viewWillDisappear(animated)
    }
    
    @IBAction func tapView(sender: UITapGestureRecognizer) {
        
        if m_exposure_sel.hidden && m_focus_sel.hidden{
            return
        }
        m_viewbtns.hidden = false
        m_view_lapse_ctrl.hidden = btn_capture.hidden
        
        UIView.animateWithDuration(0.5, animations: {
            self.m_exposure_sel.transform = CGAffineTransformScale(self.m_exposure_sel.transform, 0.5, 0.5)
            self.m_focus_sel.transform = CGAffineTransformScale(self.m_focus_sel.transform, 0.5, 0.5)
            }, completion: {
                (value: Bool) in
                self.m_exposure_sel.hidden = true
                self.m_focus_sel.hidden = true
                self.m_exposure_sel.transform = CGAffineTransformScale(self.m_exposure_sel.transform, 2, 2)
                self.m_focus_sel.transform = CGAffineTransformScale(self.m_focus_sel.transform, 2, 2)
        })
    }
    
    @IBAction func longPressView(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            let point:CGPoint = sender.locationInView(sender.view)
            showExposure(point)
            showFocusSel(point)
        }
    }
    
    func showFocusSel(pt: CGPoint) {
        showTouchSel(m_focus_sel, pt: pt, ctx: m_focus_ctx, cty: m_focus_cty)
    }
    
    private func showTouchSel(img:UIImageView, pt:CGPoint, ctx:NSLayoutConstraint, cty:NSLayoutConstraint) {
        img.hidden = false
        m_viewbtns.hidden = true
        m_view_lapse_ctrl.hidden = true
        if pt.x < 0 {
            ctx.constant = 0
            cty.constant = 0
        }
        else{
            ctx.constant = pt.x - self.view.frame.size.width/2
            cty.constant = pt.y - self.view.frame.size.height/2
        }
        self.view.layoutIfNeeded()
        let fx = Float(pt.x/(self.view.frame.width))
        let fy = Float(pt.y/(self.view.frame.height))
        
        if img == m_exposure_sel {
            GBCameraControllerImp.instance.setExposurePoint(fx, y: fy)
        }
        else if img == m_focus_sel {
            GBCameraControllerImp.instance.setFocusPoint(fx, y: fy)
        }
    }
    
    func showExposure(pt: CGPoint) {
        showTouchSel(m_exposure_sel, pt: pt, ctx: m_exposure_ctx, cty: m_exposure_cty)
    }
    
    func dragView(sender: UIPanGestureRecognizer, constraint_x:NSLayoutConstraint, constraint_y:NSLayoutConstraint) {
        let exposure_sel = sender.view
        if nil == exposure_sel {
            return
        }
        if sender.state == UIGestureRecognizerState.Changed {
            let translation = sender.translationInView(exposure_sel?.superview)
            //exposure_sel?.center = CGPoint(x: (exposure_sel?.center.x)!+translation.x,
            //                               y: (exposure_sel?.center.y)!+translation.y)
            constraint_x.constant += translation.x
            constraint_y.constant += translation.y
            sender.setTranslation(CGPointZero, inView: exposure_sel?.superview)
            self.view.layoutIfNeeded()
        }
    }

    
    @IBAction func dragExposureSel(sender: UIPanGestureRecognizer) {
        //dragView(sender, constraint_x: m_exposure_ctx, constraint_y: m_exposure_cty)
        let point:CGPoint = sender.locationInView(self.view)
        showExposure(point)
    }
    @IBAction func dragFocusSel(sender: UIPanGestureRecognizer) {
        //dragView(sender, constraint_x: m_focus_ctx, constraint_y: m_focus_cty)
        let point:CGPoint = sender.locationInView(self.view)
        showFocusSel(point)
    }
    
    func screenRotate() {
        print("screen rotate: \(UIApplication.sharedApplication().statusBarOrientation)")
        //let ori:UIDeviceOrientation = UIDevice.currentDevice().orientation
        camera_controller.rotateScreen()
    }
    
    @IBAction func stop(sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.CameraBtnStop.rawValue), task: nil)
    }

    @IBAction func resume(sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.CameraBtnResume.rawValue), task: nil)
    }
    
    @IBAction func capture(sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.CameraBtnCapture.rawValue), task: nil)
    }
    
    @IBAction func pause(sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.CameraBtnPause.rawValue), task: nil)
    }
    
    @IBAction func lapse(sender: UIButton) {
        if !btn_capture.hidden {
            return
        }
        if nil == m_lapseSetterView {
            initViews()
        }
        self.presentpopupViewController(m_lapseSetterView!, animationType: SLpopupViewAnimationType.Fade, completion: nil)
    }

    @IBAction func lapseResume(sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.CameraBtnLapseResume.rawValue), task: nil)
    }
    
    @IBAction func lapseStop(sender: UIButton) {
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.CameraBtnLapseStop.rawValue), task: nil)
        btn_show(sender)
    }
    
    @IBAction func ratio(sender: AnyObject) {
        if !btn_capture.hidden {
            return
        }
        if nil == m_resolutionSetterView {
            initViews()
        }
        self.presentpopupViewController(m_resolutionSetterView!, animationType: SLpopupViewAnimationType.Fade, completion: nil)
    }

    @IBAction func more_camera_setting(sender: UIButton) {
        if !btn_capture.hidden {
            return
        }
        if nil == m_moreCameraSetterView {
            initViews()
        }
        self.presentpopupViewController(m_moreCameraSetterView!, animationType: SLpopupViewAnimationType.Fade, completion: nil)
    }
    
    @IBAction func library_tap(sender: UIButton) {
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.CameraBtnLibrary.rawValue), task: nil)
    }
    
    @IBAction func switch_camer(sender: UIButton) {
        self.camera_controller.asnyOnePicture()
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        //print("supportedInterfaceOrientations")
        camera_controller.rotate()
        return UIInterfaceOrientationMask.LandscapeRight
    }
    
    override func shouldAutorotate() -> Bool{
        return true
    }
    
    private func btn_show(btn: UIButton?){
        if btn == btn_capture {
            btn_capture.hidden = true
            btn_library.hidden = true
            btn_pause.hidden = false
            btn_stop.hidden = false
            btn_resume.hidden = true
            m_btn_LapseStop.hidden = false
        }
        else if btn == btn_pause {
            btn_resume.hidden = false
            btn_pause.hidden = true
        }
        else if btn == btn_resume {
            btn_resume.hidden = true
            btn_pause.hidden = false
        }
        else if btn == btn_stop {
            btn_capture.hidden = false
            btn_library.hidden = false
            btn_pause.hidden = true
            btn_stop.hidden = true
            btn_resume.hidden = true
            btn_resume.hidden = true
            m_btn_LapseStop.hidden = true
        }
        else if btn == m_btn_LapseResume {
            m_btn_LapseStop.hidden = false
            m_btn_LapseResume.hidden = true
        }
        else if btn == m_btn_LapseStop {
            m_btn_LapseResume.hidden = false
            m_btn_LapseStop.hidden = true
        }
        else if btn == nil {
            btn_pause.hidden = true
            btn_stop.hidden = true
            btn_resume.hidden = true
            m_btn_LapseStop.hidden = true
            m_btn_LapseResume.hidden = true
        }
        
    }
}

