//
//  UIImageView+GetImageFromPath.swift
//  Moovies
//
//  Created by aluno on 06/11/19.
//  Copyright © 2019 aluno. All rights reserved.
//

import UIKit

    //  Fazer:
    //  Colocar a url no enum das rotas
    //  Ter uma imagem de placeholder pra caso não consiga fazer o download

extension UIImageView {
    func getImageFrom(path: String?) {
        if let path = path {
            //colocar isso no futuro enum de rotas da API
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")!
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                } else {
                    self?.image = #imageLiteral(resourceName: "noImage")
                }
            }
            
        } else {
            self.image = UIImage()
        }
    }
}
