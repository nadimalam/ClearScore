//
//  CreditReport.swift
//  ClearScore
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation

struct CreditReport: Decodable {
    let accountIDVStatus: String?
    let creditReportInfo: CreditReportInfo?
    let personaType: String?
}

extension CreditReport {
    static func initCreditReport() -> CreditReport {
        let creditReport = CreditReport(accountIDVStatus: "accountIDVStatus",
                                        creditReportInfo: CreditReportInfo.initCreditReportInfo(),
                                        personaType: "personaType")
        return creditReport
    }
}
