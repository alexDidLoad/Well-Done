//
//  ChoiceViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/15/20.
//

import UIKit

class ChoiceViewController: UIViewController {
    
    private var topMethodButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private var midMethodButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private var botMethodButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private let label = UILabel()
    
    private var topMethod: String!
    private var midMethod: String!
    private var botMethod: String!
    
    public var selectedProtein: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
    }
    
    //MARK: - Set View Method
    
    private func setView() {
        
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        label.text = "2. Select a method"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Light", size: 30)
        label.numberOfLines = 0
        
        topMethodButton.setImage(UIImage(named: "pan"), for: .normal)
        topMethodButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 24)
        midMethodButton.setImage(UIImage(named: "oven"), for: .normal)
        midMethodButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        botMethodButton.setImage(UIImage(named: "fryer"), for: .normal)
        botMethodButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 12)
        
        topMethodButton.addTarget(self, action: #selector(self.topTap), for: .touchUpInside)
        midMethodButton.addTarget(self, action: #selector(self.midTap), for: .touchUpInside)
        botMethodButton.addTarget(self, action: #selector(self.botTap), for: .touchUpInside)
        
        view.addSubview(topMethodButton)
        view.addSubview(midMethodButton)
        view.addSubview(botMethodButton)
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        topMethodButton.translatesAutoresizingMaskIntoConstraints = false
        midMethodButton.translatesAutoresizingMaskIntoConstraints = false
        botMethodButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topMethodButton.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            topMethodButton.widthAnchor.constraint(equalToConstant: 160),
            topMethodButton.heightAnchor.constraint(equalToConstant: 160),
            topMethodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            midMethodButton.topAnchor.constraint(lessThanOrEqualTo: topMethodButton.bottomAnchor, constant: 30),
            midMethodButton.heightAnchor.constraint(equalToConstant: 160),
            midMethodButton.widthAnchor.constraint(equalToConstant: 160),
            midMethodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            botMethodButton.topAnchor.constraint(equalTo: midMethodButton.bottomAnchor, constant: 30),
            botMethodButton.heightAnchor.constraint(equalToConstant: 160),
            botMethodButton.widthAnchor.constraint(equalToConstant: 160),
            botMethodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: botMethodButton.bottomAnchor, constant: 30),
            label.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        updateImage()
    }
    
    //MARK: - Button methods
    
    @objc func topTap() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "CookVC") as? CookViewController {
            vc.selectedMethod = topMethod
            vc.selectedProtein = selectedProtein
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
        
    }
    
    @objc func midTap() {
        if let vc = storyboard?.instantiateViewController(identifier: "CookVC") as? CookViewController {
            vc.selectedMethod = midMethod
            vc.selectedProtein = selectedProtein
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
        
    }
    
    @objc func botTap() {
        if let vc = storyboard?.instantiateViewController(identifier: "CookVC") as? CookViewController {
            vc.selectedMethod = botMethod
            vc.selectedProtein = selectedProtein
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
    }
    
    //MARK: - Update Button Images and cooking methods
    
    private func updateImage() {
        
        if selectedProtein == "steak" {
            
            topMethodButton.setImage(UIImage(named: "pan"), for: .normal)
            midMethodButton.setImage(UIImage(named: "oven"), for: .normal)
            botMethodButton.setImage(UIImage(named: "boil"), for: .normal)
            
            topMethod = "pan"
            midMethod = "oven"
            botMethod = "boil"
            
        } else if selectedProtein == "chicken" || selectedProtein == "fish" {
            
            topMethodButton.setImage(UIImage(named: "pan"), for: .normal)
            midMethodButton.setImage(UIImage(named: "oven"), for: .normal)
            botMethodButton.setImage(UIImage(named: "fryer"), for: .normal)
            
            topMethod = "pan"
            midMethod = "oven"
            botMethod = "fryer"
            
        } else {
            
            topMethodButton.isHidden = true
            midMethodButton.setImage(UIImage(named: "boil"), for: .normal)
            botMethodButton.isHidden = true
            
            topMethod = ""
            midMethod = "boil"
            botMethod = ""
        }
    }
}
