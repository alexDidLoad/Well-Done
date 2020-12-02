//
//  ViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit
import UserNotifications

//Set above class to allow all classes to have access to the protein properties
var protein = Protein()

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Select a Protein"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Light", size: 36)
        return label
    }()
    
    private let steakButton: CustomButton = {
        let button = CustomButton(imageName: "meat")
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.setDimensions(height: 150, width: 150)
        button.addTarget(self, action: #selector(steakButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let chickenButton: CustomButton = {
        let button = CustomButton(imageName: "chicken")
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.setDimensions(height: 150, width: 150)
        button.addTarget(self, action: #selector(chickenButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let fishButton: CustomButton = {
        let button = CustomButton(imageName: "fish")
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 35)
        button.setDimensions(height: 150, width: 150)
        button.addTarget(self, action: #selector(fishButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let eggButton: CustomButton = {
        let button = CustomButton(imageName: "egg")
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 35)
        button.setDimensions(height: 150, width: 150)
        button.addTarget(self, action: #selector(eggButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerForNotifications()
    }
    
    //MARK: - Selectors
    
    @objc func steakButtonPressed() {
        protein.type = "steak"
        let choiceVC = ChoiceViewController()
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(choiceVC, animated: true)
        steakButton.bounce()
    }
    
    @objc func chickenButtonPressed() {
        protein.type = "chicken"
        let choiceVC = ChoiceViewController()
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(choiceVC, animated: true)
        chickenButton.bounce()
    }
    
    @objc func fishButtonPressed() {
        protein.type = "fish"
        let choiceVC = ChoiceViewController()
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(choiceVC, animated: true)
        fishButton.bounce()
    }
    
    @objc func eggButtonPressed() {
        protein.type = "egg"
        let choiceVC = ChoiceViewController()
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(choiceVC, animated: true)
        eggButton.bounce()
    }
    
    //MARK: - UserNotification
    
    private func registerForNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if let error = error {
                print("DEBUG: Error in requesting authorization: \(error.localizedDescription)")
            }
            if granted {
                print("DEBUG: Notification Authorization was granted")
            } else {
                print("DEBUG: Notification Authorization was denied")
            }
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1)
        configureNavBar(withTitle: "Well Done", prefersLargeTitle: true)
        
        let topStack = UIStackView(arrangedSubviews: [steakButton, chickenButton])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        view.addSubview(topStack)
        topStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        paddingTop: 30,
                        paddingLeading: 20,
                        paddingTrailing: 20)
        
        let midStack = UIStackView(arrangedSubviews: [fishButton, eggButton])
        midStack.axis = .horizontal
        midStack.distribution = .equalSpacing
        view.addSubview(midStack)
        midStack.anchor(top: topStack.bottomAnchor,
                        leading: view.leadingAnchor,
                        trailing: view.trailingAnchor,
                        paddingTop: 50,
                        paddingLeading: 20,
                        paddingTrailing: 20)
        
        view.addSubview(label)
        label.anchor(top: midStack.bottomAnchor,
                     leading: view.leadingAnchor,
                     trailing: view.trailingAnchor,
                     paddingTop: 100)
        
    }
    
}
