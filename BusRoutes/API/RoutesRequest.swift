//
//  RoutesRequest.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation

// RoutesRequests extends the protocol Request (find in at Protocols/Request.swift).
//
//
struct RoutesRequest: Request {
  // We declare that our response tipe, declared in the Request protocol,
  // will be for an element [Route]
  typealias Response = [Route]
  
  // Method defined in the Request protocol. We will perform the API fetch for
  // the routes information in here. This method is invoked in DataManager.swift
  func perform(then handler: @escaping Handler) {
    
    // We read the server configuration frm ServerConfig.plist
    let serverConfig = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "ServerConfig", ofType: "plist")!)!
    // The API endpoint is stored tehre
    let endPoint = serverConfig.object(forKey: "EndPoint") as! String
    
    // Guard to check the endpoint is a valid url
    guard let url = URL(string: endPoint) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: url) { (data, response, error) in
      // The response will be executed back in the main queue.
      DispatchQueue.main.async {
        if let error = error {
          // Handle failures based on the Request protocol
          handler(.failure(error))
        } else if let data = data {
          // Decoding the response
          let decoder = JSONDecoder()
          do {
            // The decoding information is in Route.swift
            let routes = try decoder.decode([Route].self, from: data)
            handler(.success(routes))
          } catch {
            handler(.failure(error))
          }
        } else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
          handler(.failure(error))
        }
      }
    }
    task.resume()
  }
}
