//
//  ReservationConfirmationViewController.swift
//  parking app
//
//  Created by Farbod Rafezy on 4/21/18.
//  Copyright © 2018 Farbod Rafezy. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class ReservationConfirmationViewController: UIViewController {

    @IBOutlet weak var arriveDateLabel: UILabel!
    @IBOutlet weak var leaveDateLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityStateLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    var parkingSpace: ParkingSpace?
    var arriveDate: Date?
    var leaveDate: Date?

    func initializeAppearanceSettings() {
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.insertSubview(blurEffectView, at: 0)

        mapView.layer.cornerRadius = 10
        confirmButton.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAppearanceSettings()

        arriveDateLabel.text = arriveDate?.toHumanReadable()
        leaveDateLabel.text = leaveDate?.toHumanReadable()
        streetAddressLabel.text = parkingSpace?.address
        cityStateLabel.text = "City, CA"
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }

    @IBAction func confirmReservationClick(_ sender: UIButton) {

        if  let parkingSpace = parkingSpace,
            let arriveDate = arriveDate,
            let leaveDate = leaveDate {

            Reservation.create(
                for: parkingSpace,
                from: arriveDate,
                to: leaveDate) { title, message in
                    self.presentSingleButtonAlert(
                        title: title,
                        message: message) { action in
                            self.performSegue(
                                withIdentifier: "unwindToMapViewControllerAfterReservationConfirmation",
                                sender: self)
                    }
            }

        }
    }

    @IBAction func cancelButtonClick(_ sender: UIButton) {
        dismiss(animated: true)
    }
}