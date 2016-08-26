//
//  ProjectsViewController.swift
//  lapse_app
//
//  Created by dyno on 8/13/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var m_btn_back: UIButton!
    @IBOutlet weak var m_table_view: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.ProjectsShow.rawValue), task: nil)
        let cell = m_table_view.dequeueReusableCellWithIdentifier("project_cell") as! PorjectCell
        LPAProjectListGen.instance()?.load(Int32(cell.m_video_review.frame.width)
                                , reviewH: Int32(cell.m_video_review.frame.height))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int((LPAProjectListGen.instance()?.getProjectAmount())!)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.m_table_view.dequeueReusableCellWithIdentifier("project_cell", forIndexPath: indexPath) as! PorjectCell
        
        let cell_data:LPAProjectCellGen? = LPAProjectListGen.instance()?.getProjectData(Int32(indexPath.row));

        if nil == cell_data {
            GBLogGen.instance()?.logerrf("cell data nil \(indexPath)")
            return cell
        }
        GBLogGen.instance()?.logerrf("cell index:\(indexPath) name:\(cell_data?.getName()) fps:\(cell_data?.getFps()) time:\(cell_data?.getCreateTime()) length:\(cell_data?.getLength()) path:\(cell_data?.getPath())")
        
        cell.m_video_name.text = cell_data?.getName()
        cell.m_fps.text = cell_data?.getFps()
        cell.m_video_create_time.text = cell_data?.getCreateTime()
        cell.m_video_length.text = cell_data?.getLength()
        cell.m_video_review.image = ObjcUtility.VideoReview2UIImage((cell_data?.getPath())!)

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        LPAProjectListGen.instance()?.selectPrject(Int32(indexPath.row))
    }

    @IBAction func btnBackClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
