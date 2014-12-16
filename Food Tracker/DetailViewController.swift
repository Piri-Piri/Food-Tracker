//
//  DetailViewController.swift
//  Food Tracker
//
//  Created by David Pirih on 14.12.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import UIKit
import HealthKit

class DetailViewController: UIViewController {

    var usdaItem: USDAItem?
    
    @IBOutlet weak var textView: UITextView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "usdaItemDidComplete:", name: kUSDAItemCompleted, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //requestAuthorizationForHealthStore()
        
        if usdaItem != nil {
            textView.attributedText = createAttributedString(usdaItem!)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eatItBarButtonItemPressed(sender: UIBarButtonItem) {
        //saveFoodItem(self.usdaItem!)
    }
    
    // MARK: - NSNotificationCenter
    
    func usdaItemDidComplete(notification: NSNotification) {
        //println("The function 'usdaItemDidComplete' in DetailViewConroller will be evaluting...")
        self.usdaItem = notification.object as? USDAItem
        
        if self.isViewLoaded() && self.view.window != nil {
            textView.attributedText = createAttributedString(usdaItem!)
        }
    }
    
    // MARK: - Helpers
    
    func createAttributedString(usdaItem: USDAItem!) -> NSAttributedString {
        var itemAttributedString = NSMutableAttributedString()
        
        var centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = NSTextAlignment.Center
        centeredParagraphStyle.lineSpacing = 10.0
        
        var titleAttributesDictionary = [
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName : UIFont.boldSystemFontOfSize(22.0),
            NSParagraphStyleAttributeName : centeredParagraphStyle]
        
        let titleString = NSAttributedString(string: "\(usdaItem.name)\n", attributes: titleAttributesDictionary)
        itemAttributedString.appendAttributedString(titleString)
        
        var leftAlignedParagraphStyle = NSMutableParagraphStyle()
        leftAlignedParagraphStyle.alignment = NSTextAlignment.Left
        leftAlignedParagraphStyle.lineSpacing = 20.0
        
        var sytleFirstWordAttributesDictionary = [
        NSForegroundColorAttributeName : UIColor.blackColor(),
        NSFontAttributeName : UIFont.boldSystemFontOfSize(18.0),
        NSParagraphStyleAttributeName : leftAlignedParagraphStyle]
        
        var sytle1AttributesDictionary = [
            NSForegroundColorAttributeName : UIColor.darkGrayColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(18.0),
            NSParagraphStyleAttributeName : leftAlignedParagraphStyle]
        
        var sytle2AttributesDictionary = [
            NSForegroundColorAttributeName : UIColor.lightGrayColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(18.0),
            NSParagraphStyleAttributeName : leftAlignedParagraphStyle]
        
        let calciumTitleString = NSAttributedString(string: "Calcium ", attributes: sytleFirstWordAttributesDictionary)
        let calciumBodyString = NSAttributedString(string: "\(usdaItem.calcium)% \n", attributes: sytle1AttributesDictionary)
        itemAttributedString.appendAttributedString(calciumTitleString)
        itemAttributedString.appendAttributedString(calciumBodyString)
        
        let carbohydrateTitleString = NSAttributedString(string: "Carbohydrate ", attributes: sytleFirstWordAttributesDictionary)
        let carbohydrateBodyString = NSAttributedString(string: "\(usdaItem.carbohydrate) \n", attributes: sytle2AttributesDictionary)
        itemAttributedString.appendAttributedString(carbohydrateTitleString)
        itemAttributedString.appendAttributedString(carbohydrateBodyString)
        
        let cholesterolTitleString = NSAttributedString(string: "Cholesterol ", attributes: sytleFirstWordAttributesDictionary)
        let cholesterolBodyString = NSAttributedString(string: "\(usdaItem.cholesterol)% \n", attributes: sytle1AttributesDictionary)
        itemAttributedString.appendAttributedString(cholesterolTitleString)
        itemAttributedString.appendAttributedString(cholesterolBodyString)
        
        let energyTitleString = NSAttributedString(string: "Energy ", attributes: sytleFirstWordAttributesDictionary)
        let energyBodyString = NSAttributedString(string: "\(usdaItem.energy) \n", attributes: sytle2AttributesDictionary)
        itemAttributedString.appendAttributedString(energyTitleString)
        itemAttributedString.appendAttributedString(energyBodyString)
        
        let fatTotalTitleString = NSAttributedString(string: "Fat Total ", attributes: sytleFirstWordAttributesDictionary)
        let fatTotalBodyString = NSAttributedString(string: "\(usdaItem.fatTotal) \n", attributes: sytle1AttributesDictionary)
        itemAttributedString.appendAttributedString(fatTotalTitleString)
        itemAttributedString.appendAttributedString(fatTotalBodyString)
        
        let proteinTitleString = NSAttributedString(string: "Protein ", attributes: sytleFirstWordAttributesDictionary)
        let proteinBodyString = NSAttributedString(string: "\(usdaItem.protein) \n", attributes: sytle2AttributesDictionary)
        itemAttributedString.appendAttributedString(proteinTitleString)
        itemAttributedString.appendAttributedString(proteinBodyString)
        
        let sugarTitleString = NSAttributedString(string: "Sugar ", attributes: sytleFirstWordAttributesDictionary)
        let sugarBodyString = NSAttributedString(string: "\(usdaItem.sugar) \n", attributes: sytle1AttributesDictionary)
        itemAttributedString.appendAttributedString(sugarTitleString)
        itemAttributedString.appendAttributedString(sugarBodyString)
        
        let vitaminCTitleString = NSAttributedString(string: "Vitamin C ", attributes: sytleFirstWordAttributesDictionary)
        let vitaminCBodyString = NSAttributedString(string: "\(usdaItem.vitaminC)% \n", attributes: sytle2AttributesDictionary)
        itemAttributedString.appendAttributedString(vitaminCTitleString)
        itemAttributedString.appendAttributedString(vitaminCBodyString)
        
        return itemAttributedString
    }
    
    func requestAuthorizationForHealthStore() {
        let dataTypesToWrite = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC)
        ]
        
        let dataTypesToRead = [
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar),
            HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC)
        ]
        
        var store: HealthStoreConstant = HealthStoreConstant()
        store.healthStore?.requestAuthorizationToShareTypes(NSSet(array: dataTypesToWrite), readTypes: NSSet(array: dataTypesToRead), completion: { (success, error) -> Void in
            if success {
                println("User completed authorization request.")
            }
            else {
                println("User REVOKE the authorization request! \(error)")
            }
        })
    }
    
    func saveFoodItem(foodItem: USDAItem) {
        if HKHealthStore.isHealthDataAvailable() {
            let timeFoodWasEntered = NSDate()
            
            let foodMetaData = [
                HKMetadataKeyFoodType : foodItem.name,
                "HKBrandName" : "USDAItem",
                "HKFoodTypeID" : foodItem.idValue,
            ]
            
            let energyUnit = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: (foodItem.energy as NSString).doubleValue)
            let calories = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed), quantity: energyUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let calciumUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.calcium as NSString).doubleValue)
            let calcium = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCalcium), quantity: calciumUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let carbohydratesUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.carbohydrate as NSString).doubleValue)
            let carbohydrates = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates), quantity: carbohydratesUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let fatTotalUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.fatTotal as NSString).doubleValue)
            let fatTotal = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal), quantity: fatTotalUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let proteinUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.protein as NSString).doubleValue)
            let protein = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein), quantity: proteinUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let sugarUnit = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: (foodItem.sugar as NSString).doubleValue)
            let sugar = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietarySugar), quantity: sugarUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let vitaminCUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.vitaminC as NSString).doubleValue)
            let vitaminC = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryVitaminC), quantity: vitaminCUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let cholesterolUnit = HKQuantity(unit: HKUnit.gramUnitWithMetricPrefix(HKMetricPrefix.Milli), doubleValue: (foodItem.cholesterol as NSString).doubleValue)
            let cholesterol = HKQuantitySample(type: HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCholesterol), quantity: cholesterolUnit, startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, metadata: foodMetaData)
            
            let foodDataSet = NSSet(array: [calories, calcium, carbohydrates, cholesterol, fatTotal, protein, sugar, vitaminC])
            let foodCoorelation = HKCorrelation(type: HKCorrelationType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierFood), startDate: timeFoodWasEntered, endDate: timeFoodWasEntered, objects: foodDataSet, metadata: foodMetaData)
            
            var store: HealthStoreConstant = HealthStoreConstant()
            store.healthStore?.saveObject(foodCoorelation, withCompletion: { (success, error) -> Void in
                if success {
                    println("Save to HealthKit successfully completed")
                }
                else {
                    println("Error occured while saving data to HealthKit: \(error)")
                }
            })
        }
        else {
            // Alert User to enabled HeathKit Authorization
        }
    }
    
}
