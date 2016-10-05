//
//  ProjectSettingView.swift
//  lapse_app
//
//  Created by dyno on 10/2/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class ProjectSettingView: PopupViewController {
   
    @IBOutlet weak var m_btn_watch: UIButton!
    @IBOutlet weak var m_btn_publish: UIButton!
    @IBOutlet weak var m_btn_save: UIButton!
    @IBOutlet weak var m_btn_delete: UIButton!
    @IBOutlet weak var m_btn_dissmiss: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.screenRotate), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        //setBtnSpace()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func screenRotate() {
        //print("screen rotate: \(UIApplication.sharedApplication().statusBarOrientation)")
        //let ori:UIDeviceOrientation = UIDevice.currentDevice().orientation
        //setBtnSpace()
        self.dissmissPopup(.LeftRight)
    }
    
    func setBtnSpace() {
        let view_width = self.view.frame.size.width
        let space = view_width - 2*m_btn_watch.frame.size.width
        
        m_btn_publish.center.x = space/6
        m_btn_save.center.x = space/2
        m_btn_delete.center.x = space*5/6
    }
    
    @IBAction func tapDismiss(sender: AnyObject) {
        self.dissmissPopup(.LeftRight)
    }
    
    @IBAction func tapDelete(sender: AnyObject) {
        self.dissmissPopup(.LeftRight)
    }

    @IBAction func tapSave(sender: AnyObject) {
        self.dissmissPopup(.LeftRight)
    }
    
    @IBAction func tapPublish(sender: AnyObject) {
        self.dissmissPopup(.LeftRight)
    }
    
    @IBAction func tapWatch(sender: AnyObject) {
        self.dissmissPopup(.LeftRight)
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
