//
//  CardsViewController.swift
//  Tindy
//
//  Created by Savannah McCoy on 4/5/17.
//  Copyright © 2017 Savannah McCoy. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var navBarImageView: UIImageView!
    @IBOutlet weak var actionButtonsImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    var userImageViewOriginalCenter: CGPoint!
    var viewCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.isUserInteractionEnabled = true
        userImageView.layer.cornerRadius = 5

        
        viewCenter = userImageView.center
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        
        print("tapped")
        
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        profileVC.profileImage = self.userImageView.image!
        present(profileVC, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: userImageView)
        let velocity = sender.velocity(in: userImageView)
        let translation = sender.translation(in: userImageView)
        
        
        if sender.state == .began {
            
            userImageViewOriginalCenter = userImageView.center
            
        }
        
        
        else if sender.state == .changed {
           
            var angle: CGFloat =  velocity.x/1000
            
            if (location.y > userImageView.center.y){                   //  if user pans bottom half of image, reverse rotation angle
                angle = angle * -1
            }
            
            userImageView.center = CGPoint(x: userImageViewOriginalCenter.x + translation.x, y: userImageViewOriginalCenter.y)
            
                    
            if ((self.userImageViewOriginalCenter.x + translation.x) > self.userImageViewOriginalCenter.x) {
                
                self.userImageView.transform = self.userImageView.transform.rotated(by: CGFloat(angle * CGFloat(Double.pi) / 180))
                
            }else{
                
                 self.userImageView.transform = self.userImageView.transform.rotated(by: CGFloat(angle * CGFloat(Double.pi) / 180))
                
            }
            
        }
        
        
        else if sender.state == .ended {
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] , animations: {
                () -> Void in
    
                if (translation.x > 90 ){                                           // animate off screen to right
                    print("😍😍😍😍")
                    UIView.animate(withDuration:0.5, animations: {
                        self.userImageView.center.x = 1000;
                    })
                    
                }else if (translation.x < -90 ){                                    // animate off screen to left
                    print("😴😴😴😴")
                    UIView.animate(withDuration:0.5, animations: {
                        self.userImageView.center.x = -1000;
                    })
                    
                } else {                                                            // Reset position & orientation
                    
                    self.userImageView.transform =  CGAffineTransform.identity      //restores orientation
                    self.userImageView.center = self.viewCenter                     //restores to location in view
                    
                }
                
            }, completion: { (Bool) -> Void in
            })
        }
        
    }// end of didPan
    

    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     
//    }
 

}
