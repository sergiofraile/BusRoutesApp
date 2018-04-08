//
//  RouteCell.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation
import UIKit

class RouteCell: UITableViewCell {
  
  // MARK: Statics
  
  static let height: CGFloat = 60
  static let cellReuseIdentifier = "RouteCellReuseIdentifier"
 
  // MARK: Outlets
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var routeImageView: UIImageView!
  
  // MARK: Life cycle
  
//  override func prepareForReuse() {
//    super.prepareForReuse()
//    label.text = ""
//    routeImageView.image = nil
//  }
}
