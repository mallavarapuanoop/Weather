//
//  UIView+Extensions.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/22/23.
//

import UIKit

extension UIView {
    func pinToEdges(to parentView: UIView, horizantalPadding: CGFloat = 0,
                    verticalPadding: CGFloat = 0) {
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: horizantalPadding).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -horizantalPadding).isActive = true
        topAnchor.constraint(equalTo: parentView.topAnchor, constant: verticalPadding).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -verticalPadding).isActive = true
    }
    
    func pinToCenter(to parentView: UIView, size: CGFloat = 16) {
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
        centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
    }
    
    @discardableResult
    func addBlur(style: UIBlurEffect.Style = .extraLight) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        addSubview(blurBackground)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return blurBackground
    }
}

