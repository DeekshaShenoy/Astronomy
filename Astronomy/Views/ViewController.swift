//
//  ViewController.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import UIKit

final class ViewController: UIViewController,StoryboardInstantiable {
    // TODO: Create a file to save al storyboard constants
    static var storyboardName: String = "Main"
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailTextView: UITextView!
    @IBOutlet private var astronomyImageView: UIImageView!
    
    private var indicatorView: UIActivityIndicatorView?
    private let reachability = try! Reachability()
    private var viewModel: AstronomyViewModel!
    
    static func initializeVC(with viewModel: AstronomyViewModel = AstronomyViewModel()) -> ViewController {
        let viewController = ViewController.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        // Customise UI Font, color, style
        showAnActivityIndicator()
        guard reachability.connection != .unavailable else {
            hideAnActivityIndicator()
            showLastSavedInfo()
            return
        }
        // Fetch Data from API
        viewModel.fetchAstronomyInfo()
        handleSuccessCallback()
        handleFailureCallback()
    }
    
    private func showLastSavedInfo() {
        // Show last saved Info
        if let astronomyInfo = viewModel.getAstronomyInfo() {
            // Compare Today date with saved date If not matching show an error
            if !viewModel.dateIsInToday(dateString: astronomyInfo.date) {
                showInternetAlert()
            }
            updateUI(astronomyData: astronomyInfo)
        }
    }
    
    private func handleSuccessCallback() {
        viewModel.primaryCareSuccessCallback = { [weak self] astronomyData in
            DispatchQueue.main.async {
                self?.hideAnActivityIndicator()
                if let astronomyData = astronomyData {
                    self?.updateUI(astronomyData: astronomyData)
                }
            }
        }
    }
    
    private func handleFailureCallback() {
        viewModel.primaryCareFailureCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.hideAnActivityIndicator()
                self?.showInternetAlert()
            }
        }
    }
    
    private func updateUI(astronomyData: AstronomyResponse) {
        titleLabel.text = astronomyData.title
        detailTextView.text = astronomyData.explanation
        astronomyImageView.imageFromUrl(urlString: astronomyData.url)
    }
    
}

// MARK: Show Internet pop up
private extension ViewController {
    func showInternetAlert() {
        // TODO: MOVE all text content to localised/constants file
        let alertDetail = AlertDetails(title: "OK", style: .default, accessibilityLabel: "Okay") {
            // Do nothing
        }
        let alertInfo = AlertInfo(title: "Unable to load latest info", message: "We are not connected to the internet, showing you the last image we have.", options: [alertDetail])
        presentAlertWith(alertInfo: alertInfo)
    }
}

// MARK: Handle activityIndicator
private extension ViewController {
    // Create a component for activityIndicator
    func activityIndicator(style: UIActivityIndicatorView.Style = .medium,
                           frame: CGRect? = nil,
                           center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        
        if let center = center {
            activityIndicatorView.center = center
        }
        
        return activityIndicatorView
    }
    
    func showAnActivityIndicator() {
        if indicatorView == nil {
            indicatorView = self.activityIndicator(style: .medium,
                                                   center: self.view.center)
            view.addSubview(indicatorView!)
        }
        indicatorView?.startAnimating()
    }
    
    func hideAnActivityIndicator() {
        indicatorView?.removeFromSuperview()
        indicatorView?.stopAnimating()
    }
}
