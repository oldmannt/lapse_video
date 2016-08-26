//
//  ReviewViewController.swift
//  lapse_app
//
//  Created by dyno on 8/9/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit
import AVKit

class ReviewViewController: AVPlayerViewController {
    let m_player_layer:AVPlayerLayer = AVPlayerLayer()
    var m_movie_player : AVPlayer?
    //var m_video_item : AVPlayerItem?
    @IBOutlet weak var m_video_video: UIView!
    
    var m_video_file:String = String(){
    willSet{
        if newValue != m_video_file{
            unloadVideo()
        }
        }// willSet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //btn_show(nil)
        m_player_layer.frame = m_video_video.layer.frame
        m_player_layer.videoGravity = AVLayerVideoGravityResizeAspect
        m_video_video.layer.addSublayer(m_player_layer)
    }
    
    override func viewWillAppear(animated: Bool) {
        if nil == m_movie_player {
            loadVideo()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadVideo(){
        if m_video_file.isEmpty {
            return
        }
        
        let url:NSURL = NSURL(fileURLWithPath:m_video_file)
        
        m_movie_player = AVPlayer(URL: url)
        m_player_layer.player = m_movie_player
        m_player_layer.frame = m_video_video.layer.frame
        m_movie_player?.play()
    }
    
    private func unloadVideo(){
        m_movie_player = nil
        m_player_layer.player = nil
    }
}
