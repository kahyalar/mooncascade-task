//
//  NetworkManager.swift
//  Mooncascade
//
//  Created by Furkan Kahyalar on 14.08.2020.
//  Copyright © 2020 Furkan Kahyalar. All rights reserved.
//

import Foundation

class NetworkManager {
    private init (){}
    static let shared = NetworkManager()
    let cache = URLCache.shared
    
    func getEmployees(for endpoint: Endpoint, completed: @escaping(Result<[Employee], MCError>) -> Void) {
        guard let url = URL(string: endpoint.rawValue) else {
            completed(.failure(.urlNotReachable))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.fetchingFailed))
                return
            }

            guard let data = data else {
                completed(.failure(.systemError))
                return
            }
            
            guard let response = response else {
                completed(.failure(.systemError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let employeeList = try decoder.decode(EmployeeList.self, from: data)
                let cachedResponse = CachedURLResponse(response: response, data: data)
                self.cache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
                completed(.success(employeeList.employees))
            } catch {
                completed(.failure(.systemError))
            }
        }.resume()
    }
}
