//
//  ViewController.swift
//  App-e-tizer
//
//  Created by Daniel Condly on 11/12/22.
//

import UIKit

import GooglePlaces
import UIKit

class ViewController : UIViewController {

  // Add a pair of UILabels in Interface Builder, and connect the outlets to these variables.
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var addressLabel: UILabel!

  private var placesClient: GMSPlacesClient!

  override func viewDidLoad() {
    super.viewDidLoad()
    placesClient = GMSPlacesClient.shared()
  }

  // Add a UIButton in Interface Builder, and connect the action to this function.
  @IBAction func getCurrentPlace(_ sender: UIButton) {
    let placeFields: GMSPlaceField = [.name, .formattedAddress]
    placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
      guard let strongSelf = self else {
        return
      }

      guard error == nil else {
        print("Current place error: \(error?.localizedDescription ?? "")")
        return
      }

      guard let place = placeLikelihoods?.first?.place else {
        strongSelf.nameLabel.text = "No current place"
        strongSelf.addressLabel.text = ""
        return
      }

      strongSelf.nameLabel.text = place.name
      strongSelf.addressLabel.text = place.formattedAddress
    }
  }
}
