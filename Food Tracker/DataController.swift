//
//  DataController.swift
//  Food Tracker
//
//  Created by David Pirih on 14.12.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataController {

    class func jsonAsUSDAIDAndNameSearchResults(json: NSDictionary) -> [(name: String, idValue: String)] {
        var usdaItemsSearchResults: [(name: String, idValue: String)] = []
        var searchResult: (name: String, idValue: String)
        
        if json["hits"] != nil {
            let results: [AnyObject] = json["hits"]! as [AnyObject]
            
            for itemDictionary in results {
                if itemDictionary["_id"] != nil {
                    if itemDictionary["fields"] != nil {
                        let fieldDictionary = itemDictionary["fields"] as NSDictionary
                        if fieldDictionary["item_name"] != nil {
                            let idValue: String = itemDictionary["_id"]! as String
                            let name: String = fieldDictionary["item_name"]! as String
                            
                            searchResult = (name: name, idValue: idValue)
                            usdaItemsSearchResults += [searchResult]
                        }
                    }
                }
            }
        }
        return usdaItemsSearchResults
    }
    
    func saveUSDAItemForId(idValue: String, json: NSDictionary) {
        if json["hits"] != nil {
            let results: [AnyObject] = json["hits"]! as [AnyObject]
            
            for itemDictionary in results {
                if itemDictionary["_id"] != nil && itemDictionary["_id"] as String == idValue {
                    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
                    
                    var requestForUSDAItem = NSFetchRequest(entityName: "USDAItem")
                    
                    let itemDictionaryId = itemDictionary["_id"]! as String
                    let predicate = NSPredicate(format: "idValue == %@", itemDictionaryId)
                    requestForUSDAItem.predicate = predicate
                    
                    var error: NSError?
                    
                    var items = managedObjectContext?.executeFetchRequest(requestForUSDAItem, error: &error)
                    
                    if items?.count != 0 {
                        // The item is already saved
                        println("USDA Item is already saved!")
                        return
                    }
                    else {
                        println("USDA Item will be saved to CoreData!")
                        
                        let entityDescription = NSEntityDescription.entityForName("USDAItem", inManagedObjectContext: managedObjectContext!)
                        let usdaItem = USDAItem(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
                        usdaItem.idValue = itemDictionaryId
                        usdaItem.dateAdded = NSDate()
                        
                        if itemDictionary["fields"] != nil {
                            let fieldDictionary = itemDictionary["fields"] as NSDictionary
                            if fieldDictionary["item_name"] != nil {
                                usdaItem.name = fieldDictionary["item_name"]! as String
                            }
                            if fieldDictionary["usda_fields"] != nil {
                                let usdaFieldDictionary = fieldDictionary["usda_fields"]! as NSDictionary
                                
                                if usdaFieldDictionary["CA"] != nil {
                                    let calciumDictionary = usdaFieldDictionary["CA"]! as NSDictionary
                                    if calciumDictionary["value"] != nil {
                                        let calciumValue: AnyObject = calciumDictionary["value"]!
                                        usdaItem.calcium = "\(calciumValue)"
                                    }
                                }
                                else {
                                    usdaItem.calcium = "0"
                                }
                                
                                if usdaFieldDictionary["CHOLE"] != nil {
                                    let cholesterolDictionary = usdaFieldDictionary["CHOLE"]! as NSDictionary
                                    if cholesterolDictionary["value"] != nil {
                                        let cholesterolValue: AnyObject = cholesterolDictionary["value"]!
                                        usdaItem.cholesterol = "\(cholesterolValue)"
                                    }
                                }
                                else {
                                    usdaItem.cholesterol = "0"
                                }
                                
                                if usdaFieldDictionary["PROCNT"] != nil {
                                    let proteinDictionary = usdaFieldDictionary["PROCNT"]! as NSDictionary
                                    if proteinDictionary["value"] != nil {
                                        let proteinValue: AnyObject = proteinDictionary["value"]!
                                        usdaItem.protein = "\(proteinValue)"
                                    }
                                }
                                else {
                                    usdaItem.protein = "0"
                                }
                                
                                if usdaFieldDictionary["CHOCDF"] != nil {
                                    let carbohydrateDictionary = usdaFieldDictionary["CHOCDF"]! as NSDictionary
                                    if carbohydrateDictionary["value"] != nil {
                                        let carbohydrateValue: AnyObject = carbohydrateDictionary["value"]!
                                        usdaItem.carbohydrate = "\(carbohydrateValue)"
                                    }
                                }
                                else {
                                    usdaItem.carbohydrate = "0"
                                }
                                
                                if usdaFieldDictionary["FAT"] != nil {
                                    let fatTotalDictionary = usdaFieldDictionary["FAT"]! as NSDictionary
                                    if fatTotalDictionary["value"] != nil {
                                        let fatTotalValue: AnyObject = fatTotalDictionary["value"]!
                                        usdaItem.fatTotal = "\(fatTotalValue)"
                                    }
                                }
                                else {
                                    usdaItem.fatTotal = "0"
                                }
                                
                                
                                if usdaFieldDictionary["SUGAR"] != nil {
                                    let sugarDictionary = usdaFieldDictionary["SUGAR"]! as NSDictionary
                                    if sugarDictionary["value"] != nil {
                                        let sugarValue: AnyObject = sugarDictionary["value"]!
                                        usdaItem.sugar = "\(sugarValue)"
                                    }
                                }
                                else {
                                    usdaItem.sugar = "0"
                                }
                                
                                if usdaFieldDictionary["VITC"] != nil {
                                    let vitaminCDictionary = usdaFieldDictionary["VITC"]! as NSDictionary
                                    if vitaminCDictionary["value"] != nil {
                                        let vitaminCValue: AnyObject = vitaminCDictionary["value"]!
                                        usdaItem.vitaminC = "\(vitaminCValue)"
                                    }
                                }
                                else {
                                    usdaItem.vitaminC = "0"
                                }
                                
                                if usdaFieldDictionary["ENERC_KCAL"] != nil {
                                    let energyDictionary = usdaFieldDictionary["ENERC_KCAL"]! as NSDictionary
                                    if energyDictionary["value"] != nil {
                                        let energyValue: AnyObject = energyDictionary["value"]!
                                        usdaItem.energy = "\(energyValue)"
                                    }
                                }
                                else {
                                    usdaItem.energy = "0"
                                }
                                
                                // Finaly save USDAItem
                                (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
}
