//
//  ViewController.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import UIKit

final class ViewController: UIViewController,StoryboardInstantiable {
    static var storyboardName: String = String(describing: ViewController.self)

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailTextView: UITextView!
    @IBOutlet private var astronomyImageView: UIImageView!
    
    private var viewModel: AstronomyViewModel!
    
    static func initializeVC(with viewModel: AstronomyViewModel) -> ViewController {
        let viewController = ViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

