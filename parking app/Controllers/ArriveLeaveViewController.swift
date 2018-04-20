//
//  ArriveViewController.swift
//  parking app
//
//  Created by Farbod Rafezy on 11/18/17.
//  Copyright © 2017 Farbod Rafezy. All rights reserved.
//

import Foundation
import UIKit

class ArriveLeaveViewController: UIViewController {

    @IBOutlet weak var arriveDatePicker: UIDatePicker!
    @IBOutlet weak var leaveDatePicker: UIDatePicker!

    var arriveDate = Date()
    var leaveDate = Date()

    func initializeAppearanceSettings() {
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.insertSubview(blurEffectView, at: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAppearanceSettings()

        arriveDatePicker.setDate(arriveDate, animated: false)
        leaveDatePicker.setDate(leaveDate, animated: false)
    }
    
    @IBAction func cancelButtonClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonClick(_ sender: UIButton) {
        arriveDate = arriveDatePicker.date
        leaveDate = leaveDatePicker.date
        performSegue(withIdentifier: "unwindToSearchDrawer", sender: self)
    }
}
