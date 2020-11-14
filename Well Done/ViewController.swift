//
//  ViewController.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet var steakButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        
    }
    
    
    func setView() {
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        setButtons()
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Baskerville-BoldItalic", size: 25)!,
            .foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.tabBarController?.title = "Well Done"
    }
    
    func setButtons() {
        
        steakButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        steakButton.layer.masksToBounds = true
        steakButton.layer.borderWidth = 3
        steakButton.layer.borderColor = UIColor.black.cgColor
        steakButton.layer.cornerRadius = 0.5 * steakButton.frame.size.width
        steakButton.imageView?.contentMode = .scaleAspectFit
        steakButton.setImage(UIImage(named: "meat"), for: .normal)
        steakButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        steakButton.backgroundColor = UIColor.white
        
        steakButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            steakButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            steakButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            steakButton.widthAnchor.constraint(equalToConstant: 150),
            steakButton.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @IBAction func steakButtonPressed(_ sender: UIButton) {
        
        print("hi")
    }
    
    
}





