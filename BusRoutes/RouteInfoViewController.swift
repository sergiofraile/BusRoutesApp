//
//  RouteInfoViewController.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation
import UIKit

// RouteInfoViewController will display the route information with all the bus stops.
// This controller also allows to swipe left or right to see the next or previous bus route.
// The view contains a table view with a header view on top.

class RouteInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: Outlets
  
  @IBOutlet weak var routeImageView: UIImageView!
  @IBOutlet weak var routeNameLabel: UILabel!
  @IBOutlet weak var routeDescriptionLabel: UILabel!
  @IBOutlet weak var accessibilityImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Private Vars
  
  fileprivate var _selectedIndex: Int = 0
  
  // MARK: Vars
  
  var route: Route?
  // The setter method for selectedIndex will automatically
  // update the selected route. This method is handy when increasing
  // the index value during the swipe events
  var selectedIndex: Int {
    get { return _selectedIndex }
    set {
      _selectedIndex = newValue
      route = DataManager.sharedInstance.busRoutes[selectedIndex]
    }
  }
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup table view
    tableView.delegate = self
    tableView.dataSource = self
    
    setupRouteHeader()
    setupSwipeGestures()
  }
  
  // MARK: Setup
  
  // Sets up the header view of the table. This is the route image, name, description, etc.
  func setupRouteHeader() {
    // Setup table header elements
    guard let route = route else { return }
    routeImageView.imageFromUrl(stringUrl: route.imageUrl, withPlaceholder: "filledBus")
    routeNameLabel.text = route.name
    routeDescriptionLabel.text = route.description
    accessibilityImageView.isHidden = !route.accessible
  }
  
  // Sets up the left and right swipe gestures and also disables the swipe back gesture
  // from the navigation controller.
  func setupSwipeGestures() {
    // First, we deactivate the navigation back swipe gesture
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    
    // Assign a handler to the left swipe gesture (next route in the list)
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
    swipeLeft.direction = .left
    view.addGestureRecognizer(swipeLeft)
    
    // Assign a handler to the right swipe gesture (previous route in the list)
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
    swipeRight.direction = .right
    view.addGestureRecognizer(swipeRight)
  }
  
  // Updates the UI compontents after the swip actions.
  func updateRouteChange() {
    // Because we may have scrolled down for seeing the routes, we scroll the table view all the
    // way up to the top before changing the content.
    
    self.tableView.setContentOffset(.zero, animated: false)
    // Small delay as scrolling up would intefer with the table reloading
    // and provoque the scroll to end up abrouptly in the middle of the page
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
      self.setupRouteHeader()
      self.tableView.reloadData()
    })
  }
  
  // MARK: Table View Delegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return RouteStopCell.height
  }
  
  // MARK: Table View Data Source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return route?.stops.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RouteStopCell.cellReuseIdentifier, for: indexPath) as! RouteStopCell
    guard let route = route, route.stops.count > 0 else { return cell }
    
    cell.label.text = route.stops[indexPath.row]
    
    if indexPath.row == 0 {
      // If it is the first item, the line won't show at the top.
      // For the line, a simple view has been used rather than an image.
      cell.lineTopConstraint.constant = RouteStopCell.height / 2
    }
    
    if indexPath.row == route.stops.count - 1 {
      // Same operation than before but for the last element of the table.
      cell.lineBottomConstraint.constant = RouteStopCell.height / 2
    }
    
    return cell
  }
  
  // MARK: Swipe gesture
  
  @objc func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
    if gestureRecognizer.state == .ended {
      if gestureRecognizer.direction == UISwipeGestureRecognizerDirection.right {
        // If it is not the first element on the list, we change index and
        // update the UI
        if selectedIndex > 0 {
          selectedIndex -= 1
          updateRouteChange()
        }
      }
      else if gestureRecognizer.direction == UISwipeGestureRecognizerDirection.left {
        // If it is not the last element on the list, we change index and
        // update the UI
        if selectedIndex < (DataManager.sharedInstance.busRoutes.count - 1) {
          selectedIndex += 1
          updateRouteChange()
        }
      }
    }
  }
}
