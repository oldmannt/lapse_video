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
    case None
    case BottomTop
    case TopBottom
    case BottomBottom
    case TopTop
    case LeftLeft
    case LeftRight
    case RightLeft
    case RightRight
    case Fade
}
let kSourceViewTag = 11111
let kpopupViewTag = 22222
let kOverlayViewTag = 22222

var kpopupViewController:UInt8 = 0
var kpopupBackgroundView:UInt8 = 1

let kpopupAnimationDuration = 0.35
let kSLViewDismissKey = "kSLViewDismissKey"

class PopbaseUIViewController: UIViewController {
    var popupBackgroundView:UIView? {
        get {
            return objc_getAssociatedObject(self, &kpopupBackgroundView) as? UIView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kpopupBackgroundView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var popupViewController:UIViewController? {
        get {
            return objc_getAssociatedObject(self, &kpopupViewController) as? UIViewController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kpopupViewController, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
//    var dismissedCallback:UIViewController? {
//        get {
//            return objc_getAssociatedObject(self, kSLViewDismissKey) as? UIViewController
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, kSLViewDismissKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
    func presentpopupViewController(popupViewController: UIViewController, animationType:SLpopupViewAnimationType, completion: (() -> Void)?) {
        presentpopupViewController(popupViewController, pos: CGPoint(x: -1, y: -1), size: CGSize(width: -1, height: -1), animationType: animationType, completion: completion)
    }
    
    func presentpopupViewController(popupViewController: UIViewController, pos: CGPoint, size: CGSize, animationType:SLpopupViewAnimationType, completion: (() -> Void)?) {
        let sourceView:UIView = self.getTopView()
        self.popupViewController = popupViewController
        let popupView:UIView = popupViewController.view
        sourceView.tag = kSourceViewTag
        
        
        popupView.tag = kpopupViewTag
        if(sourceView.subviews.contains(popupView)) {
            return
        }
        popupView.layer.shadowPath = UIBezierPath(rect: popupView.bounds).CGPath
//        popupView.layer.masksToBounds = false
//        popupView.layer.shadowOffset = CGSizeMake(5, 5)
//        popupView.layer.shadowRadius = 5
//        popupView.layer.shadowOpacity = 0.5
        popupView.layer.shouldRasterize = true
        popupView.layer.rasterizationScale = UIScreen.mainScreen().scale
        popupView.autoresizingMask = [.FlexibleTopMargin,.FlexibleLeftMargin,.FlexibleRightMargin,.FlexibleBottomMargin]

        let overlayView:UIView = UIView(frame: sourceView.bounds)
        //overlayView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        overlayView.tag = kOverlayViewTag
        overlayView.backgroundColor = UIColor.clearColor()
        
        self.popupBackgroundView = UIView(frame: sourceView.bounds)
        self.popupBackgroundView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.popupBackgroundView!.backgroundColor = UIColor.clearColor()
        self.popupBackgroundView?.alpha = 0.0
        if let _ = self.popupBackgroundView {
            overlayView.addSubview(self.popupBackgroundView!)
        }
        
        popupView.alpha = 0.0
        overlayView.addSubview(popupView)
        sourceView.addSubview(overlayView)
        
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
        case .BottomTop, .BottomBottom,.TopTop,.TopBottom, .LeftLeft, .LeftRight,.RightLeft, .RightRight:
            //dismissButton.tag = animationType.rawValue
            self.slideView(popupView, sourceView: sourceView, frame:final_rect, animationType: animationType)
            
        default:
            //dismissButton.tag = SLpopupViewAnimationType.Fade.rawValue
            self.fadeView(popupView, sourceView: sourceView, frame:final_rect)
        }
        
    }
    
    func finalRect(popupView: UIView, sourceView:UIView, pos:CGPoint, size:CGSize) -> CGRect {
        let sourceSize: CGSize = sourceView.bounds.size
        let popupSize: CGSize = popupView.bounds.size
        var frame:CGRect = CGRectMake((sourceSize.width - popupSize.width)/2, (sourceSize.height - popupSize.height)/2, popupSize.width, popupSize.height)
        
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
    
    func slideView(popupView: UIView, sourceView:UIView, frame:CGRect, animationType: SLpopupViewAnimationType) {
        let sourceSize: CGSize = sourceView.bounds.size
        let popupSize: CGSize = popupView.bounds.size
        var popupStartRect:CGRect
        switch animationType {
        case .BottomTop, .BottomBottom:
            popupStartRect = CGRectMake(frame.origin.x, sourceSize.height, popupSize.width, popupSize.height)
        case .LeftLeft, .LeftRight:
            popupStartRect = CGRectMake(-sourceSize.width, frame.origin.y, popupSize.width, popupSize.height)
        case .TopTop, .TopBottom:
            popupStartRect = CGRectMake(frame.origin.x, -sourceSize.height, popupSize.width, popupSize.height)
        default:
            popupStartRect = CGRectMake(sourceSize.width, frame.origin.y, popupSize.width, popupSize.height)
        }

        popupView.frame = popupStartRect
        popupView.alpha = 1.0
        UIView.animateWithDuration(kpopupAnimationDuration, animations: { () -> Void in
            self.popupViewController?.viewWillAppear(false)
            self.popupBackgroundView?.alpha = 0.5
            popupView.frame = frame
            }) { (finished) -> Void in
                self.popupViewController?.viewDidAppear(false)
        }
        
    }
    func slideViewOut(popupView: UIView, sourceView:UIView, overlayView:UIView, animationType: SLpopupViewAnimationType) {
        let sourceSize: CGSize = sourceView.bounds.size
        let popupSize: CGSize = popupView.bounds.size
        var popupEndRect:CGRect = popupView.frame
        switch animationType {
        case .BottomTop, .TopTop:
            popupEndRect.origin.y = -popupSize.height
        case .BottomBottom, .TopBottom:
            popupEndRect.origin.y = popupSize.height
        case .LeftRight, .RightRight:
            popupEndRect.origin.x = sourceSize.width
        default:
            popupEndRect.origin.x = -popupSize.width
        }
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.popupBackgroundView?.backgroundColor = UIColor.clearColor()
            }) { (finished) -> Void in
                UIView.animateWithDuration(kpopupAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.popupViewController?.viewWillDisappear(false)
                    popupView.frame = popupEndRect
                    }) { (finished) -> Void in
                        popupView.removeFromSuperview()
                        overlayView.removeFromSuperview()
                        self.popupViewController?.viewDidDisappear(false)
                        self.popupViewController = nil
                }
        }
        
    }
    
    func fadeView(popupView: UIView, sourceView:UIView, frame:CGRect) {
        popupView.frame = frame
        popupView.alpha = 0.0
        
        UIView.animateWithDuration(kpopupAnimationDuration, animations: { () -> Void in
            self.popupViewController!.viewWillAppear(false)
            self.popupBackgroundView!.alpha = 0.5
            popupView.alpha = 1.0
        }) { (finished) -> Void in
           self.popupViewController?.viewDidAppear(false)
        }
        
    }
    
    func fadeViewOut(popupView: UIView, sourceView:UIView, overlayView:UIView) {
        UIView.animateWithDuration(kpopupAnimationDuration, animations: { () -> Void in
            self.popupViewController?.viewDidDisappear(false)
            self.popupBackgroundView?.alpha = 0.0
            popupView.alpha = 0.0
        }) { (finished) -> Void in
            popupView.removeFromSuperview()
            overlayView.removeFromSuperview()
            self.popupViewController?.viewDidDisappear(false)
            self.popupViewController = nil
        }
        
    }
    func btnDismissViewControllerWithAnimation(btnDismiss : UIButton) {
        let animationType:SLpopupViewAnimationType = SLpopupViewAnimationType(rawValue: btnDismiss.tag)!
        switch animationType {
        case .BottomTop, .BottomBottom, .TopTop, .TopBottom, .LeftLeft, .LeftRight, .RightLeft, .RightRight:
            self.dismissPopupViewController(animationType)
        default:
            self.dismissPopupViewController(SLpopupViewAnimationType.Fade)
        }
    }
    func getTopView() -> UIView {
        var recentViewController:UIViewController = self
        if let _ = recentViewController.parentViewController {
           recentViewController = recentViewController.parentViewController!
        }
        return recentViewController.view
    }
    func dismissPopupViewController(animationType: SLpopupViewAnimationType) {
        let sourceView:UIView = self.getTopView()
        let popupView:UIView = sourceView.viewWithTag(kpopupViewTag)!
        let overlayView:UIView = sourceView.viewWithTag(kOverlayViewTag)!
        switch animationType {
        case .BottomTop, .BottomBottom, .TopTop, .TopBottom, .LeftLeft, .LeftRight, .RightLeft, .RightRight:
            self.slideViewOut(popupView, sourceView: sourceView, overlayView: overlayView, animationType: animationType)
        case .Fade:
            fadeViewOut(popupView, sourceView: sourceView, overlayView: overlayView)
        default:
            popupView.removeFromSuperview()
            overlayView.removeFromSuperview()
            self.popupViewController?.viewDidDisappear(false)
            self.popupViewController = nil
            
        }
    }
}