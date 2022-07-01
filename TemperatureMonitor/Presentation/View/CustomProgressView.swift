//
//  CustomProgressView.swift
//  TemperatureMonitor
//
//  Created by ayaz on 27.06.2022.
//

import UIKit

class CustomProgressView: UIView {

    private var backgroundLayer: CAShapeLayer?
    private var progressLayer: CAShapeLayer?
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer?.path = configurateProgressBarPath()
        progressLayer?.path = configurateProgressBarPath()
    }
    
    public func configurate() {
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
        self.layer.addSublayer(progress)
    }
    
    public func stopLoadAnimation() {
        progressLayer?.removeAnimation(forKey: "groupAnimation")
        
        UILabel.transition(
            with: valueLabel,
            duration: 1,
            options: [.transitionCrossDissolve],
            animations: { [weak self] in
                self?.valueLabel.alpha = 1
            },
            completion: nil)
    }
    
    public func startLoadAnimation() {
        let strokeEndAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.2
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 1.5
        
        let strokeStartAnimation  = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 0.8
        strokeStartAnimation.duration = 1.5
        
        let group = CAAnimationGroup()
        
        group.repeatCount = .infinity
        group.duration = 2
        
        group.animations = [strokeStartAnimation, strokeEndAnimation]
        
        progressLayer?.add(group, forKey: "groupAnimation")
    }
    
    public func updateValue(value: Float) {
        startLoadAnimation()
        progressLayer?.removeAllAnimations()
        let progress = CGFloat(value / 100)
        let startValue = progressLayer?.strokeEnd ?? 0
        progressLayer?.strokeEnd = progress
        valueLabel.text = "\(value)%"
        let strokeEndAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = startValue
        strokeEndAnimation.toValue = progress
        strokeEndAnimation.duration = 1
        progressLayer?.add(strokeEndAnimation, forKey: "strokeEndAnimation")
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
        layer.lineWidth = 14
        layer.lineCap = .round
        layer.fillColor = nil
        layer.strokeEnd = 0
        
        return layer
    }
    
    private func configurateProgressBarPath() -> CGPath {
        return UIBezierPath(
            arcCenter: valueLabel.center,
            radius: self.frame.height / 2,
            startAngle: 3 * CGFloat.pi / 4,
            endAngle: CGFloat.pi / 4,
            clockwise: true).cgPath
    }
}
