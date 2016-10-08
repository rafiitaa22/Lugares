//
//  ReviewViewController.swift
//  MisRecetas
//
//  Created by Rafael Larrosa Espejo on 25/9/16.
//  Copyright © 2016 es.elviejoroblesabadell.xCode. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    var ratingSelected: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let scale = CGAffineTransform.init(scaleX: 0.0, y: 0.0)
        let translation = CGAffineTransform.init(translationX: 0.0, y: 500.0)
        self.firstButton.transform = scale.concatenating(translation)
        self.secondButton.transform = scale.concatenating(translation)
        self.thirdButton.transform = scale.concatenating(translation)
        
        
        
       /* ratingStackView.transform = scale.concatenating(translation) */
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /* UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            }, completion: nil)
        */
        // concatenar alimaciones, el completion empieza cuando acaba la animacion
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.firstButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { (succcess) in
                UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                    self.secondButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }, completion: { (succcess) in
                        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
                            self.thirdButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            }, completion: nil)
                        
                        
                })
        
                
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ratingPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 1:
            ratingSelected = "dislike"
        case 2:
            ratingSelected = "good"
        case 3:
            ratingSelected = "great"
        default:
            break
        }
        
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }
    
}
