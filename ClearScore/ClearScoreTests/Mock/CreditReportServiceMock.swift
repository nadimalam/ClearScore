//
//  CreditReportServiceMock.swift
//  ClearScoreTests
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation
import UIKit

@testable import ClearScore

class CreditReportServiceMock: CreditReportServiceProtocol {
    
    var errorMock: ServiceRequestError? = nil
    var getCreditReportMock: CreditReport? = nil
    
    func getCreditReport(completionHandler: @escaping (CreditReport?, ServiceRequestError?) -> Void) {
        completionHandler(getCreditReportMock, errorMock)
    }
}
