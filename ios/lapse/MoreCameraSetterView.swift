//
//  MoreCameraSetterView.swift
//  lapse_app
//
//  Created by dyno on 8/28/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class MoreCameraSetterView: PopupViewController, GBTaskExcuserGen {
    @IBOutlet weak var m_switch_views: UISegmentedControl!

    @IBOutlet weak var m_exposure_view: UIView!
    @IBOutlet weak var m_exposure_tittle: UILabel!
    @IBOutlet weak var m_exposure_control: UISegmentedControl!
    @IBOutlet weak var m_exposure_value_slider: UISlider!
    @IBOutlet weak var m_exposure_value: UILabel!
    @IBOutlet weak var m_iso_value_slider: UISlider!
    @IBOutlet weak var m_iso_value: UILabel!
    @IBOutlet weak var m_ev_slider: UISlider!
    @IBOutlet weak var m_ev_label: UILabel!
    
    @IBOutlet weak var m_focus_view: UIView!
    @IBOutlet weak var m_focus_control: UISegmentedControl!
    @IBOutlet weak var m_focus_slider: UISlider!
    @IBOutlet weak var m_focus_tittle: UILabel!
    
    @IBOutlet weak var m_zoom_view: UIView!
    @IBOutlet weak var m_zoom_tittle: UILabel!
    @IBOutlet weak var m_zoom_slider: UISlider!
    
    @IBOutlet weak var m_more_view: UIView!
    @IBOutlet weak var m_more_tittle: UILabel!
    @IBOutlet weak var m_lighting_segment: UISegmentedControl!
    
    @IBOutlet weak var m_debug_overlay: UILabel!
    var m_updateCamera:GBTimerGen?
    
    enum ViewType: Int {
        case exposure = 0
        case focus;
        case zoom;
        case more;
        
        static func fromIndex(_ index:Int) -> ViewType {
            switch index {
            case 0:
                return exposure
            case 1:
                return focus
            case 2:
                return zoom
            case 3:
                return more
            default:
                return exposure
            }
        }
    }
    
    var m_curViewType:ViewType = .exposure
    
    let m_expose_duration_power:Float = 5.0 // Higher numbers will give the slider more sensitivity at shorter durations
    let m_expose_duration_min:Float = 1.0/1000.0 // // Limit exposure duration to a useful range
    func exposure_to_slider(duration:Float) -> Float{
        let max_duration = GBCameraControllerImp.instance.getExposureMaxDuration()
        let min_duration = max(GBCameraControllerImp.instance.getExposureMinDuration(),m_expose_duration_min)
        
        let p = (duration - min_duration)/(max_duration - min_duration)
        let rt = powf(p, 1.0/m_expose_duration_power)
        return rt
    }
    
    func slider_to_exposure(value:Float) -> Float{
        let min_duration = max(GBCameraControllerImp.instance.getExposureMinDuration(),m_expose_duration_min)
        let max_duration = GBCameraControllerImp.instance.getExposureMaxDuration()
        let pow = powf(value, m_expose_duration_power)
        
        let rt = pow * (max_duration - min_duration) + min_duration
        return rt
    }
    
    let m_slider_update:Int = 300
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let transparent:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        m_exposure_view.backgroundColor = UIColor.clear
        m_focus_view.backgroundColor = UIColor.clear
        m_zoom_view.backgroundColor = UIColor.clear
        m_more_view.backgroundColor = UIColor.clear
        
        m_exposure_value_slider.maximumValue = 1
        m_exposure_value_slider.minimumValue = 0
        
        m_ev_slider.minimumValue = GBCameraControllerImp.instance.getEVMin()
        m_ev_slider.maximumValue = GBCameraControllerImp.instance.getEVMax()
        
        m_updateCamera = GBTimerGen.create(Int64(m_slider_update), repeatTimes: -1, hander: self)
        m_debug_overlay.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switchViews(ViewType.exposure)
        m_switch_views.selectedSegmentIndex = 0
        m_updateCamera?.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        m_updateCamera?.pause()
    }
    
    @IBAction func switch_view_segment_change(_ sender: UISegmentedControl) {
        switchViews(ViewType.fromIndex(sender.selectedSegmentIndex))
    }
    
    @IBAction func close(_ sender: AnyObject) {
        self.dissmissPopup(animationType: .fade)
    }

    @IBAction func flashSegmentChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            GBCameraControllerImp.instance.setFlashMode(GBCameraFlash.auto)
        case 1:
            GBCameraControllerImp.instance.setFlashMode(GBCameraFlash.on)
        case 2:
            GBCameraControllerImp.instance.setFlashMode(GBCameraFlash.off)
        default:
            break
        }
    }
    
    @IBAction func focus_segment_change(_ sender: AnyObject) {
        switch m_focus_control.selectedSegmentIndex {
        case 0:
            GBCameraControllerImp.instance.setFocusMode(GBCameraFocusMode.locked)
            m_focus_slider.isEnabled = true
        case 1:
            GBCameraControllerImp.instance.setFocusMode(GBCameraFocusMode.continuousAutoFocus)
            m_focus_slider.isEnabled = false
        case 2:
            let vc:ViewController = super.m_popbase as! ViewController
            self.dissmissPopup(animationType: .none)
            vc.showFocusSel(CGPoint(x: -1,y: -1))
        default: break
            
        }
    }

    @IBAction func focus_slider_change(_ sender: UISlider) {
        GBCameraControllerImp.instance.setFocusLens(sender.value)
        m_focus_control.selectedSegmentIndex = 0
    }
    
    @IBAction func zoom_slider_change(_ sender: AnyObject) {
        GBCameraControllerImp.instance.setZoom(sender.value)
    }


    @IBAction func exposure_control_select(_ sender: AnyObject) {
        switch m_exposure_control.selectedSegmentIndex {
        case 0:
            GBCameraControllerImp.instance.setExposureMode(GBCameraExposureMode.locked)
            m_exposure_value_slider.isEnabled = false
            m_iso_value_slider.isEnabled = false
            break
        case 1:
            GBCameraControllerImp.instance.setExposureMode(GBCameraExposureMode.continuousAutoExposure)
            m_exposure_value_slider.isEnabled = false
            m_iso_value_slider.isEnabled = false
            break
        case 2:
            GBCameraControllerImp.instance.setExposureMode(GBCameraExposureMode.modeCustom)
            m_exposure_value_slider.isEnabled = true
            m_iso_value_slider.isEnabled = true
            break
        case 3:
            let vc:ViewController = super.m_popbase as! ViewController
            self.dissmissPopup(animationType: .none)
            vc.showExposure(CGPoint(x: -1,y: -1))
            break
        default:
            break
        }
    }
    
    @IBAction func exposure_slider_change(_ sender: UISlider) {
        let value:Float = self.slider_to_exposure(value: sender.value)
        m_expose_set = -m_slider_update*2
        GBCameraControllerImp.instance.setExposureDuration(value)
        self.setExposureLabel(duration: value)
    }
    
    @IBAction func iso_slider_change(_ sender: UISlider) {
        //print("iso_slider_change \(sender.value)")
        m_expose_set = -m_slider_update
        GBCameraControllerImp.instance.setISO(Int32(sender.value))
        m_iso_value.text = String.init(format: "%d", Int(sender.value))
    }
    
    @IBAction func ev_slider_change(_ sender: UISlider) {
        m_expose_set = -m_slider_update
        GBCameraControllerImp.instance.setEV(sender.value)
        m_ev_label.text = String.init(format: "%.01f", sender.value)
    }
    
    @objc func excuse(_ info: GBTaskInfoGen?){
        self.updateExposure()
        self.updateZoom()
        self.updateFocus()
        //debuginfo()
    }
    
    fileprivate func switchViews(_ index:ViewType){
        m_exposure_view.isHidden = true
        m_focus_view.isHidden = true
        m_zoom_view.isHidden = true
        m_more_view.isHidden = true
        
        if index == ViewType.exposure {
            m_exposure_view.isHidden = false
            m_exposure_tittle.text = GBLanguageStoreGen.instance()?.getString("exposure_tittle");
            m_exposure_control.setTitle(GBLanguageStoreGen.instance()?.getString("exposure_lock"), forSegmentAt: 0)
            m_exposure_control.setTitle(GBLanguageStoreGen.instance()?.getString("exposure_dynamic"), forSegmentAt: 1)
            m_exposure_control.setTitle(GBLanguageStoreGen.instance()?.getString("exposure_manual"), forSegmentAt: 2)
            m_exposure_control.setTitle(GBLanguageStoreGen.instance()?.getString("exposure_touch"), forSegmentAt: 3)
            
            let exposure_mode:GBCameraExposureMode = GBCameraControllerImp.instance.getExposureMode()
            switch exposure_mode {
            case GBCameraExposureMode.locked:
                m_exposure_control.selectedSegmentIndex = 0
                m_exposure_value_slider.isEnabled = false
                m_iso_value_slider.isEnabled = false
                break
            case GBCameraExposureMode.autoExpose:
                m_exposure_control.selectedSegmentIndex = 1
                m_exposure_value_slider.isEnabled = false
                m_iso_value_slider.isEnabled = false
                break
            case GBCameraExposureMode.continuousAutoExposure:
                m_exposure_control.selectedSegmentIndex = 1
                m_exposure_value_slider.isEnabled = false
                m_iso_value_slider.isEnabled = false
                break
            case GBCameraExposureMode.modeCustom:
                m_exposure_control.selectedSegmentIndex = 2
                m_exposure_value_slider.isEnabled = true
                m_iso_value_slider.isEnabled = true
                break
            default:
                break
            }
            
            //m_exposure_value_slider.maximumValue = GBCameraControllerImp.instance.getExposureMaxDuration()
            //m_exposure_value_slider.minimumValue = GBCameraControllerImp.instance.getExposureMinDuration()
            self.updateExposure()
            m_iso_value_slider.maximumValue = Float(GBCameraControllerImp.instance.getISOMax())
            m_iso_value_slider.minimumValue = Float(GBCameraControllerImp.instance.getISOMin())
        }
        else if index == ViewType.focus {
            m_focus_view.isHidden = false
            m_focus_tittle.text = GBLanguageStoreGen.instance()?.getString("focus_tittle");
            m_focus_control.setTitle(GBLanguageStoreGen.instance()?.getString("focus_lock"), forSegmentAt: 0)
            m_focus_control.setTitle(GBLanguageStoreGen.instance()?.getString("focus_dynamic"), forSegmentAt: 1)
            m_focus_control.setTitle(GBLanguageStoreGen.instance()?.getString("focus_touch"), forSegmentAt: 2)
            
            let focus_mode:GBCameraFocusMode = GBCameraControllerImp.instance.getFocusMode()
            switch focus_mode {
            case GBCameraFocusMode.locked:
                m_focus_control.selectedSegmentIndex = 0
                break
            case GBCameraFocusMode.autoFocus:
                m_focus_control.selectedSegmentIndex = 0
                break
            case GBCameraFocusMode.continuousAutoFocus:
                m_focus_control.selectedSegmentIndex = 1
                break
            default:
                break
            }
            m_focus_slider.maximumValue = GBCameraControllerImp.instance.getFocusMax()
            m_focus_slider.minimumValue = GBCameraControllerImp.instance.getFocusMin()
            self.updateFocus()
        }
        else if index == ViewType.zoom {
            m_zoom_view.isHidden = false
            m_zoom_tittle.text = GBLanguageStoreGen.instance()?.getString("zoom_tittle")
            
            m_zoom_slider.maximumValue = GBCameraControllerImp.instance.getZoomMax()
            m_zoom_slider.minimumValue = GBCameraControllerImp.instance.getZoomMin()
            self.updateZoom()
        }
        else if index == ViewType.more {
            m_more_view.isHidden = false
            m_more_tittle.text = GBLanguageStoreGen.instance()?.getString("camera_more_tittle")
            m_lighting_segment.setTitle(GBLanguageStoreGen.instance()?.getString("lighting_auto"), forSegmentAt: 0)
            m_lighting_segment.setTitle(GBLanguageStoreGen.instance()?.getString("lighting_on"), forSegmentAt: 1)
            m_lighting_segment.setTitle(GBLanguageStoreGen.instance()?.getString("lighting_off"), forSegmentAt: 2)
            
            let flash_mode:GBCameraFlash = GBCameraControllerImp.instance.getFlashMode()
            switch flash_mode {
            case GBCameraFlash.auto:
                m_lighting_segment.selectedSegmentIndex = 0
                break
            case GBCameraFlash.on:
                m_lighting_segment.selectedSegmentIndex = 1
                break
            case GBCameraFlash.off:
                m_lighting_segment.selectedSegmentIndex = 2
                break
            default:
                break
            }
        }
    }
    
    var m_expose_set:Int = 0
    fileprivate func updateExposure(){
        if m_exposure_view.isHidden &&
            GBCameraControllerImp.instance.getExposureMode() == GBCameraExposureMode.modeCustom{
            return
        }
        if m_expose_set < 0 {
            m_expose_set += m_slider_update
            return
        }
        let duration = GBCameraControllerImp.instance.getExposureDuration()
        self.setExposureLabel(duration: duration)
        
        let iso = GBCameraControllerImp.instance.getISO()
        m_iso_value.text = String(iso)
        
        m_iso_value_slider.setValue(Float(iso), animated: false)
        m_exposure_value_slider.setValue(exposure_to_slider(duration: duration), animated: false)
        
        let ev = GBCameraControllerImp.instance.getEV()
        m_ev_label.text = String.init(format: "%.01f", ev)
        
        m_ev_slider.setValue(ev, animated: false)
    }
    
    fileprivate func setExposureLabel(duration:Float){
        let under = 1/duration
        var text:String?
        if under >= 10 {
            text = String(format: "1/%.00f", under)
        }
        else{
            text = String(format: "1/%.01f", under)
        }
        m_exposure_value.text = text
    }
    
    fileprivate func updateFocus(){
        if m_focus_view.isHidden || GBCameraControllerImp.instance.getFocusMode() == GBCameraFocusMode.locked{
            return
        }
        
        let focus = GBCameraControllerImp.instance.getFocusLens()
        m_focus_slider.setValue(focus, animated: false)
    }
    
    fileprivate func updateZoom() {
        if m_zoom_view.isHidden {
            return
        }
        
        let zoom = GBCameraControllerImp.instance.getZoom()
        m_zoom_slider.setValue(zoom, animated: false)
    }
    
    /*func addObserver() {
        
    }
    
    func removeObserver() {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }*/
    
    fileprivate func debuginfo(){
        var text:String = ""
        if !m_exposure_view.isHidden {
            let duration = GBCameraControllerImp.instance.getExposureDurationCMT()
            let iso = GBCameraControllerImp.instance.getISO()
            text = String("dration: \(duration!.value):\(duration!.timescale) second:\(duration!.seconds) max:\(GBCameraControllerImp.instance.getExposureMaxDuration()) min:\(GBCameraControllerImp.instance.getExposureMinDuration()) mode:\(GBCameraControllerImp.instance.getExposureMode().rawValue)\n iso: \(iso) max:\(GBCameraControllerImp.instance.getISOMax()) min:\(GBCameraControllerImp.instance.getISOMin())")
        }
        else if !m_focus_view.isHidden{
            
        }
        else if !m_zoom_view.isHidden{
            
        }
        
        m_debug_overlay.text = text
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
