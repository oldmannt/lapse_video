//
//  LapseSetterView.swift
//  lapse_app
//
//  Created by dyno on 8/27/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class LapseSetterView: PopupViewController, LPALapseSettingDlgDelegate {

    @IBOutlet weak var m_lblTittle: UILabel!
    @IBOutlet weak var m_txtInterval: UITextField!
    @IBOutlet weak var m_txtFps: UITextField!
    @IBOutlet weak var m_segMode: UISegmentedControl!
    @IBOutlet weak var m_lapse_uint: UILabel!
    @IBOutlet weak var m_fps_uint: UILabel!
    
    var m_txt_fps_timer:Timer?
    var m_txt_lapse_timer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        m_lblTittle.text = GBLanguageStoreGen.instance()?.getString("capture_interval")
        m_lapse_uint.text = GBLanguageStoreGen.instance()?.getString("capture_second")
        m_fps_uint.text = GBLanguageStoreGen.instance()?.getString("video_info_frame")
        
        m_segMode.setTitle(GBLanguageStoreGen.instance()?.getString("mode_lapse"), forSegmentAt: 0)
        m_segMode.setTitle(GBLanguageStoreGen.instance()?.getString("mode_slomo"), forSegmentAt: 1)
        
        LPALapseSettingDlgGen.instance()?.onLoad(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LPALapseSettingDlgGen.instance()?.onShow()
    }
    
    @IBAction func selectSLoLapse(_ sender: UISegmentedControl) {
        var mode:LPAIntervalMode = .lapse
        if sender.selectedSegmentIndex == 1{
            mode = .slomo
        }
        LPALapseSettingDlgGen.instance()?.onSelectInterval(mode)
    }
    
    @IBAction func txtLapseChange(_ sender: UITextField) {
        var mode:LPAIntervalMode = .lapse
        if m_segMode.selectedSegmentIndex == 1{
            mode = .slomo
        }

        LPALapseSettingDlgGen.instance()?.onLapseChange(mode, lapse: (sender.text! as NSString).floatValue)
    }
    
    @IBAction func txtFpsChange(_ sender: UITextField) {
        LPALapseSettingDlgGen.instance()?.onFpsChange((m_txtFps.text! as NSString).intValue)
            /*
        (m_txt_fps_timer?.invalidate())!
        m_txt_fps_timer = nil
        m_txt_fps_timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(LapseSetterView.delayHandleTxt), userInfo: nil, repeats: false)
         */
    }
    
    func delayHandleTxt() {

        m_txt_fps_timer?.invalidate()
        m_txt_fps_timer = nil
        
        let alert:UIAlertController = UIAlertController(title: "alert", message: "fps out of range", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (act:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.m_popbase?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btn_cancel_tap(_ sender: UIButton) {
        self.dissmissPopup(animationType: .fade)
    }

    @IBAction func btnSaveTap(_ sender: AnyObject) {
        let mode = getIntervalMode(index: m_segMode.selectedSegmentIndex)
        let fps:Int32 = (m_txtFps.text! as NSString).intValue
        let lapse:Float = (m_txtInterval.text! as NSString).floatValue
        LPALapseSettingDlgGen.instance()?.onSave(fps, lapse: lapse, mode: mode)
        self.dissmissPopup(animationType: .fade)
    }
    
    public func updateSegMode(_ mode: LPAIntervalMode){
        if mode == .lapse {
            m_segMode.selectedSegmentIndex = 0
            m_txtInterval.isUserInteractionEnabled = true
            m_lapse_uint.text = GBLanguageStoreGen.instance()?.getString("capture_second")
        }
        else if mode == .slomo{
            m_segMode.selectedSegmentIndex = 1
            m_txtInterval.isUserInteractionEnabled = false
            m_lapse_uint.text = GBLanguageStoreGen.instance()?.getString("capture_mill_second")
        }
        else {
            m_segMode.isHidden = true
        }
    }
    
    public func updateFps(_ fps: Int32){
        m_txtFps.text = "\(fps)"
    }
    
    public func updateLapse(_ lapse: Float){
        m_txtInterval.text = "\(lapse)"
    }
    
    public func getFps() -> Int32{
        return (m_txtFps.text! as NSString).intValue
    }
    
    public func getLapse() -> Float{
        return (m_txtInterval.text! as NSString).floatValue
    }
    
    func getIntervalMode(index:Int) -> LPAIntervalMode {
        if index == 0 {
            return LPAIntervalMode.lapse
        }
        return LPAIntervalMode.slomo
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
