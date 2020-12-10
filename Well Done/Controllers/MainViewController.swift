//
//  ViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController {
    
    //MARK: - UI Components
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Select Protein"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "SFProText-Medium", size: 36)
        return label
    }()
    
    let proteinButtons = ProteinButtonView()
    let methodButtons = MethodButtonView()
    let donenessButtons = DonenessButtonView()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavBar(withTitle: "Well Done", prefersLargeTitle: true)
        registerForNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
      
        proteinButtons.alpha = 1
        methodButtons.alpha = 1
        donenessButtons.alpha = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        methodButtons.resetMethodButtons()
        donenessButtons.resetDoneButtons()
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
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9925742745, green: 0.9858585, blue: 0.8622567654, alpha: 1)

        donenessButtons.delegate = self
        donenessButtons.setDimensions(height: view.frame.height / 2,
                                      width: view.frame.width)
        view.addSubview(donenessButtons)
        donenessButtons.centerX(inView: view)
        donenessButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        methodButtons.delegate = self
        methodButtons.setDimensions(height: view.frame.height / 2,
                                    width: view.frame.width)
        view.addSubview(methodButtons)
        methodButtons.centerX(inView: view)
        methodButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        proteinButtons.delegate = self
        proteinButtons.setDimensions(height: view.frame.height / 2,
                                     width: view.frame.width)
        view.addSubview(proteinButtons)
        proteinButtons.centerX(inView: view)
        proteinButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        let bottomView = configureBottomView()
        view.addSubview(bottomView)
        bottomView.anchor(top: view.centerYAnchor,
                          paddingTop: 150)
        bottomView.centerX(inView: view)
        
        bottomView.addSubview(label)
        label.centerX(inView: bottomView)
        label.anchor(top: bottomView.topAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     paddingTop: 50)
    }
}
//MARK: - ProteinButtonViewDelegate

extension MainViewController: ProteinButtonViewDelegate {
    
    func handleProteinSelected() {
        view.fade(out: proteinButtons)
        methodButtons.animateInMethods()
        label.text = "Select Method"
    }
}
//MARK: - MethodButtonViewDelegate

extension MainViewController: MethodButtonViewDelegate {
    
    func handleMethodSelected() {
        view.fade(out: methodButtons)
        donenessButtons.animateInDoneness()
        label.text = "Select Doneness"
    }
}
//MARK: - DonenessButtonViewDelegate

extension MainViewController: DonenessButtonViewDelegate {
    
    func handleDonenessSelected() {
        pushTo(viewController: TimerViewController(),
               withProtein: PROTEIN.type,
               withCookMethod: PROTEIN.method,
               withDoneness: PROTEIN.doneness)
        label.text = "Select Protein"
    }
}
