//
//  BaseViewController.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import UIKit

class BaseViewController: UIViewController {
    func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let style: UIActivityIndicatorView.Style
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                style = .medium
            } else {
                style = .medium
            }
        } else {
            style = .gray
        }

        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)

        return activityIndicator
    }
}

//MARK: Alert
extension BaseViewController {
    func showErrorAlert(string : String) -> Void {
        let alertWarning = UIAlertController(title: "Error!",
                                             message: string,
                                             preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertWarning.addAction(defaultAction)
        present(alertWarning, animated: true, completion: nil)
    }
}
