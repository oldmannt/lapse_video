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
    @objc internal func excuse(_ info: GBTaskInfoGen?){
        //print("LogicTaskExcuserImp excuse, id:\(info?.getTaskId()) data:\(info?.getData())")
        if (info?.getTaskId() == Int64(LPALapseEvent.reviewOpen.rawValue)){
            openReviewViewController((info?.getData())!)
        }
    }
    
    func openReviewViewController(_ video:String) {
        let player = AVPlayerViewController()
        let url:URL = URL(fileURLWithPath:video)
        player.player = AVPlayer(url: url)
        
        let current_vc = UIApplication.shared.keyWindow?.rootViewController
        if nil==current_vc{
            GBLogGen.instance()?.logerrf("openReviewViewController current_vc null")
            return
        }
        
        current_vc!.present(player, animated: false, completion: nil)

    }
    
    func showViewController(_ id:String, animated: Bool) {
        let current_vc = UIApplication.shared.keyWindow?.rootViewController
        if nil==current_vc{
            GBLogGen.instance()?.logerrf("showViewController current_vc null")
            return
        }
        
        let next_vc = current_vc?.storyboard?.instantiateViewController(withIdentifier: id)
        current_vc?.present(next_vc!, animated: false, completion: nil)
    }
    
}
