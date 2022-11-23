//
//  StoryboardInstantiable.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import Foundation
import UIKit

protocol StoryboardInstantiable {
    static var storyboardName: String { get }
    static var identifier: String { get }

    static func instantiate() -> Self
}

extension StoryboardInstantiable where Self: UIViewController {

    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("Unable to instantiate ViewController with identifier \(identifier)")
        }
        return viewController
    }
}
