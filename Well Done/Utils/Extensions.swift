//
//  Extensions.swift
//  Well Done
//
//  Created by Alexander Ha on 11/29/20.
//

import UIKit

//MARK: - UIView Extension

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeading: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingTrailing: CGFloat = 0,
                height: CGFloat? = nil,
                width: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingTrailing).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView, leadingAnchor: NSLayoutXAxisAnchor? = nil, paddingLeading: CGFloat = 0, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let leading = leadingAnchor {
            anchor(leading: leading, paddingLeading: paddingLeading)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    
    /// Button pressed animation
    func bounce() {
        UIView.animate(withDuration: 0.09) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.09) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
    
}

//MARK: - UIViewController Extension

extension UIViewController {
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1).cgColor, #colorLiteral(red: 0.96853441, green: 1, blue: 0.9685121179, alpha: 1).cgColor]
        //sets the two points at the top to the bottom
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    func configureNavBar(withTitle title: String, prefersLargeTitle: Bool) {
        
        //Creating a constant with our customized settings
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                               .font: UIFont(name: "SFProText-Heavy", size: 35)!]
        appearance.backgroundColor = #colorLiteral(red: 0.305575788, green: 0.8039663434, blue: 0.7685286403, alpha: 1)
        
        //Sets all of the navigation bar's attributes to our constant 'appearance'
        navigationItem.title = title
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitle
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        
        //overrides status bar to be white (battery | wifi symbol | time)
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
    
    /// Pushes to next view controller
    /// - Parameters:
    ///   - viewController: The View controller that you'd like the current one to be pushed to.
    ///   - withProtein: Sets the protein.type property (optional)
    ///   - withCookMethod: Sets the protein.method property (optional)
    ///   - withDoneness: Sets the protein.doneness property (optional)
    ///   - button: allows for the current button to have the bounce() animation.
    func pushTo(viewController: UIViewController, withProtein: String? = "", withCookMethod: String? = "", withDoneness: String? = "",  button: UIButton) {
        guard let type = withProtein else { return }
        guard let method = withCookMethod else { return }
        guard let doneness = withDoneness else { return }
        
        let vc = viewController
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
        protein.type = type
        protein.method = method
        protein.doneness = doneness
        button.bounce()
    }
    
}


//MARK: - Time Interval Extension

extension TimeInterval {
    
    public var time: String {
        return String(format: "%02d:%02d", Int(self/60), Int(ceil(truncatingRemainder(dividingBy: 60))))
    }
    
}

