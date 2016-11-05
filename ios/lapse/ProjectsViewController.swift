//
//  ProjectsViewController.swift
//  lapse_app
//
//  Created by dyno on 8/13/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class ProjectsViewController: PopbaseUIViewController, UITableViewDataSource, UITableViewDelegate, GBTaskExcuserGen {

    @IBOutlet weak var m_btn_back: UIButton!
    @IBOutlet weak var m_table_view: UITableView!
    @IBOutlet weak var m_view_tittle: UINavigationItem!
    
    var m_project_setting_view: ProjectSettingView?
    var m_publish_view: PublishView?
    
    @objc func excuse(_ info: GBTaskInfoGen?){
        if info?.getTaskId() == Int64(LPALapseEvent.projectsListUpdateDelete.rawValue){
            let indexPath: IndexPath = IndexPath(row: Int((info?.getIValue("index"))!), section: 0)
            self.deleteItem(index: indexPath)
        }
        else if info?.getTaskId() == Int64(LPALapseEvent.projectsListUpdateAdd.rawValue){
            let indexPath: IndexPath = IndexPath(row: Int((info?.getIValue("index"))!), section: 0)
            self.addItem(index: indexPath)
        }
        else if info?.getTaskId() == Int64(LPALapseEvent.projectsPublish.rawValue){
            self.presentpopupViewController(m_publish_view!, animationType: .bottomTop, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_project_setting_view = ProjectSettingView(nibName: "project_setting_view", bundle: nil)
        m_project_setting_view?.setPopbase(popbase: self)
        m_publish_view = PublishView(nibName: "PublishView", bundle: nil)
        m_publish_view?.setPopbase(popbase: self)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ProjectsViewController.longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
        GBTaskManagerGen.instance()?.addTaskExcuser(self)
        
        m_view_tittle.title = GBLanguageStoreGen.instance()?.getString("projects")
        m_btn_back.setTitle(GBLanguageStoreGen.instance()?.getString("back"), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        let cell = m_table_view.dequeueReusableCell(withIdentifier: "project_cell") as! PorjectCell

        // Somehow in Xcode 8 / Swift 3 the frame will initially be 1000x1000
        // TODO: check if this is solved in later releases...
        cell.m_video_review.frame.size = CGSize(width: 160, height: 90)
        
        LPAProjectListGen.instance()?.load(Int32(cell.m_video_review.frame.size.width)
            , reviewH: Int32(cell.m_video_review.frame.size.height))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        m_project_setting_view?.dissmissPopup(animationType: .leftRight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("table number:\((LPAProjectListGen.instance()?.getProjectAmount())!)")
        return Int((LPAProjectListGen.instance()?.getProjectAmount())!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.m_table_view.dequeueReusableCell(withIdentifier: "project_cell", for: indexPath) as! PorjectCell
        
        let cell_data:LPAProjectCellGen? = LPAProjectListGen.instance()?.getProjectData(Int32((indexPath as NSIndexPath).row));

        if nil == cell_data {
            GBLogGen.instance()?.logerrf("cell data nil \(indexPath)")
            return cell
        }
        //GBLogGen.instance()?.logerrf("cell index:\(indexPath) name:\(cell_data?.getName()) fps:\(cell_data?.getFps()) time:\(cell_data?.getCreateTime()) length:\(cell_data?.getLength()) path:\(cell_data?.getPath())")
        
        cell.m_video_name.text = cell_data?.getName()
        cell.m_fps.text = cell_data?.getFps()
        cell.m_video_create_time.text = cell_data?.getCreateTime()
        cell.m_video_length.text = cell_data?.getLength()
        cell.m_record_duration.text = cell_data?.getRecordDuration()
        cell.m_video_review.image = ObjcUtility.videoReview2UIImage((cell_data?.getPath())!)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LPAProjectListGen.instance()?.selectProject(Int32((indexPath as NSIndexPath).row))
        let cell = m_table_view.cellForRow(at: indexPath)
        let pos = cell?.convert(CGPoint(x:0,y:0), to: self.view)
        self.presentpopupViewController(m_project_setting_view!, pos: pos!, size: (cell?.contentView.frame.size)!,animationType: .rightLeft, completion: nil)
    }

    @IBAction func btnBackClick(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.ended {
            
        }
    }
    
    func deleteItem(index:IndexPath) {
        m_table_view.beginUpdates()
        if m_table_view.numberOfRows(inSection: 0) > index.row {
            m_table_view.deleteRows(at: [index], with: .right)
        }
        
        m_table_view.endUpdates()
    }
    
    func addItem(index:IndexPath) {
        m_table_view.beginUpdates()
        m_table_view.insertRows(at: [index], with: .right)
        m_table_view.endUpdates()
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
