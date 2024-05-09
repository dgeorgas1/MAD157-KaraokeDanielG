//
//  DrawerMenuViewController.swift
//  Drawer Menu App
//
//  Created by student on 3/16/24.
//

import UIKit

class DrawerMenuViewController: UIViewController {
    var songsArray: [Song] = []

    let transitionManager = DrawerTransitionManager()

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = transitionManager
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToSongs(_ sender: UIButton) {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewControllerIdentifier = "songs_id"

        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func goToFavorites(_ sender: UIButton) {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewControllerIdentifier = "favorites_id"
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? FavoritesViewController {
            viewController.songsArray = songsArray
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func goToRecordings(_ sender: UIButton) {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewControllerIdentifier = "recordings_id"
        
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func goToSettings(_ sender: UIButton) {
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewControllerIdentifier = "settings_id"
        
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
    }
}
