//
//  PorjectCell.swift
//  lapse_app
//
//  Created by dyno on 8/13/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class PorjectCell: UITableViewCell {

    @IBOutlet weak var m_video_length: UILabel!
    @IBOutlet weak var m_fps: UILabel!
    @IBOutlet weak var m_video_create_time: UILabel!
    @IBOutlet weak var m_video_name: UILabel!
    @IBOutlet weak var m_video_review: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
