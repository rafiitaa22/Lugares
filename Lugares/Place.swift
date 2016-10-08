//
//  Place.swift
//  Lugares
//
//  Created by Rafael Larrosa Espejo on 6/10/16.
//  Copyright © 2016 Rafael Larrosa Espejo. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class Place : NSManagedObject{
    @NSManaged var name : String
    @NSManaged var type : String
    @NSManaged var location : String
    @NSManaged var image : NSData?
    @NSManaged var rating : String?
    @NSManaged var telephone : String?
    @NSManaged var website : String?
    
    
}
