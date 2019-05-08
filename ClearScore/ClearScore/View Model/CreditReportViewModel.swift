//
//  CreditReportViewModel.swift
//  ClearScore
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation

protocol CreditReportViewModelProtocol {
    var report: Dynamic<CreditReport?> { get }
    var score: Int { get }
    var maxScore: Int { get }
    var scoreBandDescription: String { get }
    var percentageScore: Double { get }

    var service: CreditReportServiceProtocol { get }
    
    func getCreditReport()
}

struct CreditReportViewModel: CreditReportViewModelProtocol {
    
    let report: Dynamic<CreditReport?> = Dynamic(nil)
    let service: CreditReportServiceProtocol
    
    init(service: CreditReportServiceProtocol = CreditReportService.shared) {
        self.service = service
    }
    
    var score: Int {
        guard let score = report.value?.creditReportInfo?.score else {
            return 0
        }
        return score
    }
    
    var maxScore: Int {
        guard let maxScoreValue = report.value?.creditReportInfo?.maxScoreValue else {
            return 0
        }
        return maxScoreValue
    }
    
    var scoreBandDescription: String {
        guard let description = report.value?.creditReportInfo?.equifaxScoreBandDescription else {
            return ""
        }
        return description
    }
    
    var percentageScore: Double {
        guard let score = report.value?.creditReportInfo?.score,
            let maxScoreValue = report.value?.creditReportInfo?.maxScoreValue else {
                return 0
        }
        let percentage = Double(score) * (100/Double(maxScoreValue))
        return percentage
    }
    
    func getCreditReport() {
        service.getCreditReport(completionHandler: { report, error in
            self.report.value = report
        })
    }
}
