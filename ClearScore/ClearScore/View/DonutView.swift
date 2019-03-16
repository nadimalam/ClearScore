//
//  DonutView.swift
//  ClearScore
//
//  Created by Nadim Alam on 16/03/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import UIKit

class DonutView: UIView {    
    // MARK: - IBOutlet
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var maxScoreLabel: UILabel!
    @IBOutlet private weak var scoreBandDescriptionLabel: UILabel!
    
    let animationDuration = 3.0
    
    private let backgroundShape = CAShapeLayer()
    private let currentProgressShape = CAShapeLayer()
    
    func setupView() {
        // Display Background Circle.
        let frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        backgroundShape.frame = frame
        backgroundShape.path = UIBezierPath(ovalIn: frame).cgPath
        backgroundShape.lineWidth = 2.0
        backgroundShape.fillColor = UIColor.clear.cgColor
        backgroundShape.strokeColor = UIColor.black.cgColor
        layer.addSublayer(backgroundShape)
        // Hide the score band.
        scoreBandDescriptionLabel.alpha = 0.0
    }
    
    func updateLabelsWith(_ viewModel: CreditReportViewModel) {
        self.incrementLabel(to: viewModel.score)
        self.maxScoreLabel.text = "out of \(viewModel.maxScore)"
        self.scoreBandDescriptionLabel.text = viewModel.scoreBandDescription
    }
    
    func updateProgressBarWith(percent: Double, isAnimated: Bool = false) {
        // Set the animation for the progress shape.
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = currentProgressShape.strokeEnd
        animation.toValue = percent/100.0
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        // Calculate positions for the bezier path.
        let currentProgressShapeFrame = backgroundShape.frame
        let startAngle = CGFloat(Double.pi/2) * 3.0
        let endAngle = startAngle + CGFloat(Double.pi/2) * 4.0
        let width = currentProgressShapeFrame.size.width/2
        let height = currentProgressShapeFrame.size.height/2
        let centerPoint = CGPoint(x: width, y: height)
        let radius = width - 10
        let bezierPath = UIBezierPath(arcCenter: centerPoint,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true).cgPath
        
        // Create the fill stroke.
        currentProgressShape.frame = currentProgressShapeFrame
        currentProgressShape.path = bezierPath
        currentProgressShape.position = backgroundShape.position
        currentProgressShape.lineWidth = 6.0
        currentProgressShape.fillColor = UIColor.clear.cgColor
        currentProgressShape.strokeColor = UIColor.orange.cgColor
        currentProgressShape.strokeEnd = CGFloat(percent/100)
        currentProgressShape.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(currentProgressShape)
        
        if isAnimated {
            currentProgressShape.add(animation, forKey: nil)
        }
    }
    
    private func incrementLabel(to endValue: Int?) {
        guard let endValue = endValue else { return }
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = (self.animationDuration/Double(endValue) * 1000000.0)
                usleep(useconds_t(sleepTime))
                DispatchQueue.main.async {
                    self.scoreLabel.text = "\(i)"
                }
            }
            DispatchQueue.main.async {
                self.displayAnimatedScoreBandDescription()
            }
        }
    }
    
    private func displayAnimatedScoreBandDescription() {
        // Display the score band lable.
        self.scoreBandDescriptionLabel.alpha = 1.0
        
        // Then animate the lable.
        UILabel.animate(withDuration: 1,
                        delay: 0,
                        options: [.repeat, .autoreverse, .beginFromCurrentState],
                        animations: {
                            self.scoreBandDescriptionLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { finished in
            
        })
    }
}
