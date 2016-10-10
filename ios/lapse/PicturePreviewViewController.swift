//
//  PicturePreviewViewController.swift
//  lapse_app
//
//  Created by dyno on 9/2/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class PicturePreviewViewController: UIViewController {

    @IBOutlet weak var m_preview_image: UIImageView!
    
    var m_image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        m_preview_image.image = m_image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPreviewImage(_ image:UIImage) -> Void {
        m_image = image
    }

    @IBAction func tapBack(_ sender: AnyObject) {
        dismiss(animated: false, completion: nil)
    }

    @IBAction func tapSave(_ sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(m_image!, nil, nil, nil)
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
