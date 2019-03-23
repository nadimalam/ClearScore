//
//  HomeViewController.swift
//  ClearScore
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet private weak var donutView: DonutView!
    
    let viewModel = CreditReportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donutView.setupView()
        donutView.updateProgressBarWith(percent: 0)
        bind()
    }

    private func bind() {
        viewModel.report.bind { [unowned self] report in
            guard let _ = report else {
                return
            }
            self.donutView.updateLabelsWith(self.viewModel)
            self.donutView.updateProgressBarWith(percent: self.viewModel.percentageScore, isAnimated: true)
        }
        viewModel.getCreditReport()
    }
}
