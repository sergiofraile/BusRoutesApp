//
//  ViewController.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import UIKit

class RoutesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: Outlets
  
  @IBOutlet weak var loadingContainer: UIView!
  @IBOutlet weak var informationLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Vars
  
  var selectedIndex: Int = 0
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    // The table view is initially hidden until
    // the routes are loaded
    tableView.isHidden = true
    
    // The data manager will fetch the routes from
    // the server and send an internal notification
    // for both success and failure outputs
    DataManager.sharedInstance.fetchRoutes()
    
    // Adding observer for data loaded
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.didDataLoad),
      name: NSNotification.Name(rawValue: Constants.Notifications.RoutesLoadSuccess),
      object: nil
    )
    
    // Adding observer for data loading failure
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(self.didFailLoadingData),
      name: NSNotification.Name(rawValue: Constants.Notifications.RoutesLoadFailure),
      object: nil
    )
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRouteInfo" {
      let vc = segue.destination as! RouteInfoViewController
      vc.route = DataManager.sharedInstance.busRoutes[selectedIndex]
    }
  }
  
  // MARK: Data observers
  
  @objc func didDataLoad() {
    tableView.reloadData()
    tableView.alpha = 0
    tableView.isHidden = false

    UIView.animate(withDuration: 0.3, animations: {
      self.tableView.alpha = 1
      self.loadingContainer.alpha = 0
    }) { (completed) in
      if completed {
        self.loadingContainer.isHidden = true
      }
    }
  }
  
  @objc func didFailLoadingData() {
    informationLabel.text = "Error loading the data. Trying again..."
    DataManager.sharedInstance.fetchRoutes()
  }
  
  // MARK: Table View Delegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return RouteCell.height
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedIndex = indexPath.row
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "showRouteInfo", sender: self)
  }
  
  // MARK: Table View Data Source
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataManager.sharedInstance.busRoutes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RouteCell.cellReuseIdentifier, for: indexPath) as! RouteCell
    let route = DataManager.sharedInstance.busRoutes[indexPath.row]
    
    cell.label.text = route.name
    cell.imageView?.imageFromUrl(stringUrl: route.imageUrl, withPlaceholder: "filledBus")
    
    return cell
  }
  
}
