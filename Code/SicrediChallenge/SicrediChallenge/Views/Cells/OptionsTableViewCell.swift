//
//  OptionsTableViewCell.swift
//  fourAllChallenge
//
//  Created by Bruno Dorneles on 20/11/18.
//  Copyright © 2018 Bruno. All rights reserved.
//

import UIKit
import MapKit


class OptionsTableViewCell: UITableViewCell {
    static let xibName = "OptionsViewCell"
        @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var servicesButton: UIButton!
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentButton.alignImageAndTitleVertically()
        addressButton.alignImageAndTitleVertically()
        servicesButton.alignImageAndTitleVertically()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setup(event : Event){
        
        let initialLocation = CLLocation(latitude: Double(event.latitude) ?? 0.0, longitude:Double(event.longitude) ?? 0.0)
        let annotation = MKPointAnnotation()
        
        let region = MKCoordinateRegion(center: initialLocation.coordinate,
                                        latitudinalMeters: 300, longitudinalMeters: 300)
        mapView.setRegion(region, animated: true)
        annotation.coordinate = initialLocation.coordinate
        mapView.addAnnotation(annotation)
        
        mainTextView.text = event.description
    }
    
}
