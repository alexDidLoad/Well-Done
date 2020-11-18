//
//  CookViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/17/20.
//

import UIKit

class CookViewController: UIViewController {
    
    private var rareButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private var mediumRareButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private var wellDoneButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()

      
    }
    
    
    private func setView() {
        
        //set labels and background color for view and buttons
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        label.text = "3. Select a preferred doneness"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Ultralight", size: 30)
        label.numberOfLines = 0
        
        rareButton.setTitle("Rare", for: .normal)
        rareButton.setTitleColor(UIColor.black, for: .normal)
        rareButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 30)
        rareButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        mediumRareButton.setTitle("Medium Rare", for: .normal)
        mediumRareButton.setTitleColor(UIColor.black, for: .normal)
        mediumRareButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 30)
        mediumRareButton.titleLabel?.textAlignment = .center
        mediumRareButton.titleLabel?.numberOfLines = 0
        mediumRareButton.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        wellDoneButton.setTitle("Well Done", for: .normal)
        wellDoneButton.setTitleColor(UIColor.black, for: .normal)
        wellDoneButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 30)
        wellDoneButton.titleLabel?.textAlignment = .center
        wellDoneButton.titleLabel?.numberOfLines = 0
        wellDoneButton.backgroundColor = #colorLiteral(red: 1, green: 0.3905242085, blue: 0.4368999004, alpha: 1)
        
        //Add targets
        rareButton.addTarget(self, action: #selector(self.rareTap), for: .touchUpInside)
        mediumRareButton.addTarget(self, action: #selector(self.mediumRareTap), for: .touchUpInside)
        wellDoneButton.addTarget(self, action: #selector(self.wellDoneTap), for: .touchUpInside)
        
        //Add buttons to subview
        view.addSubview(rareButton)
        view.addSubview(mediumRareButton)
        view.addSubview(wellDoneButton)
        view.addSubview(label)
        
        rareButton.translatesAutoresizingMaskIntoConstraints = false
        mediumRareButton.translatesAutoresizingMaskIntoConstraints = false
        wellDoneButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints
        NSLayoutConstraint.activate([
            rareButton.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            rareButton.widthAnchor.constraint(equalToConstant: 160),
            rareButton.heightAnchor.constraint(equalToConstant: 160),
            rareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mediumRareButton.topAnchor.constraint(lessThanOrEqualTo: rareButton.bottomAnchor, constant: 20),
            mediumRareButton.heightAnchor.constraint(equalToConstant: 160),
            mediumRareButton.widthAnchor.constraint(equalToConstant: 160),
            mediumRareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wellDoneButton.topAnchor.constraint(lessThanOrEqualTo: mediumRareButton.bottomAnchor, constant: 20),
            wellDoneButton.heightAnchor.constraint(equalToConstant: 160),
            wellDoneButton.widthAnchor.constraint(equalToConstant: 160),
            wellDoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(lessThanOrEqualTo: wellDoneButton.bottomAnchor, constant: 20),
            label.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }

    
    @objc func rareTap() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "TimerVC") as? TimerViewController {
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        print("rare")
    }
    
    @objc func mediumRareTap() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "TimerVC") as? TimerViewController {
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        print("medium rare")
    }
    
    @objc func wellDoneTap() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "TimerVC") as? TimerViewController {
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
        print("well done")
    }
}
