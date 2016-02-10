//
//  SettingsViewController.swift
//  Tips
//
//  Created by Daniel Moreh on 2/9/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!

    let kDefaultTipKey = "default tip"
    let tipPercentages = [0.18, 0.2, 0.22]

    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultTip = defaults.doubleForKey(kDefaultTipKey)
        guard let defaultTipIndex = tipPercentages.indexOf(defaultTip) else {
            return
        }

        tipControl.selectedSegmentIndex = defaultTipIndex
    }

    
    @IBAction func tipControlValueChanged(sender: AnyObject) {
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(tipPercentage, forKey: kDefaultTipKey)
        defaults.synchronize()
    }
}
