//
//  CreditReportService.swift
//  ClearScore
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation
import UIKit

enum ServiceRequestError: Swift.Error {
    case invalidURL
    case unknown
}

protocol CreditReportServiceProtocol {
    func getCreditReport(completionHandler: @escaping (CreditReport?, ServiceRequestError?) -> Void)
}

struct CreditReportService: CreditReportServiceProtocol {
    static let shared = CreditReportService()
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getCreditReport(completionHandler: @escaping (CreditReport?, ServiceRequestError?) -> Void) {
        // Display the activity indicator when trying to fetch data.
        shouldShowActivityIndicator(true)
        
        // Check the URL
        guard let url = URL(string: API_URL) else {
            DispatchQueue.main.async {
                self.shouldShowActivityIndicator(false)
                Utils.displayAlert(title: ERROR_TITLE, message: ERROR_MSG_URL)
                return completionHandler(nil, ServiceRequestError.invalidURL)
            }
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            // Check if we get any data.
            guard let data = data else {
                DispatchQueue.main.async {
                    self.shouldShowActivityIndicator(false)
                    Utils.displayAlert(title: ERROR_TITLE, message: ERROR_MSG_UNKNOWN)
                    completionHandler(nil, ServiceRequestError.unknown)
                }
                return
            }
            
            let reportModel = try? JSONDecoder().decode(CreditReport.self, from: data)
            
            DispatchQueue.main.async {
                self.shouldShowActivityIndicator(false)
                completionHandler(reportModel, nil)
            }
        }
        task.resume()
    }
    
    private func shouldShowActivityIndicator(_ show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
}
