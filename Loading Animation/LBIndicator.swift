//
//  LBIndicator.swift
//  LoadingButtons
//
//  Created by Ho, Tsung Wei on 8/7/19.
//  Copyright © 2019 Ho, Tsungwei. All rights reserved.
//

import UIKit

open class LBIndicator: UIView, IndicatorProtocol {
    open var isAnimating: Bool = false
    open var radius: CGFloat = 18.0
    open var color: UIColor = .lightGray
    
    public convenience init(radius: CGFloat = 18.0, color: UIColor = .gray) {
        self.init()
        self.radius = radius
        self.color = color
    }

    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 12.0, *) {
            let userInterfaceStyle = traitCollection.userInterfaceStyle
            if userInterfaceStyle == .dark{
                stopAnimating()
//                color = .black
                startAnimating()
            }else{
                stopAnimating()
//                color = .lightGray
                startAnimating()
            }
        } else {
            stopAnimating()
//            color = .lightGray
            startAnimating()
        }
        // Either .unspecified, .light, or .dark
        
    }
    open func startAnimating() {
        guard !isAnimating else { return }
        isHidden = false
        isAnimating = true
        layer.speed = 1
        setupAnimation(in: self.layer, size: CGSize(width: 2*radius, height: 2*radius))
    }
    
    open func stopAnimating() {
        guard isAnimating else { return }
        DispatchQueue.main.async {
            self.isHidden = true
            self.isAnimating = false
            self.layer.sublayers?.removeAll()
        }
        
    }
    
    open func setupAnimation(in layer: CALayer, size: CGSize) {
        fatalError("Need to be implemented")
    }
}
