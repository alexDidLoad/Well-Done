//
//  ChoiceViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/15/20.
//

import UIKit

class ChoiceViewController: UIViewController {
    
    private var panMethodButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private var ovenMethodButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private var fryMethodButton: CustomButton = CustomButton(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
    private let label = UILabel()
    public var selectedProtein: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
        //hides fry method because you cant deep fry an egg and steak
        if selectedProtein == "steak" || selectedProtein == "egg" {
            fryMethodButton.isHidden = true
        }
        
    }
    
    //MARK: - Set View Method
    
    private func setView() {
        
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        label.text = "2. Select a method"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Ultralight", size: 30)
        label.numberOfLines = 0
        
        panMethodButton.setImage(UIImage(named: "pan"), for: .normal)
        panMethodButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 24)
        ovenMethodButton.setImage(UIImage(named: "oven"), for: .normal)
        ovenMethodButton.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        fryMethodButton.setImage(UIImage(named: "fryer"), for: .normal)
        fryMethodButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 12)
        
        panMethodButton.addTarget(self, action: #selector(self.panTap), for: .touchUpInside)
        ovenMethodButton.addTarget(self, action: #selector(self.ovenTap), for: .touchUpInside)
        fryMethodButton.addTarget(self, action: #selector(self.fryTap), for: .touchUpInside)
        
        view.addSubview(panMethodButton)
        view.addSubview(ovenMethodButton)
        view.addSubview(fryMethodButton)
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        panMethodButton.translatesAutoresizingMaskIntoConstraints = false
        ovenMethodButton.translatesAutoresizingMaskIntoConstraints = false
        fryMethodButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            panMethodButton.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            panMethodButton.widthAnchor.constraint(equalToConstant: 160),
            panMethodButton.heightAnchor.constraint(equalToConstant: 160),
            panMethodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ovenMethodButton.topAnchor.constraint(lessThanOrEqualTo: panMethodButton.bottomAnchor, constant: 30),
            ovenMethodButton.heightAnchor.constraint(equalToConstant: 160),
            ovenMethodButton.widthAnchor.constraint(equalToConstant: 160),
            ovenMethodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fryMethodButton.topAnchor.constraint(equalTo: ovenMethodButton.bottomAnchor, constant: 30),
            fryMethodButton.heightAnchor.constraint(equalToConstant: 160),
            fryMethodButton.widthAnchor.constraint(equalToConstant: 160),
            fryMethodButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: fryMethodButton.bottomAnchor, constant: 30),
            label.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    //MARK: - Button methods
    
    @objc func panTap() {
        
        if let vc = storyboard?.instantiateViewController(identifier: "CookVC") as? CookViewController {
            vc.selectedMethod = "panFry"
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
        print("pan")
    }
    
    @objc func ovenTap() {
        if let vc = storyboard?.instantiateViewController(identifier: "CookVC") as? CookViewController {
            vc.selectedMethod = "bake"
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
        print("oven")
    }
    
    @objc func fryTap() {
        if let vc = storyboard?.instantiateViewController(identifier: "CookVC") as? CookViewController {
            vc.selectedMethod = "deepFry"
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true)
        }
        print("fry")
    }
}
