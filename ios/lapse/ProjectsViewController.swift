//
//  ProjectsViewController.swift
//  lapse_app
//
//  Created by dyno on 8/13/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class ProjectsViewController: PopbaseUIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var m_btn_back: UIButton!
    @IBOutlet weak var m_table_view: UITableView!
    
    var m_project_setting_view: ProjectSettingView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_project_setting_view = ProjectSettingView(nibName: "project_setting_view", bundle: nil)
        m_project_setting_view?.setPopbase(self)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ProjectsViewController.longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // Do any additional setup after loading the view.
        //GBTaskManagerGen.instance()?.addTaskI(Int64(LPALapseEvent.ProjectsShow.rawValue), task: nil)
        let cell = m_table_view.dequeueReusableCellWithIdentifier("project_cell") as! PorjectCell
        LPAProjectListGen.instance()?.load(Int32(cell.m_video_review.frame.width)
            , reviewH: Int32(cell.m_video_review.frame.height))
        m_table_view.reloadData()
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
        LPAProjectListGen.instance()?.watchProject(Int32(indexPath.row))
    }

    @IBAction func btnBackClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            let touchPoint = longPressGestureRecognizer.locationInView(self.m_table_view)
            if let indexPath = m_table_view.indexPathForRowAtPoint(touchPoint) {
                // your code here, get the row for the indexPath or do whatever you want
                LPAProjectListGen.instance()?.selectProject(Int32(indexPath.row))
                let cell = m_table_view.cellForRowAtIndexPath(indexPath)
                let pos = cell?.convertPoint(CGPoint(x:0,y:0), toView: self.view)
                self.presentpopupViewController(m_project_setting_view!, pos: pos!, size: (cell?.contentView.frame.size)!,animationType: .RightLeft, completion: nil)
            }
        }
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
