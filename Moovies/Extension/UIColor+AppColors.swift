//
//  UIColor+AppColors.swift
//  Moovies
//
//  Created by aluno on 08/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

extension UIColor {
    open class var background: UIColor {
        return UIColor.init(named: "background") ?? UIColor.black
    }
    
    open class var action: UIColor {
        return UIColor.init(named: "action") ?? UIColor.black
    }
    
    open class var text: UIColor {
        return UIColor.init(named: "text") ?? UIColor.black
    }
}
