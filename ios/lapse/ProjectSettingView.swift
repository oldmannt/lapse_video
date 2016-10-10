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

    @IBAction func tapDismiss(_ sender: AnyObject) {
        self.dissmissPopup(animationType: .leftRight)
    }
    
    @IBAction func tapDelete(_ sender: AnyObject) {
        LPAProjectListGen.instance()?.deleteProject(-1)
        self.dissmissPopup(animationType: .leftRight)
    }

    @IBAction func tapSave(_ sender: AnyObject) {
        LPAProjectListGen.instance()?.saveProject(-1)
        self.dissmissPopup(animationType: .leftRight)
    }
    
    @IBAction func tapPublish(_ sender: AnyObject) {
        self.dissmissPopup(animationType: .leftRight)
        //GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.projectsPublish.rawValue), task: nil)
        let cell_data:LPAProjectCellGen? =  LPAProjectListGen.instance()?.getProjectData(-1)
        if nil != cell_data{
            
            let video_url:URL = URL(fileURLWithPath: cell_data!.getPath())
            let activity_vc = UIActivityViewController(activityItems: [video_url], applicationActivities: nil)
            super.m_popbase?.present(activity_vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapWatch(_ sender: AnyObject) {
        self.dissmissPopup(animationType: .leftRight)
        LPAProjectListGen.instance()?.watchProject(-1)
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
