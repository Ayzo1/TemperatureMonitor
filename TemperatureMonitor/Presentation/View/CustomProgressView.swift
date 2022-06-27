//
//  CustomProgressView.swift
//  TemperatureMonitor
//
//  Created by ayaz on 27.06.2022.
//

import UIKit

class CustomProgressView: UIView {

    // private lazy var baseView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    private var backgroundLayer: CAShapeLayer?
    private var progressLayer: CAShapeLayer?
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func configurate() {
        
        //self.addSubview(baseView)
        
        self.addSubview(valueLabel)
        setupValueLabel()
        self.addSubview(textLabel)
        setupTextLabel()
        textLabel.text = "Humidity"
        
        let background = configurateBackgroundLayer()
        self.layer.addSublayer(background)
        backgroundLayer = background
        
        let progress = configurateProgressLayer()
        progressLayer = progress
        self.layer.insertSublayer(progress, above: backgroundLayer)
        
        self.backgroundColor = .brown
        // baseView.backgroundColor = .cyan
    }
    
    public func updatePositions() {
        backgroundLayer?.path = configurateProgressBarPath()
        progressLayer?.path = configurateProgressBarPath()
    }
    
    public func updateValue(value: Float) {
        
        // resetProgressBar()
        // progressLayer?.removeAllAnimations()
        
        let progress = CGFloat(value / 100)
        
        let startValue = progressLayer?.strokeEnd ?? 0.7
        
        progressLayer?.strokeEnd = progress
        
        valueLabel.text = "\(value)%"
        
        /*
        let strokeEndAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        
        strokeEndAnimation.fromValue = startValue
        strokeEndAnimation.toValue = progress
        strokeEndAnimation.duration = 0.2
        progressLayer?.add(strokeEndAnimation, forKey: "strokeEndAnimation")
         */
    }
    
    private func setupValueLabel() {
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupTextLabel() {
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    private func resetProgressBar() {
        progressLayer?.strokeEnd = 0
        progressLayer?.removeAllAnimations()
    }
    
    private func configurateBackgroundLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        layer.path = configurateProgressBarPath()
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineWidth = 8
        layer.lineCap = .round
        layer.fillColor = nil
        
        return layer
    }
    
    private func configurateProgressLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        layer.path = configurateProgressBarPath()
        layer.strokeColor = UIColor.blue.cgColor
        layer.lineWidth = 8
        layer.lineCap = .round
        layer.fillColor = nil
        layer.strokeEnd = 0
        
        return layer
    }
    
    private func configurateProgressBarPath() -> CGPath {
        var a = self.center
        
        
        return UIBezierPath(
            arcCenter: self.center,
            radius: self.frame.height/2,
            startAngle: 3 * CGFloat.pi / 4,
            endAngle: CGFloat.pi / 4,
            clockwise: true).cgPath
    }
}
