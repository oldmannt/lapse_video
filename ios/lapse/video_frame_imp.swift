//
//  video_frame_imp.swift
//  lapse_app
//
//  Created by dyno on 7/25/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import Foundation

class GBVideoFrameImp: NSObject, GBVideoFrameGen {
    
    @objc internal func getData() -> Int64{
        return m_data
    }
    
    @objc internal func getWidth() -> Int32{
        return m_width
    }
    
    @objc internal func getHeight() -> Int32{
        return m_height
    }
    
    @objc internal func getSize() -> Int64{
        return m_size
    }
    
    var m_width:Int32 = 0
    var m_height:Int32 = 0
    var m_size:Int64 = 0
    var m_data:Int64 = 0
}