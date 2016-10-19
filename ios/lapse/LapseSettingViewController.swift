//
//  LapseSettingViewController.swift
//  lapse_app
//
//  Created by dyno on 10/9/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class LapseSettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,
LPALapseSettingUiGen{

    @IBOutlet weak var m_quick_pick: UIPickerView!
    @IBOutlet weak var m_slider_fps: UISlider!
    @IBOutlet weak var m_slider_lapse: UISlider!
    @IBOutlet weak var m_label_fps: UILabel!
    @IBOutlet weak var m_label_lapse: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        m_quick_pick.dataSource = self
        m_quick_pick.delegate = self
        LPALapseSettingGen.instance()?.onLoad(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        if self.view.isHidden {
            LPALapseSettingGen.instance()?.clean()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LPALapseSettingGen.instance()?.onShow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LPALapseSettingGen.instance()?.onHide()
    }
    
    public func initializeSliberFps(_ min: Int32, max: Int32){
        m_slider_fps.maximumValue = Float(max)
        m_slider_fps.minimumValue = Float(min)
    }
    
    public func initializeSliberLapse(_ min: Int32, max: Int32){
        m_slider_lapse.maximumValue = Float(max)
        m_slider_lapse.minimumValue = Float(min)
    }
    
    public func updateFps(_ fps: Int32){
        m_slider_fps.setValue(Float(fps), animated: true)
        m_label_fps.text = "\(fps)"
    }
    
    public func updateLapse(_ lapse: Int32){
        m_slider_lapse.setValue(Float(lapse), animated: true)
        m_label_lapse.text = "\(lapse)"
    }
    
    public func updatePicker(_ index: Int32){
        if m_quick_pick.numberOfRows(inComponent: 0) <= Int(index) {
            return
        }
        m_quick_pick.selectRow(Int(index), inComponent: 0, animated: true)
    }
    
    @IBAction func tapBack(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return Int((LPALapseSettingGen.instance()?.getQuickModeCount())!)
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return LPALapseSettingGen.instance()?.getQuickModeName(Int32(row))
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        LPALapseSettingGen.instance()?.selectQuickMode(Int32(row))
    }

    @IBAction func sliderFps(_ sender: AnyObject) {
        LPALapseSettingGen.instance()?.setFps(Int32(self.m_slider_fps.value));
    }
    
    @IBAction func sliderLapse(_ sender: AnyObject) {
        LPALapseSettingGen.instance()?.setLapse(Int32(self.m_slider_lapse.value));
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
