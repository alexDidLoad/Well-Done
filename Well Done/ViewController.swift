//
//  ViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var steakButton: UIButton!
    @IBOutlet var chickenButton: UIButton!
    @IBOutlet var fishButton: UIButton!
    @IBOutlet var eggButton: UIButton!
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
    }
    
    
    func setView() {
        setButtons()
        
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Baskerville-BoldItalic", size: 25)!,
            .foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Well Done"
        
        label.text = "Choose a Protein"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Baskerville-Italic", size: 40)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setButtons() {
        
        let buttonConstant = CGFloat(150)
        
        steakButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        steakButton.layer.masksToBounds = true
        steakButton.layer.borderWidth = 3
        steakButton.layer.borderColor = UIColor.black.cgColor
        steakButton.layer.cornerRadius = 0.5 * steakButton.frame.size.width
        steakButton.imageView?.contentMode = .scaleAspectFit
        steakButton.setImage(UIImage(named: "meat"), for: .normal)
        steakButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        steakButton.backgroundColor = UIColor.white
        
        chickenButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        chickenButton.layer.masksToBounds = true
        chickenButton.layer.borderWidth = 3
        chickenButton.layer.borderColor = UIColor.black.cgColor
        chickenButton.layer.cornerRadius = 0.5 * chickenButton.frame.size.width
        chickenButton.imageView?.contentMode = .scaleAspectFit
        chickenButton.setImage(UIImage(named: "chicken"), for: .normal)
        chickenButton.imageEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        chickenButton.backgroundColor = UIColor.white
        
        fishButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        fishButton.layer.masksToBounds = true
        fishButton.layer.borderWidth = 3
        fishButton.layer.borderColor = UIColor.black.cgColor
        fishButton.layer.cornerRadius = 0.5 * chickenButton.frame.size.width
        fishButton.imageView?.contentMode = .scaleAspectFit
        fishButton.setImage(UIImage(named: "fish"), for: .normal)
        fishButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 30)
        fishButton.backgroundColor = UIColor.white
        
        eggButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        eggButton.layer.masksToBounds = true
        eggButton.layer.borderWidth = 3
        eggButton.layer.borderColor = UIColor.black.cgColor
        eggButton.layer.cornerRadius = 0.5 * eggButton.frame.size.width
        eggButton.imageView?.contentMode = .scaleAspectFit
        eggButton.setImage(UIImage(named: "egg"), for: .normal)
        eggButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 30)
        eggButton.backgroundColor = UIColor.white
        
        steakButton.translatesAutoresizingMaskIntoConstraints = false
        chickenButton.translatesAutoresizingMaskIntoConstraints = false
        fishButton.translatesAutoresizingMaskIntoConstraints = false
        eggButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            steakButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            steakButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            steakButton.widthAnchor.constraint(equalToConstant: buttonConstant),
            steakButton.heightAnchor.constraint(equalToConstant: buttonConstant),
            chickenButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            chickenButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            chickenButton.widthAnchor.constraint(equalToConstant: buttonConstant),
            chickenButton.heightAnchor.constraint(equalToConstant: buttonConstant),
            fishButton.topAnchor.constraint(equalTo: steakButton.bottomAnchor, constant: 50),
            fishButton.leadingAnchor.constraint(equalTo: steakButton.leadingAnchor),
            fishButton.widthAnchor.constraint(equalToConstant: buttonConstant),
            fishButton.heightAnchor.constraint(equalToConstant: buttonConstant),
            eggButton.topAnchor.constraint(equalTo: chickenButton.bottomAnchor, constant: 50),
            eggButton.trailingAnchor.constraint(equalTo: chickenButton.trailingAnchor),
            eggButton.heightAnchor.constraint(equalToConstant: buttonConstant),
            eggButton.widthAnchor.constraint(equalToConstant: buttonConstant)
        ])
    }
    
    @IBAction func steakButtonPressed(_ sender: UIButton) {
        
        print("meat")
    }
    @IBAction func chickenButtonPressed(_ sender: UIButton) {
        print("chicken")
    }
    
    @IBAction func fishButtonPressed(_ sender: UIButton) {
        print("fish")
    }
    
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        print("egg")
    }
    
}





