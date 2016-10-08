//
//  DetailViewController.swift
//  MisRecetas
//
//  Created by Juan Gabriel Gomila Salas on 8/7/16.
//  Copyright © 2016 Juan Gabriel Gomila Salas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var ratingButton: UIButton!

    

    
    var place : Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = self.place.name
        self.placeImageView.image = UIImage(data:self.place.image as! Data)
    
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        self.title = place.name
        
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let image = UIImage(named: self.place.rating!)
        self.ratingButton.setImage(image, for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func close(segue: UIStoryboardSegue){
        if let reviewVC = segue.source as? ReviewViewController {
            if let rating = reviewVC.ratingSelected{
                self.place.rating = rating
                let image = UIImage(named: self.place.rating!)
                self.ratingButton.setImage(image, for: .normal)
            }
    
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap"{
            let destinationViewController = segue.destination as! MapViewController
            destinationViewController.place = self.place
        }
    }
    
    
}



extension DetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceDetailViewCell", for: indexPath) as! PlaceDetailViewCell
        
        cell.backgroundColor = UIColor.clear
        
       
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = "Nombre:"
                cell.valueLabel.text = self.place.name
            case 1:
                cell.keyLabel.text = "Tipo:"
                cell.valueLabel.text = "\(self.place.type)"
           case 2:
                 cell.keyLabel.text = "Localización: "
                 cell.valueLabel.text = "\(self.place.location)"
            case 3:
                cell.keyLabel.text = "Teléfono: "
                cell.valueLabel.text = "\(self.place.telephone)"
            case 4:
                cell.keyLabel.text = "Página web: "
                cell.valueLabel.text = "\(self.place.website)"
                
            default:
                break
            }
            // en la seccion segunda tenemos los ingredientes, si es la primera fila ponemos el titulo ingredientes y en las siguientes solo ponemos el ingrediente en si
        
        return cell
        
    }
    
    
    
    
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 0:
            title = "Información"
        case 1:
            title = "Ingredientes"
        case 2:
            title = "Pasos"
        default:
            break
        }
        
        return title

    }*/
    
}



extension DetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2: //celda 2 de geolocalización
            self.performSegue(withIdentifier: "showMap", sender: nil)
        default:
            break
        }
    }
    
}
