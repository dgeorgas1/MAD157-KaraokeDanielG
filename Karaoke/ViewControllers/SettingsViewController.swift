//
//  SettingsViewController.swift
//  KaraokeUITests
//
//  Created by student on 3/16/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openDrawer(_ sender: UIBarButtonItem) {
        let drawerViewController = DrawerMenuViewController()
        present(drawerViewController, animated: true)
    }
}
