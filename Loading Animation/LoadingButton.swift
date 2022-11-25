//
//  LoadingButton.swift
//  Peepul
//
//  Created by Selva-G on 09/12/19.
//  Copyright © 2019 Selva-G. All rights reserved.
//

import Foundation
import UIKit



open class LoadingButton: UIButton{
     // MARK: - Public variables
     /**
     Current loading state.
     */
    public var isLoading: Bool = false
    private var btnImage: UIImage?
     // MARK: - Package-protected variables
     /**
     The loading indicator used with the button.
     */
     open var indicator: UIView & IndicatorProtocol = UIActivityIndicatorView()
    
     /**
     Display the loader inside the button.
     
     - Parameter userInteraction: Enable the user interaction while displaying the loader.
     - Parameter completion:      The completion handler.
     */
    
    open func showLoader(userInteraction:Bool = false, color: UIColor? = nil) {
        guard !self.subviews.contains(indicator) else { return }
        if userInteraction == false{
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        self.setTitle("", for: .normal)
        btnImage = self.imageView?.image
        self.setImage(UIImage(), for: .normal)
        // Set up loading indicator
//        indicator = BallPulseIndicator(color: .gray)
                if let color = color{
                      indicator = BallPulseIndicator(color: color)
                    }else if let color = self.titleLabel?.textColor {
                      indicator = BallPulseIndicator(color: color)
                    }else{
                        indicator = BallPulseIndicator(color: .white)
                    }
        
        indicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        indicator.radius = min(0.7*self.frame.height/2, indicator.radius)
        isLoading = true
        

        
        self.addSubview(self.indicator)
        if self.isLoading {
            self.indicator.startAnimating()
        } else {
            self.hideLoader()
        }
    }
    
    /**
       Hide the loader displayed.
       
       - Parameter completion: The completion handler.
       */
      open func hideLoader() {
        DispatchQueue.main.async {
            guard self.subviews.contains(self.indicator) else { return }
          UIApplication.shared.endIgnoringInteractionEvents()
          self.isUserInteractionEnabled = true
            self.isLoading = false
            self.indicator.stopAnimating()
            self.indicator.removeFromSuperview()
            
            UIView.transition(with: self, duration: 0.2, options: .curveEaseIn, animations: {
                self.setTitle(self.titleLabel?.text ?? "", for: .normal)
                self.setImage(self.btnImage, for: .normal)
            }, completion: nil)
            
        }
          
          
      }
}



// MARK: - UIActivityIndicatorView
extension UIActivityIndicatorView: IndicatorProtocol {
    
    
    public var radius: CGFloat {
        get {
            return self.frame.width/2
        }
        set {
            self.frame.size = CGSize(width: 2*newValue, height: 2*radius)
            self.setNeedsDisplay()
        }
    }
    
    public var color: UIColor {
        get {
            return self.tintColor
        }
        set {
            self.tintColor = newValue
        }
    }
    // unused
    public func setupAnimation(in layer: CALayer, size: CGSize) {}
}

public protocol IndicatorProtocol {

    /**
     The radius of the indicator.
     */
    var radius: CGFloat { get set }
    /**
     The primary color of the indicator.
     */
    var color: UIColor { get set }
    /**
     Current status of animation, read-only.
     */
    var isAnimating: Bool { get }
    /**
     Start animating.
     */
    func startAnimating()
    /**
     Stop animating and remove layer.
     */
    func stopAnimating()
    /**
     Set up the animation of the indicator.
     
     - Parameter layer: The layer to present animation.
     - Parameter size:  The size of the animation.
     */
    func setupAnimation(in layer: CALayer, size: CGSize)
}


