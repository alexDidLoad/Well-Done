//
//  CookViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/17/20.
//

import UIKit

class CookViewController: UIViewController {
    
    private var topButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private var midButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private var botButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private let label = UILabel()
    
    public var selectedMethod: String?
    public var selectedProtein: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
    }

    
    //MARK: - Set View Method
    
    private func setView() {
                
        //set labels and background color for view and buttons
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        label.text = "3. Select a preferred doneness"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Ultralight", size: 30)
        label.numberOfLines = 0
        
        topButton.setTitle("Rare", for: .normal)
        topButton.setTitleColor(UIColor.black, for: .normal)
        topButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 30)
        topButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        midButton.setTitle("Medium Rare", for: .normal)
        midButton.setTitleColor(UIColor.black, for: .normal)
        midButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 30)
        midButton.titleLabel?.textAlignment = .center
        midButton.titleLabel?.numberOfLines = 0
        midButton.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        botButton.setTitle("Well Done", for: .normal)
        botButton.setTitleColor(UIColor.black, for: .normal)
        botButton.titleLabel?.font = UIFont(name: "SFProText-Medium", size: 30)
        botButton.titleLabel?.textAlignment = .center
        botButton.titleLabel?.numberOfLines = 0
        botButton.backgroundColor = #colorLiteral(red: 1, green: 0.3905242085, blue: 0.4368999004, alpha: 1)
        
        //Add targets
        topButton.addTarget(self, action: #selector(self.rareTap), for: .touchUpInside)
        midButton.addTarget(self, action: #selector(self.mediumRareTap), for: .touchUpInside)
        botButton.addTarget(self, action: #selector(self.wellDoneTap), for: .touchUpInside)
        
        //Add buttons to subview
        view.addSubview(topButton)
        view.addSubview(midButton)
        view.addSubview(botButton)
        view.addSubview(label)
        
        topButton.translatesAutoresizingMaskIntoConstraints = false
        midButton.translatesAutoresizingMaskIntoConstraints = false
        botButton.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints
        NSLayoutConstraint.activate([
            topButton.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            topButton.widthAnchor.constraint(equalToConstant: 160),
            topButton.heightAnchor.constraint(equalToConstant: 160),
            topButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            midButton.topAnchor.constraint(lessThanOrEqualTo: topButton.bottomAnchor, constant: 20),
            midButton.heightAnchor.constraint(equalToConstant: 160),
            midButton.widthAnchor.constraint(equalToConstant: 160),
            midButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botButton.topAnchor.constraint(lessThanOrEqualTo: midButton.bottomAnchor, constant: 20),
            botButton.heightAnchor.constraint(equalToConstant: 160),
            botButton.widthAnchor.constraint(equalToConstant: 160),
            botButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(lessThanOrEqualTo: botButton.bottomAnchor, constant: 20),
            label.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        updateButtonLabels()
        
    }
    
    //MARK: - Obj-c Methods
    
    @objc func rareTap() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "TimerVC") as? TimerViewController {
            vc.cookTime = calculateCookTime(for: selectedProtein, method: selectedMethod, doneness: topButton.currentTitle)
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    @objc func mediumRareTap() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "TimerVC") as? TimerViewController {
            vc.cookTime = 420
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    @objc func wellDoneTap() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "TimerVC") as? TimerViewController {
            vc.cookTime = 640
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    
    //MARK: - Update Label Method
    
    private func updateButtonLabels() {
        
        if selectedProtein == "chicken" || selectedProtein == "fish" {
            
            self.topButton.setTitle("Medium", for: .normal)
            self.midButton.setTitle("Medium Well", for: .normal)
            self.botButton.setTitle("Well Done", for: .normal)
            
        } else if selectedProtein == "egg" {
            self.topButton.setTitle("Soft Boiled", for: .normal)
            self.midButton.setTitle("Medium Boiled", for: .normal)
            self.botButton.setTitle("Hard Boiled", for: .normal)
            
        } else {
            return
        }
    }
    
    //MARK: - calculate cooktime method
    
    private func calculateCookTime(for protein: String!, method: String!, doneness: String!) -> Double {
        
        var cookTime = 0.0
        
        if protein == "steak" && method == "pan" && doneness == "Rare" {
            cookTime = 120
        }
        
        
        return cookTime
    }
    
}
