//
//  DetailViewController.swift
//  Food Tracker
//
//  Created by David Pirih on 14.12.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import UIKit

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
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eatItBarButtonItemPressed(sender: UIBarButtonItem) {
    }
    
    // MARK: - NSNotificationCenter
    
    func usdaItemDidComplete(notification: NSNotification) {
        println("The function 'usdaItemDidComplete' in DetailViewConroller will be evaluting...")
        self.usdaItem = notification.object as? USDAItem
    }
}
