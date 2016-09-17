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
        case Exposure = 0
        case Focus;
        case Zoom;
        case More;
        
        static func fromIndex(index:Int) -> ViewType {
            switch index {
            case 0:
                return Exposure
            case 1:
                return Focus
            case 2:
                return Zoom
            case 3:
                return More
            default:
                return Exposure
            }
        }
    }
    
    var m_curViewType:ViewType = .Exposure
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let transparent:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        m_exposure_view.backgroundColor = UIColor.clearColor()
        m_focus_view.backgroundColor = UIColor.clearColor()
        m_zoom_view.backgroundColor = UIColor.clearColor()
        m_more_view.backgroundColor = UIColor.clearColor()
        
        m_exposure_value_slider.maximumValue = GBCameraControllerImp.instance.getExposureMaxDuration()
        m_exposure_value_slider.minimumValue = GBCameraControllerImp.instance.getExposureMaxDuration()
        
        m_updateCamera = GBTimerGen.create(0, interval: 300, repeatTimes: -1, hander: self)
        m_debug_overlay.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        switchViews(ViewType.Exposure)
        m_switch_views.selectedSegmentIndex = 0
        m_updateCamera?.start()
    }
    
    override func viewWillDisappear(animated: Bool) {
        m_updateCamera?.pause()
    }
    
    @IBAction func switch_view_segment_change(sender: UISegmentedControl) {
        switchViews(ViewType.fromIndex(sender.selectedSegmentIndex))
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dissmissPopup(.Fade)
    }

    @IBAction func flashSegmentChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            GBCameraControllerImp.instance.setFlashMode(GBCameraFlash.Auto)
        case 1:
            GBCameraControllerImp.instance.setFlashMode(GBCameraFlash.On)
        case 2:
            GBCameraControllerImp.instance.setFlashMode(GBCameraFlash.Off)
        default:
            break
        }
    }
    
    @IBAction func focus_segment_change(sender: AnyObject) {
        switch m_focus_control.selectedSegmentIndex {
        case 0:
            GBCameraControllerImp.instance.setFocusMode(GBCameraFocusMode.Locked)
            m_focus_slider.enabled = true
        case 1:
            GBCameraControllerImp.instance.setFocusMode(GBCameraFocusMode.ContinuousAutoFocus)
            m_focus_slider.enabled = false
        case 2:
            let vc:ViewController = super.m_popbase as! ViewController
            self.dissmissPopup(.None)
            vc.showFocusSel(CGPoint(x: -1,y: -1))
        default: break
            
        }
    }

    @IBAction func focus_slider_change(sender: UISlider) {
        GBCameraControllerImp.instance.setFocusLens(sender.value)
        m_focus_control.selectedSegmentIndex = 0
    }
    
    @IBAction func zoom_slider_change(sender: AnyObject) {
        GBCameraControllerImp.instance.setZoom(sender.value)
    }


    @IBAction func exposure_control_select(sender: AnyObject) {
        switch m_exposure_control.selectedSegmentIndex {
        case 0:
            GBCameraControllerImp.instance.setExposureMode(GBCameraExposureMode.Locked)
            m_exposure_value_slider.enabled = false
            m_iso_value_slider.enabled = false
            break
        case 1:
            GBCameraControllerImp.instance.setExposureMode(GBCameraExposureMode.ContinuousAutoExposure)
            m_exposure_value_slider.enabled = false
            m_iso_value_slider.enabled = false
            break
        case 2:
            GBCameraControllerImp.instance.setExposureMode(GBCameraExposureMode.ModeCustom)
            m_exposure_value_slider.enabled = true
            m_iso_value_slider.enabled = true
            break
        case 3:
            let vc:ViewController = super.m_popbase as! ViewController
            self.dissmissPopup(.None)
            vc.showExposure(CGPoint(x: -1,y: -1))
            break
        default:
            break
        }
    }
    
    @IBAction func exposure_slider_change(sender: UISlider) {
        //print("exposure_slider_change \(sender.value)")
        GBCameraControllerImp.instance.setExposureDuration(sender.value)
    }
    
    @IBAction func iso_slider_change(sender: UISlider) {
        //print("iso_slider_change \(sender.value)")
        GBCameraControllerImp.instance.setISO(Int32(sender.value))
    }
    
    @objc func excuse(info: GBTaskInfoGen?){
        self.updateExposure()
        self.updateZoom()
        self.updateFocus()
        //debuginfo()
    }
    
    private func switchViews(index:ViewType){
        m_exposure_view.hidden = true
        m_focus_view.hidden = true
        m_zoom_view.hidden = true
        m_more_view.hidden = true
        
        if index == ViewType.Exposure {
            m_exposure_view.hidden = false
            m_exposure_tittle.text = GBLanguageStoreGen.instance()?.getString("exposure_tittle");
            m_exposure_control.setTitle(GBLanguageStoreGen.instance()?.getString("exposure_lock"), forSegmentAtIndex: 0)
            m_exposure_control.setTitle(GBLanguageStoreGen.instance()?.getString("exposure_dynamic"), forSegmentAtIndex: 1)
            m_exposure_control.setTitle(GBLanguageStoreGen.instance()?.getString("exposure_manual"), forSegmentAtIndex: 2)
            m_exposure_control.setTitle(GBLanguageStoreGen.instance()?.getString("exposure_touch"), forSegmentAtIndex: 3)
            
            let exposure_mode:GBCameraExposureMode = GBCameraControllerImp.instance.getExposureMode()
            switch exposure_mode {
            case GBCameraExposureMode.Locked:
                m_exposure_control.selectedSegmentIndex = 0
                m_exposure_value_slider.enabled = false
                m_iso_value_slider.enabled = false
                break
            case GBCameraExposureMode.AutoExpose:
                m_exposure_control.selectedSegmentIndex = 1
                m_exposure_value_slider.enabled = false
                m_iso_value_slider.enabled = false
                break
            case GBCameraExposureMode.ContinuousAutoExposure:
                m_exposure_control.selectedSegmentIndex = 1
                m_exposure_value_slider.enabled = false
                m_iso_value_slider.enabled = false
                break
            case GBCameraExposureMode.ModeCustom:
                m_exposure_control.selectedSegmentIndex = 2
                m_exposure_value_slider.enabled = true
                m_iso_value_slider.enabled = true
                break
            default:
                break
            }
            
            m_exposure_value_slider.maximumValue = GBCameraControllerImp.instance.getExposureMaxDuration()
            m_exposure_value_slider.minimumValue = GBCameraControllerImp.instance.getExposureMinDuration()
            self.updateExposure()
            m_iso_value_slider.maximumValue = Float(GBCameraControllerImp.instance.getISOMax())
            m_iso_value_slider.minimumValue = Float(GBCameraControllerImp.instance.getISOMin())
        }
        else if index == ViewType.Focus {
            m_focus_view.hidden = false
            m_focus_tittle.text = GBLanguageStoreGen.instance()?.getString("focus_tittle");
            m_focus_control.setTitle(GBLanguageStoreGen.instance()?.getString("focus_lock"), forSegmentAtIndex: 0)
            m_focus_control.setTitle(GBLanguageStoreGen.instance()?.getString("focus_dynamic"), forSegmentAtIndex: 1)
            m_focus_control.setTitle(GBLanguageStoreGen.instance()?.getString("focus_touch"), forSegmentAtIndex: 2)
            
            let focus_mode:GBCameraFocusMode = GBCameraControllerImp.instance.getFocusMode()
            switch focus_mode {
            case GBCameraFocusMode.Locked:
                m_focus_control.selectedSegmentIndex = 0
                break
            case GBCameraFocusMode.AutoFocus:
                m_focus_control.selectedSegmentIndex = 0
                break
            case GBCameraFocusMode.ContinuousAutoFocus:
                m_focus_control.selectedSegmentIndex = 1
                break
            default:
                break
            }
            m_focus_slider.maximumValue = GBCameraControllerImp.instance.getFocusMax()
            m_focus_slider.minimumValue = GBCameraControllerImp.instance.getFocusMin()
            self.updateFocus()
        }
        else if index == ViewType.Zoom {
            m_zoom_view.hidden = false
            m_zoom_tittle.text = GBLanguageStoreGen.instance()?.getString("zoom_tittle")
            
            m_zoom_slider.maximumValue = GBCameraControllerImp.instance.getZoomMax()
            m_zoom_slider.minimumValue = GBCameraControllerImp.instance.getZoomMin()
            self.updateZoom()
        }
        else if index == ViewType.More {
            m_more_view.hidden = false
            m_more_tittle.text = GBLanguageStoreGen.instance()?.getString("camera_more_tittle")
            m_lighting_segment.setTitle(GBLanguageStoreGen.instance()?.getString("lighting_auto"), forSegmentAtIndex: 0)
            m_lighting_segment.setTitle(GBLanguageStoreGen.instance()?.getString("lighting_on"), forSegmentAtIndex: 1)
            m_lighting_segment.setTitle(GBLanguageStoreGen.instance()?.getString("lighting_off"), forSegmentAtIndex: 2)
            
            let flash_mode:GBCameraFlash = GBCameraControllerImp.instance.getFlashMode()
            switch flash_mode {
            case GBCameraFlash.Auto:
                m_lighting_segment.selectedSegmentIndex = 0
                break
            case GBCameraFlash.On:
                m_lighting_segment.selectedSegmentIndex = 1
                break
            case GBCameraFlash.Off:
                m_lighting_segment.selectedSegmentIndex = 2
                break
            default:
                break
            }
        }
    }
    
    private func updateExposure(){
        if m_exposure_view.hidden || GBCameraControllerImp.instance.getExposureMode() == GBCameraExposureMode.ModeCustom{
            return
        }
        let duration = GBCameraControllerImp.instance.getExposureDuration()
        m_exposure_value_slider.setValue(duration, animated: false)
        let under = 1/duration
        var text:String?
        if under >= 10 {
            text = String(format: "1/%.00f", under)
        }
        else{
            text = String(format: "1/%.01f", under)
        }
        m_exposure_value.text = text
        
        let iso = GBCameraControllerImp.instance.getISO()
        m_iso_value_slider.setValue(Float(iso), animated: false)
        m_iso_value.text = String(iso)
    }
    
    private func updateFocus(){
        if m_focus_view.hidden || GBCameraControllerImp.instance.getFocusMode() == GBCameraFocusMode.Locked{
            return
        }
        
        let focus = GBCameraControllerImp.instance.getFocusLens()
        m_focus_slider.setValue(focus, animated: false)
    }
    
    private func updateZoom() {
        if m_zoom_view.hidden {
            return
        }
        
        let zoom = GBCameraControllerImp.instance.getZoom()
        m_zoom_slider.setValue(zoom, animated: false)
    }
    
    private func debuginfo(){
        var text:String = ""
        if !m_exposure_view.hidden {
            let duration = GBCameraControllerImp.instance.getExposureDurationCMT()
            let iso = GBCameraControllerImp.instance.getISO()
            text = String("dration: \(duration!.value):\(duration!.timescale) second:\(duration!.seconds) max:\(GBCameraControllerImp.instance.getExposureMaxDuration()) min:\(GBCameraControllerImp.instance.getExposureMinDuration()) mode:\(GBCameraControllerImp.instance.getExposureMode().rawValue)\n iso: \(iso) max:\(GBCameraControllerImp.instance.getISOMax()) min:\(GBCameraControllerImp.instance.getISOMin())")
        }
        else if !m_focus_view.hidden{
            
        }
        else if !m_zoom_view.hidden{
            
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
