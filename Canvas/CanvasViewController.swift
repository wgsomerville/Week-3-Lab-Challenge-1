//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Somerville, Walter on 2/11/16.
//  Copyright © 2016 Somerville, Walter. All rights reserved.
//

import UIKit

var trayOriginalCenter: CGPoint!
var newlyCreatedFaceOriginalCenter: CGPoint!

class CanvasViewController: UIViewController {

    
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var trayArrow: UIImageView!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        trayDownOffset = 182.0
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didPanTray(sender: AnyObject) {
        // Code that runs when the tray is panned
        
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)

        
        if sender.state == UIGestureRecognizerState.Began {
            
            trayOriginalCenter = trayView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if velocity.y > 0 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                    self.trayView.center = self.trayDown

                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                            self.trayArrow.transform = CGAffineTransformMakeRotation(CGFloat(180 * M_PI / 180))
                        })
                })
                

                
            } else {
                UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                        self.trayView.center = self.trayUp
                    

                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                            self.trayArrow.transform = CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180))
                        })
                })
            }
            
        }
        
    }
    
    @IBAction func didPanFace(sender: AnyObject) {
        
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center

            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(2, 2)
                }, completion: { (Bool) -> Void in
            })

            
        } else if sender.state == UIGestureRecognizerState.Changed {

            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

            
        } else if sender.state == UIGestureRecognizerState.Ended {

            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (Bool) -> Void in
            })
            
            let newFacePanGestureRecognizer = UITapGestureRecognizer(target: newlyCreatedFace, action: "didPanNewlyCreatedFace")
            newlyCreatedFace.userInteractionEnabled = true
            
        }
    }
    
    @IBAction func didPanNewlyCreatedFace(sender: AnyObject) {
        
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
        }
    }

}
