//
//  LaunchScreenViewController.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 2.03.2024.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    let loodosLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 94/255, green: 173/255, blue: 188/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 85, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("App started.")
        view.backgroundColor = UIColor(red: 218/255, green: 224/255, blue: 215/255, alpha: 1.0)
        view.addSubview(loodosLabel)
        NSLayoutConstraint.activate([
            loodosLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loodosLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loodosLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loodosLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateLoodosText()
    }
    
    func animateLoodosText() {
        loodosLabel.text = ""
        let text = FirebaseManager.shared.loodosText()
        var charIndex = 0.0
        
        for char in text {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { timer in
                self.loodosLabel.text?.append(char)
            }
            charIndex += 1
        }
    }
}
