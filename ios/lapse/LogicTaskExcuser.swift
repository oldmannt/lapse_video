//
//  LogicTaskExcuser.swift
//  lapse_app
//
//  Created by dyno on 8/9/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class LogicTaskExcuserImp : GBTaskExcuserGen {
    static let sharedInstance = LogicTaskExcuserImp()
    
    var m_capture_vc:ViewController?
    @objc internal func excuse(info: GBTaskInfoGen?){
        print("LogicTaskExcuserImp excuse, id:\(info?.getTaskId()) data:\(info?.getData())")
        if (info?.getTaskId() == Int64(LPALapseEvent.ReviewOpen.rawValue)){
            openReviewViewController((info?.getData())!)
        }
    }
    
    func openReviewViewController(video:String) {
        let player = AVPlayerViewController()
        let url:NSURL = NSURL(fileURLWithPath:video)
        player.player = AVPlayer(URL: url)
        
        let current_vc = UIApplication.sharedApplication().keyWindow?.rootViewController
        if nil==current_vc{
            GBLogGen.instance()?.logerrf("openReviewViewController current_vc null")
            return
        }
        
        current_vc!.presentViewController(player, animated: false, completion: nil)

    }
    
    func showViewController(id:String, animated: Bool) {
        let current_vc = UIApplication.sharedApplication().keyWindow?.rootViewController
        if nil==current_vc{
            GBLogGen.instance()?.logerrf("showViewController current_vc null")
            return
        }
        
        let next_vc = current_vc?.storyboard?.instantiateViewControllerWithIdentifier(id)
        current_vc?.presentViewController(next_vc!, animated: false, completion: nil)
    }
    
}
