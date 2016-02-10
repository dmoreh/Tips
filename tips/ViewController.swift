//
//  ViewController.swift
//  Tips
//
//  Created by Daniel Moreh on 2/9/16.
//  Copyright © 2016 Daniel Moreh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!

    @IBOutlet var viewsToAnimate: [UIView]!

    let kDefaultTipKey = "default tip"
    let tipPercentages = [0.18, 0.2, 0.22]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"

        for view in self.viewsToAnimate {
            view.alpha = 0
        }

        billField.becomeFirstResponder()
    }

    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultTip = defaults.doubleForKey(kDefaultTipKey)
        if let defaultTipIndex = tipPercentages.indexOf(defaultTip) {
            tipControl.selectedSegmentIndex = defaultTipIndex
            onEditingChanged(tipControl)
        } else {
            defaults.setDouble(tipPercentages[tipControl.selectedSegmentIndex], forKey: kDefaultTipKey)
        }
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip

        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

        UIView.animateWithDuration(0.3) { () -> Void in
            for view in self.viewsToAnimate {
                view.alpha = billAmount > 0 ? 1 : 0
            }
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
}

