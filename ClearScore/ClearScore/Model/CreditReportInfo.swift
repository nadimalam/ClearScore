//
//  CreditReportInfo.swift
//  ClearScore
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation

struct CreditReportInfo: Decodable {
    let score: Int?
    let maxScoreValue: Int?
    let minScoreValue: Int?
    let equifaxScoreBandDescription: String?
}

extension CreditReportInfo {
    static func initCreditReportInfo() -> CreditReportInfo {
        let creditReportInfo = CreditReportInfo(score: 450,
                                                maxScoreValue: 700,
                                                minScoreValue: 0,
                                                equifaxScoreBandDescription: "Excellent")
        return creditReportInfo
    }
}
