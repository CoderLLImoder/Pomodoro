//
//  CircularProgressBarView.swift
//  HW12
//
//  Created by Илья Капёрский on 13.08.2023.
//

import UIKit

class CircularProgressBarView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
        

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    func createCircularPath() {
        // created circularPath for circleLayer and progressLayer
        let circularPath = UIBezierPath(arcCenter: self.center, radius: 160, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 1.0
        progressLayer.strokeEnd = 1.0
        progressLayer.strokeColor = UIColor(named: "golden")!.cgColor
        // added progressLayer to layer
        layer.addSublayer(progressLayer)
        }
    
    func progressAnimation(duration: TimeInterval, fromValue: Double) {
            // created circularProgressAnimation with keyPath
            let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            // set the end time
            circularProgressAnimation.duration = duration
            circularProgressAnimation.toValue = 1.0
            circularProgressAnimation.fromValue = fromValue
            circularProgressAnimation.fillMode = .backwards
            circularProgressAnimation.isRemovedOnCompletion = false
            progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        }
    
    func setColor(_ color: String){
        progressLayer.strokeColor = UIColor(named: color)!.cgColor
    }
    
    func stopAnimation(fromValue: Double) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = .infinity
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fromValue = fromValue
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}

