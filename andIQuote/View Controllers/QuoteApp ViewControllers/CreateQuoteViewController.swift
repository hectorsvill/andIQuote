//
//  CreateQuoteViewController.swift
//  andIQuote
//
//  Created by s on 3/10/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class CreateQuoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(dismissView))
        navigationItem.leftBarButtonItem?.tintColor = .label
    }

    @objc func dismissView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
