//
//  PublishView.swift
//  lapse_app
//
//  Created by dyno on 10/5/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class PublishView: PopupViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapDismiss(_ sender: AnyObject) {
        super.dissmissPopup(animationType: .bottomBottom)
    }

    @IBAction func tapFacebook(_ sender: AnyObject) {
        super.dissmissPopup(animationType: .bottomBottom)
        
        let cell_data:LPAProjectCellGen? =  LPAProjectListGen.instance()?.getProjectData(-1)
        if nil != cell_data{

        }

    }
    
    @IBAction func tapYoutube(_ sender: AnyObject) {
    }
    
    @IBAction func tapMiaopai(_ sender: AnyObject) {
    }

    @IBAction func tapMore(_ sender: AnyObject) {
        
        let cell_data:LPAProjectCellGen? =  LPAProjectListGen.instance()?.getProjectData(-1)
        if nil != cell_data{
            
            let video_url:URL = URL(fileURLWithPath: cell_data!.getPath())
            let activity_vc = UIActivityViewController(activityItems: [video_url], applicationActivities: nil)
            super.m_popbase?.present(activity_vc, animated: true, completion: nil)
        }
        
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
