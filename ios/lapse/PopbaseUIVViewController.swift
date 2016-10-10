//
//  UIVViewController-SLpopup.swift
//  AnonyChat
//
//  Created by Nguyen Duc Hoang on 9/6/15.
//  Copyright © 2015 Home. All rights reserved.
//

import UIKit
import QuartzCore
import ObjectiveC

enum SLpopupViewAnimationType: Int {
    case none
    case bottomTop
    case topBottom
    case bottomBottom
    case topTop
    case leftLeft
    case leftRight
    case rightLeft
    case rightRight
    case fade
}

let kpopupAnimationDuration = 0.35
let kSLViewDismissKey = "kSLViewDismissKey"

class PopbaseUIViewController: UIViewController {

//    var dismissedCallback:UIViewController? {
//        get {
//            return objc_getAssociatedObject(self, kSLViewDismissKey) as? UIViewController
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, kSLViewDismissKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
    
    func presentpopupViewController(_ popup_ctl: PopupViewController, animationType:SLpopupViewAnimationType, completion: (() -> Void)?) {
        presentpopupViewController(popup_ctl, pos: CGPoint(x: -1, y: -1), size: CGSize(width: -1, height: -1), animationType: animationType, completion: completion)
    }
    
    func presentpopupViewController(_ popup_ctl: PopupViewController, pos: CGPoint, size: CGSize, animationType:SLpopupViewAnimationType, completion: (() -> Void)?) {
        let sourceView:UIView = self.getTopView()
        let popupView:UIView = popup_ctl.view
        
        if(sourceView.subviews.contains(popupView)) {
            return
        }
        
        if popup_ctl.m_overlay_view == nil {
            popupView.layer.shadowPath = UIBezierPath(rect: popupView.bounds).cgPath
            popupView.layer.shouldRasterize = true
            popupView.layer.rasterizationScale = UIScreen.main.scale
            popupView.autoresizingMask = [.flexibleTopMargin,.flexibleLeftMargin,.flexibleRightMargin,.flexibleBottomMargin]
            
            let overlayView:UIView = UIView(frame: sourceView.bounds)

            //overlayView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            //m_overlay_view_tag = GBPlatformUtilityImp.sharedInstance.getAddress(object: overlayView)
            //overlayView.tag = m_overlay_view_tag
            overlayView.backgroundColor = UIColor.clear
            popup_ctl.m_overlay_view = overlayView
            
            
            popup_ctl.m_background_view = UIView(frame: sourceView.bounds)
            popup_ctl.m_background_view!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            popup_ctl.m_background_view!.backgroundColor = UIColor.clear
            popup_ctl.m_background_view?.alpha = 0.0
            overlayView.addSubview(popup_ctl.m_background_view!)
            overlayView.addSubview(popupView)
        }
        popupView.alpha = 0.0
        sourceView.addSubview(popup_ctl.m_overlay_view!)
        
        
        //Background is button
        /*
        let dismissButton: UIButton = UIButton(type: .Custom)
        dismissButton.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        dismissButton.backgroundColor = UIColor.clearColor()
        dismissButton.frame = sourceView.bounds
        overlayView.addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(PopbaseUIViewController.btnDismissViewControllerWithAnimation(_:)), forControlEvents: .TouchUpInside)
        dismissButton.tag = animationType.rawValue
        */
        
        let final_rect = self.finalRect(popupView, sourceView: sourceView, pos: pos, size: size)
        switch animationType {
        case .bottomTop, .bottomBottom,.topTop,.topBottom, .leftLeft, .leftRight,.rightLeft, .rightRight:
            //dismissButton.tag = animationType.rawValue
            self.slideView(popupView, popup_ctl: popup_ctl, frame:final_rect, animationType: animationType)
            
        default:
            //dismissButton.tag = SLpopupViewAnimationType.Fade.rawValue
            self.fadeView(popupView, popup_ctl: popup_ctl, frame:final_rect)
        }
        
    }
    
    func finalRect(_ popupView: UIView, sourceView:UIView, pos:CGPoint, size:CGSize) -> CGRect {
        let sourceSize: CGSize = sourceView.bounds.size
        let popupSize: CGSize = popupView.bounds.size
        var frame:CGRect = CGRect(x: (sourceSize.width - popupSize.width)/2, y: (sourceSize.height - popupSize.height)/2, width: popupSize.width, height: popupSize.height)
        
        if pos.x >= 0 {
            frame.origin.x = pos.x
        }
        if pos.y >= 0 {
            frame.origin.y = pos.y
        }
        if size.width > 0 {
            frame.size.width = size.width
        }
        if size.height > 0 {
            frame.size.height = size.height
        }
        
        return frame
    }
    
    func slideView(_ popupView: UIView, popup_ctl:PopupViewController?, frame:CGRect, animationType: SLpopupViewAnimationType) {
        let sourceSize: CGSize = self.getTopView().bounds.size
        let popupSize: CGSize = popupView.bounds.size
        var popupStartRect:CGRect
        switch animationType {
        case .bottomTop, .bottomBottom:
            popupStartRect = CGRect(x: frame.origin.x, y: sourceSize.height, width: popupSize.width, height: popupSize.height)
        case .leftLeft, .leftRight:
            popupStartRect = CGRect(x: -sourceSize.width, y: frame.origin.y, width: popupSize.width, height: popupSize.height)
        case .topTop, .topBottom:
            popupStartRect = CGRect(x: frame.origin.x, y: -sourceSize.height, width: popupSize.width, height: popupSize.height)
        default:
            popupStartRect = CGRect(x: sourceSize.width, y: frame.origin.y, width: popupSize.width, height: popupSize.height)
        }

        popupView.frame = popupStartRect
        popupView.alpha = 1.0
        UIView.animate(withDuration: kpopupAnimationDuration, animations: { () -> Void in
            popup_ctl?.viewWillAppear(false)
            popup_ctl?.m_background_view?.alpha = 0.5
            popupView.frame = frame
            }, completion: { (finished) -> Void in
                popup_ctl?.viewDidAppear(false)
        }) 
        
    }
    func slideViewOut(_ popupView: UIView, popup_ctl:PopupViewController?, overlayView:UIView, animationType: SLpopupViewAnimationType) {
        let sourceSize: CGSize = getTopView().bounds.size
        var popupEndRect:CGRect = popupView.frame
        switch animationType {
        case .bottomTop, .topTop:
            popupEndRect.origin.y = -sourceSize.height
        case .bottomBottom, .topBottom:
            popupEndRect.origin.y = sourceSize.height
        case .leftRight, .rightRight:
            popupEndRect.origin.x = sourceSize.width
        default:
            popupEndRect.origin.x = -sourceSize.width
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                popup_ctl?.m_background_view?.backgroundColor = UIColor.clear
            }) { (finished) -> Void in
                UIView.animate(withDuration: kpopupAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                    popup_ctl?.viewWillDisappear(false)
                    popupView.frame = popupEndRect
                    }) { (finished) -> Void in
                        self.removePopups(popup_ctl:popup_ctl, popupView: popupView, overlayView: overlayView)
                }
        }
        
    }
    
    func fadeView(_ popupView: UIView, popup_ctl:PopupViewController?, frame:CGRect) {
        popupView.frame = frame
        popupView.alpha = 0.0
        
        UIView.animate(withDuration: kpopupAnimationDuration, animations: { () -> Void in
            popup_ctl?.viewWillAppear(false)
            popup_ctl?.m_background_view!.alpha = 0.5
            popupView.alpha = 1.0
        }, completion: { (finished) -> Void in
           popup_ctl?.viewDidAppear(false)
        }) 
        
    }
    
    func fadeViewOut(_ popupView: UIView, popup_ctl:PopupViewController?, overlayView:UIView) {
        UIView.animate(withDuration: kpopupAnimationDuration, animations: { () -> Void in
            popup_ctl?.viewDidDisappear(false)
            popup_ctl?.m_background_view?.alpha = 0.0
            popupView.alpha = 0.0
        }, completion: { (finished) -> Void in
            self.removePopups(popup_ctl:popup_ctl, popupView: popupView, overlayView: overlayView)
        }) 
        
    }

    func getTopView() -> UIView {
        var recentViewController:UIViewController = self
        if let _ = recentViewController.parent {
           recentViewController = recentViewController.parent!
        }
        return recentViewController.view
    }
    func dismissPopupViewController(popup_ctl:PopupViewController, animationType: SLpopupViewAnimationType) {
        let popupView:UIView = popup_ctl.view
        let overlayView:UIView? = popup_ctl.m_overlay_view
        if nil == overlayView {
            return
        }
        switch animationType {
        case .bottomTop, .bottomBottom, .topTop, .topBottom, .leftLeft, .leftRight, .rightLeft, .rightRight:
            self.slideViewOut(popupView, popup_ctl: popup_ctl, overlayView: overlayView!, animationType: animationType)
        case .fade:
            fadeViewOut(popupView, popup_ctl: popup_ctl, overlayView: overlayView!)
        default:
            self.removePopups(popup_ctl:popup_ctl, popupView: popupView, overlayView: overlayView!)
            
        }
    }
    
    func removePopups(popup_ctl: PopupViewController? ,popupView:UIView, overlayView:UIView) {
        //popupView.removeFromSuperview()
        overlayView.removeFromSuperview()
        popup_ctl?.viewDidDisappear(false)
    }
    
    /*
     func btnDismissViewControllerWithAnimation(_ btnDismiss : UIButton) {
     let animationType:SLpopupViewAnimationType = SLpopupViewAnimationType(rawValue: btnDismiss.tag)!
     switch animationType {
     case .bottomTop, .bottomBottom, .topTop, .topBottom, .leftLeft, .leftRight, .rightLeft, .rightRight:
     self.dismissPopupViewController(animationType)
     default:
     self.dismissPopupViewController(SLpopupViewAnimationType.fade)
     }
     }*/
}
