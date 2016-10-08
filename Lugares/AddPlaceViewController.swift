//
//  AddPlaceViewController.swift
//  Lugares
//
//  Created by Rafael Larrosa Espejo on 8/10/16.
//  Copyright © 2016 Rafael Larrosa Espejo. All rights reserved.
//

import UIKit
import CoreData

class AddPlaceViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textfieldName: UITextField!
    @IBOutlet var textfieldType: UITextField!
    @IBOutlet var textfieldDirection: UITextField!
    @IBOutlet var textfieldTelephone: UITextField!
    @IBOutlet var textfieldWebsite: UITextField!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    
    var rating: String?
    var place : Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero) // no muestra la barra superior
       self.textfieldName.delegate = self
        self.textfieldType.delegate = self
        self.textfieldDirection.delegate = self
        self.textfieldTelephone.delegate = self
    }

    @IBAction func savePressed(_ sender: AnyObject) {
        
        if let name = self.textfieldName.text, let type = self.textfieldType.text, let direction = self.textfieldDirection.text, let telephone = self.textfieldTelephone.text, let website = self.textfieldWebsite.text, let theImage = self.imageView.image, let rating = self.rating {
            
            
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                let context = container.viewContext
                self.place = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context) as? Place
                self.place?.name = name
                self.place?.type = type
                self.place?.location = direction
                self.place?.telephone = telephone
                self.place?.website = website
                self.place?.rating = rating
                self.place?.image = UIImagePNGRepresentation(theImage) as NSData?
                
                do{
                    try context.save()
                }catch{
                    print("Ha habido un error al guardar el lugar...")
                }
            }
            
            
            self.performSegue(withIdentifier: "unwindToMainViewController", sender: self)
            
        }else{
            let alertController = UIAlertController(title: "Falta algún dato", message: "Revisa que lo tengas todo configurado", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    let defaultColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    let selectedColor = UIColor.red
    
    @IBAction func ratingPressed(_ sender: AnyObject) {
        switch sender.tag {
        case 1:
            self.rating = "dislike"
            self.button1.backgroundColor = selectedColor
            self.button2.backgroundColor = defaultColor
            self.button3.backgroundColor = defaultColor
            
        case 2:
            self.rating = "good"
            self.button1.backgroundColor = defaultColor
            self.button2.backgroundColor = selectedColor
            self.button3.backgroundColor = defaultColor

        case 3:
            self.rating = "great"
            self.button1.backgroundColor = defaultColor
            self.button2.backgroundColor = defaultColor
            self.button3.backgroundColor = selectedColor

        default:
            break
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            //Hay que gestionar la seleccion de  la imagen del lugar
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        
        //restricciones de constrain por codigo
        let leadingConstrain = NSLayoutConstraint(item: self.imageView, attribute: .leading, relatedBy: .equal, toItem: self.imageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        leadingConstrain.isActive = true
        
        let trailingConstrain = NSLayoutConstraint(item: self.imageView, attribute: .trailing, relatedBy: .equal, toItem: self.imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        trailingConstrain.isActive = true
        
        let topConstrain = NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self.imageView.superview, attribute: .top, multiplier: 1, constant: 0)
        topConstrain.isActive = true
        
        let bottomConstrain = NSLayoutConstraint(item: self.imageView, attribute: .bottom, relatedBy: .equal, toItem: self.imageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstrain.isActive = true
        
        dismiss(animated: true, completion: nil)
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

    // MARK: - Table view data source

   

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
