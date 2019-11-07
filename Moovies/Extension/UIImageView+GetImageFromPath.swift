//
//  UIImageView+GetImageFromPath.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImageFrom(path: String?) {
        if let path = path {
            let url = URL(string: path)!
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
            
        } else {
            self.image = UIImage()
        }
    }
}
