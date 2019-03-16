//
//  CreditReportViewModelTests.swift
//  ClearScoreTests
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import XCTest
@testable import ClearScore

class CreditReportViewModelTests: XCTestCase {
    
    var creditReportService: CreditReportServiceMock!

    override func setUp() {
        super.setUp()
        creditReportService = CreditReportServiceMock()
    }

    override func tearDown() {
        creditReportService = nil
        super.tearDown()
    }

    func test_Get_Credit_Report_Returns_Credit_Report() {
        creditReportService.getCreditReportMock = CreditReport.initCreditReport()
        
        let viewModel = CreditReportViewModel(service: creditReportService)
        viewModel.getCreditReport()
        
        creditReportService.getCreditReport { creditReport, serviceRequestError in
            XCTAssertNotNil(creditReport, "Credit report should not be nil")
            XCTAssertNil(serviceRequestError, "Error is nil")
            XCTAssertEqual(viewModel.score, creditReport?.creditReportInfo.score, "Scores should be the same")
            XCTAssertEqual(viewModel.maxScore, creditReport?.creditReportInfo.maxScoreValue, "Max Score should be the same")
            XCTAssertEqual(viewModel.scoreBandDescription, creditReport?.creditReportInfo.equifaxScoreBandDescription, "Score Band should be the same")
            
            let viewModelScorePercent = self.calculatePercentage(currentScore: viewModel.score, maxScore: viewModel.maxScore)
            let creditReportScorePercent = self.calculatePercentage(currentScore: creditReport?.creditReportInfo.score, maxScore: creditReport?.creditReportInfo.maxScoreValue)
            XCTAssertEqual(viewModelScorePercent, creditReportScorePercent, "Score Percentages should be the same")
        }
    }
    
    private func calculatePercentage(currentScore: Int?, maxScore: Int?) -> Double {
        return Double(currentScore ?? 0) * (100/Double(maxScore ?? 0))
    }
}
