//
//  RouteInfoViewController.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation
import UIKit

class RouteInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: Outlets
  
  @IBOutlet weak var routeImageView: UIImageView!
  @IBOutlet weak var routeNameLabel: UILabel!
  @IBOutlet weak var routeDescriptionLabel: UILabel!
  @IBOutlet weak var accessibilityImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Vars
  
  var route: Route?
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup table view
    tableView.delegate = self
    tableView.dataSource = self
    
    setupRouteHeader()
  }
  
  
  
  // MARK: Setup
  
  func setupRouteHeader() {
    // Setup table header elements
    guard let route = route else { return }
    routeImageView.imageFromUrl(stringUrl: route.imageUrl, withPlaceholder: "filledBus")
    routeNameLabel.text = route.name
    routeDescriptionLabel.text = route.description
    accessibilityImageView.isHidden = !route.accessible
  }
  
  // MARK: Table View Delegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return RouteStopCell.height
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "showRouteInfo", sender: self)
  }
  
  // MARK: Table View Data Source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return route?.stops.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RouteStopCell.cellReuseIdentifier, for: indexPath) as! RouteStopCell
    cell.label.text = "This is a stop"
    return cell
  }
}
