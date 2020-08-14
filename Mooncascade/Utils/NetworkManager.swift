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
    
    func getEmployees(for endpoint: Endpoint, completed: @escaping(Result<[Employee], NetworkError>) -> Void) {
        guard let url = URL(string: endpoint.rawValue) else {
            completed(.failure(.urlError))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.taskError))
                return
            }

            guard let data = data else {
                completed(.failure(.dataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let employeeList = try decoder.decode(EmployeeList.self, from: data)
                completed(.success(employeeList.employees))
            } catch {
                completed(.failure(.dataError))
            }
        }.resume()
    }
}
