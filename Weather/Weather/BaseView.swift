//
//  BaseView.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/22/23.
//

import UIKit

open class BaseView: UIView, ConstructableView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        construct()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func constructSubviewHierarchy() {
        // No-op, implement in subclass
    }
    
    open func constructLayout() {
        //No-op, implement in subclass
    }
}


public protocol ConstructableView {
    func constructSubviewHierarchy()
    
    func constructLayout()
}

extension ConstructableView {
    public func construct() {
        constructSubviewHierarchy()
        constructLayout()
    }
}
