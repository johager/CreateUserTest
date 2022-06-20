//
//  UIView+.swift
//  CreateUserTest
//
//  Created by James Hager on 6/20/22.
//

import Foundation

import UIKit

extension UIView {
    
    func pin(top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, margin: [CGFloat] = [0, 0, 0, 0]) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: margin[0]).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -margin[1]).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -margin[2]).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: margin[3]).isActive = true
        }
    }
}
