//
//  RateViewController.swift
//  Eateries
//
//  Created by Konstantin on 23.06.2018.
//  Copyright © 2018 Konstantin Meleshko. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    @IBOutlet weak var stackButtons: UIStackView!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var goodBotton: UIButton!
    @IBOutlet weak var brilliantButton: UIButton!
    
    var restRaiting: String?
    
    @IBAction func rateResorant(sender: UIButton){
        switch sender.tag {
        case 0: restRaiting = "bad"
        case 1: restRaiting = "good"
        case 2: restRaiting = "brilliant"
        default:
            break
        }
    
        performSegue(withIdentifier: "undwindSegueForDVC", sender: sender)
    }
        

    
   
    
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.4) {
//            self.stackButtons.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
       
        
        // animated for our rate in therd screen
       let buttomArray = [badButton, goodBotton, brilliantButton]
        for (index, button) in buttomArray.enumerated(){
            let delay = Double(index) * 0.2
            UIView.animate(withDuration: 0.6, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                button?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // write before in animated in WiewDidApear
        badButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        goodBotton.transform = CGAffineTransform(scaleX: 0, y: 0)
        brilliantButton.transform = CGAffineTransform(scaleX: 0, y: 0)

        // property blure therd screen (background rate) 
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.view.insertSubview(blurEffectView, at: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
