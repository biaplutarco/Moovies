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
            DispatchQueue.global().async { [weak self] in
                guard let data = try? Data(contentsOf: MoviePoster.get(path: path).url),
                    let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                        self?.image = image
                }
            }
        } else {
            self.image = #imageLiteral(resourceName: "noImage")
        }
    }
}
