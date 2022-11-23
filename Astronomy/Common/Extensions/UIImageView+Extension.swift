//
//  UIImageView+Extension.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import UIKit
import Foundation

extension UIImageView {
    public func imageFromUrl(urlString: String?) {
        guard let url = URL(string: urlString ?? "") else { return }
        if let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            self.image = image
        }
    }
}
