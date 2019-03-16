//
//  CreditReportServiceTests.swift
//  ClearScoreTests
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import XCTest
@testable import ClearScore

class CreditReportServiceTests: XCTestCase {

    var session: URLSessionMock!
    var creditReport: CreditReport!
    var creditReportService: CreditReportService!
    var parsingError: ServiceRequestError?
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        creditReportService = CreditReportService(session: session)
    }

    override func tearDown() {
        session = nil
        creditReport = nil
        creditReportService = nil
        parsingError = nil
        super.tearDown()
    }

    func test_Request_Credit_Report_Returns_Credit_Report() {
        let signalExpectation = expectation(description: "The URL was downloaded")
        let jsonString = Fixture.getJSON(jsonPath: "CreditReport")
        let data = jsonString?.data(using: String.Encoding.utf8)
        
        session.data = data
        
        creditReportService.getCreditReport(completionHandler: { creditReport, error in
            self.creditReport = creditReport
            self.parsingError = error
            signalExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { _ in
            XCTAssertNil(self.parsingError, "Error is nil for credit report data")
            XCTAssertNotNil(self.creditReport, "Credit report should not be nil")
        }
    }
    
    func test_When_Response_Data_Is_Nil_Returns_Error() {
        let signalExpectation = expectation(description: "The URL was downloaded")
        
        creditReportService.getCreditReport(completionHandler: { creditReport, error in
            self.creditReport = creditReport
            self.parsingError = error
            signalExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { _ in
            XCTAssertEqual(self.parsingError, ServiceRequestError.unknown, "Error is not nil when data is invalid")
            XCTAssertNil(self.creditReport, "Credit report should be nil")
        }
    }
    
    func test_When_URL_Is_Invalid_Returns_Error() {
        let signalExpectation = expectation(description: "The URL now not downloaded")
        
        API_URL = "Invalid URL"
        creditReportService.getCreditReport(completionHandler: { creditReport, error in
            self.creditReport = creditReport
            self.parsingError = error
            signalExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { _ in
            XCTAssertEqual(self.parsingError, ServiceRequestError.invalidURL, "Error is not nil when url is invalid")
            XCTAssertNil(self.creditReport, "Credit report should be nil")
        }
    }
}
