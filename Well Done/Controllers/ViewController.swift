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
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
    }
    
    //MARK: - Set View methods
    
    private func setView() {
        
        setButtons()
        
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "SFProText-Light", size: 30)!,
            .foregroundColor: UIColor.black,
        ]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = view.backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Well Done"
        
        label.text = "1. Select a Protein"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Ultralight", size: 36)
    }
    
    private func setButtons() {
        
        let buttonConstant = CGFloat(150)
        let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.40).cgColor
        let shadowOffSet = CGSize(width: 0, height: 10.0)
        let shadowOpacity = Float(1.0)
        let shadowRadius = CGFloat(10.0)
        
        steakButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        steakButton.layer.masksToBounds = false
        steakButton.layer.borderWidth = 3
        steakButton.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        steakButton.layer.shadowColor = shadowColor
        steakButton.layer.shadowOffset = shadowOffSet
        steakButton.layer.shadowOpacity = shadowOpacity
        steakButton.layer.shadowRadius = shadowRadius
        steakButton.layer.cornerRadius = 0.5 * steakButton.frame.size.width
        steakButton.imageView?.contentMode = .scaleAspectFit
        steakButton.setImage(UIImage(named: "meat"), for: .normal)
        steakButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        steakButton.backgroundColor = UIColor.white
        
        chickenButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        chickenButton.layer.masksToBounds = false
        chickenButton.layer.borderWidth = 3
        chickenButton.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        chickenButton.layer.shadowColor = shadowColor
        chickenButton.layer.shadowOffset = shadowOffSet
        chickenButton.layer.shadowOpacity = shadowOpacity
        chickenButton.layer.shadowRadius = shadowRadius
        chickenButton.layer.cornerRadius = 0.5 * chickenButton.frame.size.width
        chickenButton.imageView?.contentMode = .scaleAspectFit
        chickenButton.setImage(UIImage(named: "chicken"), for: .normal)
        chickenButton.imageEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        chickenButton.backgroundColor = UIColor.white
        
        fishButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        fishButton.layer.masksToBounds = false
        fishButton.layer.borderWidth = 3
        fishButton.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        fishButton.layer.shadowColor = shadowColor
        fishButton.layer.shadowOffset = shadowOffSet
        fishButton.layer.shadowOpacity = shadowOpacity
        fishButton.layer.shadowRadius = shadowRadius
        fishButton.layer.cornerRadius = 0.5 * chickenButton.frame.size.width
        fishButton.imageView?.contentMode = .scaleAspectFit
        fishButton.setImage(UIImage(named: "fish"), for: .normal)
        fishButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 30)
        fishButton.backgroundColor = UIColor.white
        
        eggButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        eggButton.layer.masksToBounds = false
        eggButton.layer.borderWidth = 3
        eggButton.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor
        eggButton.layer.shadowColor = shadowColor
        eggButton.layer.shadowRadius = shadowRadius
        eggButton.layer.shadowOffset = shadowOffSet
        eggButton.layer.shadowOpacity = shadowOpacity
        eggButton.layer.cornerRadius = 0.5 * eggButton.frame.size.width
        eggButton.imageView?.contentMode = .scaleAspectFit
        eggButton.setImage(UIImage(named: "egg"), for: .normal)
        eggButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 30)
        eggButton.backgroundColor = UIColor.white
        
        steakButton.translatesAutoresizingMaskIntoConstraints = false
        chickenButton.translatesAutoresizingMaskIntoConstraints = false
        fishButton.translatesAutoresizingMaskIntoConstraints = false
        eggButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            steakButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            steakButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            steakButton.trailingAnchor.constraint(lessThanOrEqualTo: chickenButton.leadingAnchor),
            steakButton.widthAnchor.constraint(equalToConstant: buttonConstant),
            steakButton.heightAnchor.constraint(equalToConstant: buttonConstant),
            chickenButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            chickenButton.leadingAnchor.constraint(greaterThanOrEqualTo: steakButton.trailingAnchor),
            chickenButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            chickenButton.widthAnchor.constraint(equalToConstant: buttonConstant),
            chickenButton.heightAnchor.constraint(equalToConstant: buttonConstant),
            fishButton.topAnchor.constraint(equalTo: steakButton.bottomAnchor, constant: 50),
            fishButton.leadingAnchor.constraint(equalTo: steakButton.leadingAnchor),
            fishButton.widthAnchor.constraint(equalToConstant: buttonConstant),
            fishButton.heightAnchor.constraint(equalToConstant: buttonConstant),
            eggButton.topAnchor.constraint(equalTo: chickenButton.bottomAnchor, constant: 50),
            eggButton.trailingAnchor.constraint(equalTo: chickenButton.trailingAnchor),
            eggButton.heightAnchor.constraint(equalToConstant: buttonConstant),
            eggButton.widthAnchor.constraint(equalToConstant: buttonConstant),
            label.topAnchor.constraint(equalTo: eggButton.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @IBAction func steakButtonPressed(_ sender: UIButton) {
        
        if let vc = storyboard?.instantiateViewController(identifier: "ChoiceVC") as? ChoiceViewController {
            vc.selectedProtein = "steak"
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
       
    }
    @IBAction func chickenButtonPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "ChoiceVC") as? ChoiceViewController {
            vc.selectedProtein = "chicken"
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
       
    }
    
    @IBAction func fishButtonPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "ChoiceVC") as? ChoiceViewController {
            vc.selectedProtein = "fish"
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
        
    }
    
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "ChoiceVC") as? ChoiceViewController {
            vc.selectedProtein = "egg"
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
       
    }
    
}





