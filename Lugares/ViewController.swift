//
//  ViewController.swift
//  Lugares
//
//  Created by Rafael Larrosa Espejo on 13/9/16.
//  Copyright © 2016 es.elviejoroblesabadell.xCode. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UITableViewController {
    
    var places : [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // solo aparece el boton hacia atras sin texto
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       /* if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
            let context = container.viewContext
            
            let request : NSFetchRequest<Place> = NSFetchRequest(entityName: "Place")
            do{
                self.places = try context.fetch(request)
                self.tableView.reloadData()
            }catch{
                print("error: \(error)")
            }
        }*/
        
        // elimina las rows vacias de abajo cuando acaba la lista
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Do any additional setup after loading the view, typically from a nib.
      
       /* var place = Place(name: "AlexanderPlatz", type: "Plaza", location: "Alexanderstraße 4 10178 Berlin Deutschland", image: #imageLiteral(resourceName: "alexanderplatz"), telephone:"937462896", website: "http://www.disfrutaberlin.com/alexanderplatz")
        places.append(place)
        
        place = Place(name: "Atomium", type: "Museo", location: "Atomiumsquare 1 1020 Bruxelles België", image: #imageLiteral(resourceName: "atomium"), telephone:"937462896", website: "http://www.atomium.be")
        places.append(place)
        
        place = Place(name: "Big Ben", type: "Monumento", location: "London SW1A 0AA England", image: #imageLiteral(resourceName: "bigben"),telephone:"937462896", website: "http://www.parliament.uk/bigben")
        places.append(place)
        place = Place(name: "Cristo Redentor", type: "Monumento", location: "Cristo Redentor João Pessoa - PB Brasil", image: #imageLiteral(resourceName: "cristoredentor"), telephone:"937462896", website: "https://cristoredentoroficial.com.br")
        places.append(place)
        place = Place(name: "Torre Eiffel", type: "Monumento", location: "5 Avenue Anatole France 75007 Paris France", image: #imageLiteral(resourceName: "torreeiffel"), telephone:"937462896", website: "http://www.toureiffel.paris/es.html")
        places.append(place)
        place = Place(name: "Gran Muralla China", type: "Monumento", location: "慕田峪长城 中国北京市", image: #imageLiteral(resourceName: "murallachina"), telephone:"937462896", website: "http://www.nationalgeographic.com.es/historia/grandes-reportajes/la-gran-muralla-china_8272")
        places.append(place)
        place = Place(name: "Torre de Pisa", type: "Monumento", location: "Torre di Pisa 56126 Pisa Italia", image: #imageLiteral(resourceName: "torrepisa"), telephone:"937462896", website: "http://guias-viajar.com/italia/toscana/subir-torre-pisa-horarios-precios/")
        places.append(place)
        place = Place(name: "La Seu de Mallorca", type: "Catedral", location: "La Seu Plaza de la Seu 5 07001 Palma Baleares, España", image: #imageLiteral(resourceName: "mallorca"), telephone:"902022445", website: "http://www.catedraldemallorca.info/principal/en")
        places.append(place)*/
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //solo oculta la barra de navegacion on swipe
        navigationController?.hidesBarsOnSwipe = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    // tres metodos (funciones) para delegar
    // secciones si vamos a mostrar todas las recetas juntas pondremos solo 1 sección
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //numero de filas por sección, el numero de recetas es el tamaño del array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    
    // se llama para cada una y todas de las celdas que se muestran en pantalla, indexpath es el indicador de donde está la seccion y la fila
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let place = places[indexPath.row]
        let cellID = "PlaceCell"
        // la funcion dequeReusableCell solo muestra lo que cabe por pantalla y gesetiona mejor la memoria
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PlaceCell
        
        cell.thumbnailImageView.image = UIImage(data:place.image! as Data)
        cell.titleLabel.text = place.name
        cell.timeLabel.text = place.type
        cell.ingredientsLabel.text = place.location        //hacer el borde circular y cortar lo que sobresale
        //cell.thumbnailImageView.layer.cornerRadius = 40
        //cell.thumbnailImageView.clipsToBounds = true
        //la otra manera de hacer lo del ciruclo se hace desde el storyboard
        /* if(recipe.isFavorite){
         cell.accessoryType = .checkmark
         }else{
         cell.accessoryType = .none
         }*/
        
        return cell
    }
    //la vista dice al contrlador que borre el elemento y se ha borrado, pero falta implementar que se repinte la vista
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.places.remove(at: indexPath.row)
        }
        
        // self.tableView.reloadData() esto refrescaria la tabla entera y podria causar problemas si es muy larga
        //este hace el efecto de fade al borrar y no necesita refrescar la vista entera
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //accion de compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            let place = self.places[indexPath.row]
            
            let shareDefautText = "Estoy visitando \(place.name) en la app del Curso de iOS 10."
            let activityController = UIActivityViewController(activityItems: [shareDefautText,place.image!], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        shareAction.backgroundColor = UIColor(red: 30.00/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        // se debe añadir de nuevo la accion de eliminar porque esta la sobreescribe
        
        let deleteAction =  UITableViewRowAction(style: .default, title: "Eliminar") { (accion, indexPath) in
            
            self.places.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.backgroundColor = UIColor(red: 202/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha: 1.0)
        
        return [shareAction, deleteAction]
    }
    
    
    //MARK: UIVIEWTABLEDELEGATE, la comentamos porque al utilizar otra vista para ver detalles se mostaria el boton de favoritos
    
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // hemos pulsado en el cambio de viewcontroller de ver detalles
        if segue.identifier == "showDetail" {
            
            //primero detectar que elemento se ha seleccionado y luego sacar la receta y enviarla al viewcontroller nuevo
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let selectedPlace = self.places[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.place = selectedPlace
            }
        }
    }
    
    
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue){
        if segue.identifier == "unwindToMainViewController"  {
            //si es así, venimos de crear un nuevo lugar
            if let addplaceVC = segue.source as? AddPlaceViewController{
                if let newPlace = addplaceVC.place {
                self.places.append(newPlace)
                self.tableView.reloadData()
                
                }
            }
        }
    }
    
}



