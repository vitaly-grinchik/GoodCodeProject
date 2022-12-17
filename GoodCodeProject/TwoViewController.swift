//
//  TwoViewController.swift
//  GoodCodeProject
//
//  Created by Виталий Гринчик on 15.12.22.
//

import UIKit

final class TwoViewController: UIViewController {
    
    private let label = UILabel()
    
    private let button = UIButton()
    
    var completion: ((String) -> ())?
    
    var text = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        label.backgroundColor = .systemPink
        view.addSubview(label)
        
        view.addSubview(button)
        
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        button.setTitle("Reverse", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)

    }
    
    @objc
    private func goBack() {
        completion?(text)
        dismiss(animated: true)
    }
}
