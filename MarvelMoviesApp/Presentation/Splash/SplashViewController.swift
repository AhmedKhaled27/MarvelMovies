//
//  SplashViewController.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 27/11/2023.
//

import UIKit

class SplashViewController: UIViewController {
    
    //MARK: OutLets
    @IBOutlet weak var logoImageView: UIImageView!
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoImageAnimation()
    }
    
}

//MARK: Helper Functions
extension SplashViewController {
    private func setupLogoImageAnimation() {
        logoImageView.alpha = 0.0
        UIView.animate(withDuration: 2.0, animations: {
            self.logoImageView.alpha = 1.0
        }) { (completed) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigateToMovies()
            }
        }
    }
    
    private func navigateToMovies() {
        let viewModel = MoviesListViewModel()
        let moviesViewController = MoviesListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: moviesViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        present(navigationController, animated: true)
    }
}
