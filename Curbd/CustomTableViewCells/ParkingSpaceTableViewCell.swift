//
//  ParkingSpaceTableViewCell.swift
//  Curbd
//
//  Created by Farbod Rafezy on 6/30/18.
//  Copyright © 2018 Farbod Rafezy. All rights reserved.
//

import UIKit
import MapKit

class ParkingSpaceTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var parkingSpaceNameLabel: UILabel!
    @IBOutlet weak var parkingSpaceCityAndStateLabel: UILabel!
    @IBOutlet weak var parkingSpaceIsActiveLabel: UILabel!
}