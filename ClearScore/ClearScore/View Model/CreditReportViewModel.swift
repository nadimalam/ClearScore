//
//  CreditReportViewModel.swift
//  ClearScore
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation

protocol CreditReportViewModelProtocol {
    var service: CreditReportServiceProtocol { get }
    var score: Int { get }
    var maxScore: Int { get }
    var scoreBandDescription: String { get }
    var report: Dynamic<CreditReport?> { get }
    
    func getCreditReport()
}

struct CreditReportViewModel: CreditReportViewModelProtocol {
    let service: CreditReportServiceProtocol
    var report: Dynamic<CreditReport?> = Dynamic(nil)
    
    init(service: CreditReportServiceProtocol = CreditReportService.shared) {
        self.service = service
    }
    
    var score: Int {
        guard let score = report.value?.creditReportInfo.score else {
            return 0
        }
        return score
    }
    
    var maxScore: Int {
        guard let maxScoreValue = report.value?.creditReportInfo.maxScoreValue else {
            return 0
        }
        return maxScoreValue
    }
    
    var scoreBandDescription: String {
        guard let description = report.value?.creditReportInfo.equifaxScoreBandDescription else {
            return ""
        }
        return description
    }
    
    func getCreditReport() {
        service.getCreditReport(completionHandler: { report, error in
            self.report.value = report
        })
    }
}
