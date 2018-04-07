//
//  RouteStopCell.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation
import UIKit

class RouteStopCell: UITableViewCell {
  
  // MARK: Statics
  
  static let height: CGFloat = 60
  static let cellReuseIdentifier = "RouteStopCellReuseIdentifier"
  
  // MARK: Outlets
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var lineTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var lineBottomConstraint: NSLayoutConstraint!
  
  // MARK: Life cycle
  
  override func prepareForReuse() {
    super.prepareForReuse()
    label.text = ""
    lineTopConstraint.constant = 0
    lineBottomConstraint.constant = 0
  }
}
