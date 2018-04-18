//
//  ParkingSpaceDrawerViewController.swift
//  parking app
//
//  Created by Farbod Rafezy on 4/13/18.
//  Copyright © 2018 Farbod Rafezy. All rights reserved.
//

import Foundation
import Pulley
import UIKit

class ParkingSpaceDrawerViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var maxVehicleSizeLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var featuresScrollView: UIScrollView!

    var parkingSpace: ParkingSpace?
    let partialRevealHeight: CGFloat = 100
    let collapsedHeight: CGFloat = 240
    let drawerPositions: [PulleyPosition] = [
        .open,
        .partiallyRevealed,
        .collapsed,
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        reserveButton.layer.cornerRadius = 10

        if let parkingSpace = parkingSpace {
            addressLabel.text = parkingSpace.address
            if let sizeDescription = ParkingSpace.vehicleSize[parkingSpace.size] {
                maxVehicleSizeLabel.text = "Max vehicle size: \(sizeDescription)"
            } else {
                maxVehicleSizeLabel.text = "Max vehicle size: unknown"
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if let pulleyViewController = parent as? PulleyViewController {
            pulleyViewController.setDrawerPosition(position: .collapsed)
        }
    }

    /**
     This function is called when the 'X' in the top right corner of the
     parking space detail view is called. It closes the parking space detail
     view and shows the search drawer view instead (with it's previous state
     restored)
    */
    @IBAction func dismissButton(_ sender: Any) {
        if let pulleyViewController = parent as? ParkingPulleyViewController {
            pulleyViewController.setDrawerContentViewController(
                controller: pulleyViewController.savedSearchDrawerViewController!,
                animated: false)
            if let mapViewController =
                pulleyViewController.childViewControllers[0] as? MapViewController {
                mapViewController.mapView.deselectAnnotation(
                    mapViewController.mapView.selectedAnnotations[0],
                    animated: true)
                mapViewController.redoSearchButton.isHidden = false
            }
        }
    }

}

extension ParkingSpaceDrawerViewController: PulleyDrawerViewControllerDelegate {

    func collapsedDrawerHeight() -> CGFloat {
        if iphoneX {
            return collapsedHeight + 26
        }
        return collapsedHeight
    }

    func partialRevealDrawerHeight() -> CGFloat {
        if iphoneX {
            return partialRevealHeight + 26
        }
        return partialRevealHeight
    }

    func drawerPositionDidChange(drawer: PulleyViewController) {
        if drawer.drawerPosition == .partiallyRevealed {
            featuresScrollView.isHidden = true
        } else if drawer.drawerPosition == .open {
            featuresScrollView.isHidden = false
        } else if drawer.drawerPosition == .collapsed {
            featuresScrollView.isHidden = false
        }
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return drawerPositions
    }
}