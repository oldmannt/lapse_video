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
    @IBOutlet var m_camera_preview: PreviewView!
    
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
    
    func captureOutput(_ image:UIImage?, error:String?) -> Void{
        let preview:PicturePreviewViewController? = GBPlatformUtilityImp.sharedInstance.getViewController("pictrue_preview") as? PicturePreviewViewController
        
        if preview == nil {
            GBLogGen.instance()?.logerrf("captureOutput preview nil \(#file) \(#function) \(#line)");
            return
        }
        preview?.setPreviewImage(image!)
        self.present(preview!, animated: false, completion: nil)
    }
    
    @objc func excuse(_ info: GBTaskInfoGen?){
        debuginfo()
    }
    
    fileprivate func debuginfo(){
        m_debug_info.text = GBCameraControllerImp.instance.getDebugInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btn_show(nil)
        
        camera_controller.initializ_swif(m_camera_preview, complition: {[unowned self] (result, msg) -> Void in
            GBInstanceGetterGen.setCameraController(self.camera_controller)
            LPALogicGen.instance()?.initialize("user.json")
        })
        
        GBUiManagerGen.instance()?.initialize("", factory: GBViewFactoryImp.instance)
        LogicTaskExcuserImp.sharedInstance.m_capture_vc = self
        GBTaskManagerGen.instance()?.addTaskExcuser(LogicTaskExcuserImp.sharedInstance)
        
        self.btn_lapse.setTitle(GBLanguageStoreGen.instance()?.getString("capture"), for: .normal)
        self.btn_capture.setTitle(GBLanguageStoreGen.instance()?.getString("capture"), for: .normal)
        self.btn_ratio.setTitle(GBLanguageStoreGen.instance()?.getString("ratio"), for: .normal)
        self.btn_lapse.setTitle(GBLanguageStoreGen.instance()?.getString("lapse"), for: .normal)
        self.btn_more.setTitle(GBLanguageStoreGen.instance()?.getString("more"), for: .normal)
        self.btn_library.setTitle(GBLanguageStoreGen.instance()?.getString("library"), for: .normal)
        self.btn_pause.setTitle(GBLanguageStoreGen.instance()?.getString("pause"), for: .normal)
        self.btn_resume.setTitle(GBLanguageStoreGen.instance()?.getString("resume"), for: .normal)
        self.m_btn_LapseStop.setTitle(GBLanguageStoreGen.instance()?.getString("lapse_pause"), for: .normal)
        self.m_btn_LapseResume.setTitle(GBLanguageStoreGen.instance()?.getString("lapse_resume"), for: .normal)
        self.btn_stop.setTitle(GBLanguageStoreGen.instance()?.getString("stop"), for: .normal)
        
        #if DEBUG
            m_updateDebugInfo = GBTimerGen.create(300, repeatTimes: -1, hander: self)
        #else
            m_debug_info.isHidden = true
        #endif
    }

    fileprivate func initViews(){
        m_lapseSetterView = LapseSetterView(nibName: "LapseSetterView", bundle: nil)
        m_lapseSetterView?.setPopbase(popbase: self)
        
        m_resolutionSetterView = ResolutionSetterView(nibName: "ResolutionSetterView", bundle: nil)
        m_resolutionSetterView?.setPopbase(popbase: self)
        
        m_moreCameraSetterView = MoreCameraSetterView(nibName: "MoreCameraSetterView", bundle: nil)
        m_moreCameraSetterView?.setPopbase(popbase: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.bringSubview(toFront: m_debug_info)
        self.view.bringSubview(toFront: m_view_lapse_ctrl)
        self.view.bringSubview(toFront: m_viewbtns)
        self.view.bringSubview(toFront: btn_switch)
        self.view.bringSubview(toFront: m_exposure_sel)
        self.view.bringSubview(toFront: m_focus_sel)
        self.view.bringSubview(toFront: m_btn_LapseStop)
        self.view.bringSubview(toFront: m_btn_LapseResume)
        m_updateDebugInfo?.start()
        
        GBCameraControllerImp.instance.startCamera()
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        m_updateDebugInfo?.pause()
        GBCameraControllerImp.instance.stopCamera()
        super.viewWillDisappear(animated)
    }

    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        
        if m_exposure_sel.isHidden && m_focus_sel.isHidden{
            return
        }
        m_viewbtns.isHidden = false
        m_view_lapse_ctrl.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.m_exposure_sel.transform = self.m_exposure_sel.transform.scaledBy(x: 0.5, y: 0.5)
            self.m_focus_sel.transform = self.m_focus_sel.transform.scaledBy(x: 0.5, y: 0.5)
            }, completion: {
                (value: Bool) in
                self.m_exposure_sel.isHidden = true
                self.m_focus_sel.isHidden = true
                self.m_exposure_sel.transform = self.m_exposure_sel.transform.scaledBy(x: 2, y: 2)
                self.m_focus_sel.transform = self.m_focus_sel.transform.scaledBy(x: 2, y: 2)
        })
    }
    
    @IBAction func longPressView(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began {
            if isSubDialogShow() {
                return
            }
            let point:CGPoint = sender.location(in: sender.view)
            showExposure(point)
            showFocusSel(point)
        }
    }
    
    func showFocusSel(_ pt: CGPoint) {
        showTouchSel(m_focus_sel, pt: pt, ctx: m_focus_ctx, cty: m_focus_cty)
    }
    
    fileprivate func showTouchSel(_ img:UIImageView, pt:CGPoint, ctx:NSLayoutConstraint, cty:NSLayoutConstraint) {
        img.isHidden = false
        m_viewbtns.isHidden = true
        m_view_lapse_ctrl.isHidden = true
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
    
    func showExposure(_ pt: CGPoint) {
        showTouchSel(m_exposure_sel, pt: pt, ctx: m_exposure_ctx, cty: m_exposure_cty)
    }
    
    func dragView(_ sender: UIPanGestureRecognizer, constraint_x:NSLayoutConstraint, constraint_y:NSLayoutConstraint) {
        let exposure_sel = sender.view
        if nil == exposure_sel {
            return
        }
        if sender.state == UIGestureRecognizerState.changed {
            let translation = sender.translation(in: exposure_sel?.superview)
            constraint_x.constant += translation.x
            constraint_y.constant += translation.y
            sender.setTranslation(CGPoint.zero, in: exposure_sel?.superview)
            self.view.layoutIfNeeded()
        }
    }

    
    @IBAction func dragExposureSel(_ sender: UIPanGestureRecognizer) {
        //dragView(sender, constraint_x: m_exposure_ctx, constraint_y: m_exposure_cty)
        let point:CGPoint = sender.location(in: self.view)
        showExposure(point)
    }
    @IBAction func dragFocusSel(_ sender: UIPanGestureRecognizer) {
        //dragView(sender, constraint_x: m_focus_ctx, constraint_y: m_focus_cty)
        let point:CGPoint = sender.location(in: self.view)
        showFocusSel(point)
    }
    
    func screenRotate() {
        //print("screen rotate: \(UIApplication.shared.statusBarOrientation)")
        //let ori:UIDeviceOrientation = UIDevice.currentDevice().orientation
        camera_controller.rotateScreen()
    }
    
    @IBAction func stop(_ sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.cameraBtnStop.rawValue), task: nil)
    }

    @IBAction func resume(_ sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.cameraBtnResume.rawValue), task: nil)
    }
    
    @IBAction func capture(_ sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.cameraBtnCapture.rawValue), task: nil)
    }
    
    @IBAction func pause(_ sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.cameraBtnPause.rawValue), task: nil)
    }
    
    @IBAction func lapse(_ sender: UIButton) {
        if btn_capture.isHidden && btn_resume.isHidden{
            return
        }
        if nil == m_lapseSetterView {
            initViews()
        }
        self.presentpopupViewController(m_lapseSetterView!, animationType: SLpopupViewAnimationType.fade, completion: nil)
    }

    @IBAction func lapseResume(_ sender: UIButton) {
        btn_show(sender)
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.cameraBtnLapseResume.rawValue), task: nil)
    }
    
    @IBAction func lapseStop(_ sender: UIButton) {
        GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.cameraBtnLapseStop.rawValue), task: nil)
        btn_show(sender)
    }
    
    @IBAction func ratio(_ sender: AnyObject) {
        if btn_capture.isHidden && btn_resume.isHidden{
            return
        }
        if nil == m_resolutionSetterView {
            initViews()
        }
        self.presentpopupViewController(m_resolutionSetterView!, animationType: SLpopupViewAnimationType.fade, completion: nil)
    }

    @IBAction func more_camera_setting(_ sender: UIButton) {
        if btn_capture.isHidden && btn_resume.isHidden{
            return
        }
        if nil == m_moreCameraSetterView {
            initViews()
        }
        self.presentpopupViewController(m_moreCameraSetterView!, animationType: SLpopupViewAnimationType.fade, completion: nil)
    }
    
    @IBAction func library_tap(_ sender: UIButton) {
        //GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.cameraBtnLibrary.rawValue), task: nil)
    }
    @IBAction func tapFps(_ sender: AnyObject) {
        if btn_capture.isHidden && btn_resume.isHidden{
            return
        }

    }
    
    @IBAction func switch_camer(_ sender: UIButton) {
        self.camera_controller.asnyOnePicture()
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        //print("supportedInterfaceOrientations")
        camera_controller.rotate()
        return UIInterfaceOrientationMask.landscapeRight
    }
    
    override var shouldAutorotate : Bool{
        return true
    }
    
    fileprivate func isSubDialogShow() -> Bool{
        return ((m_lapseSetterView != nil) && m_lapseSetterView!.isShowed()) ||
            ((m_resolutionSetterView != nil) && m_resolutionSetterView!.isShowed()) ||
            ((m_moreCameraSetterView != nil) && m_moreCameraSetterView!.isShowed())
    }
    
    fileprivate func btn_show(_ btn: UIButton?){
        if btn == btn_capture {
            btn_capture.isHidden = true
            btn_library.isHidden = true
            btn_pause.isHidden = false
            btn_stop.isHidden = false
            btn_resume.isHidden = true
            m_btn_LapseStop.isHidden = false
        }
        else if btn == btn_pause {
            btn_resume.isHidden = false
            btn_pause.isHidden = true
            m_view_lapse_ctrl.isHidden = true
        }
        else if btn == btn_resume {
            btn_resume.isHidden = true
            btn_pause.isHidden = false
            m_view_lapse_ctrl.isHidden = false
        }
        else if btn == btn_stop {
            btn_capture.isHidden = false
            btn_library.isHidden = false
            btn_pause.isHidden = true
            btn_stop.isHidden = true
            btn_resume.isHidden = true
            m_btn_LapseStop.isHidden = true
            m_btn_LapseResume.isHidden = true
            m_view_lapse_ctrl.isHidden = true
        }
        else if btn == m_btn_LapseResume {
            m_btn_LapseStop.isHidden = false
            m_btn_LapseResume.isHidden = true
        }
        else if btn == m_btn_LapseStop {
            m_btn_LapseResume.isHidden = false
            m_btn_LapseStop.isHidden = true
        }
        else if btn == nil {
            btn_pause.isHidden = true
            btn_stop.isHidden = true
            btn_resume.isHidden = true
            m_btn_LapseStop.isHidden = true
            m_btn_LapseResume.isHidden = true
            btn_switch.isHidden = true
            m_exposure_sel.isHidden = true
            m_focus_sel.isHidden = true
        }
        
    }
    
}

