//
//  CustomButton.swift
//  Well Done
//
//  Created by Alexander Ha on 11/14/20.
//

import UIKit

class CustomButton: UIButton {

    private let myImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let viewModel: MyCustomButtonViewModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: MyCustomButtonViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addSubViews()
        configure(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        guard myImage.isDescendant(of: self) else { return }
        addSubview(myImage)
    }
    
    public func configure(with viewModel: MyCustomButtonViewModel) {
        
        layer.masksToBounds = true
        self.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        layer.cornerRadius = 0.5 * self.bounds.size.width
        layer.borderWidth = 3
        layer.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1).withAlphaComponent(0.8).cgColor
        layer.borderColor = UIColor.black.cgColor
        
        addSubview(myImage)
        
        myImage.image = UIImage(named: viewModel.imageName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImage.frame = CGRect(x: 10, y: 15, width: 125, height: 125)

    }
}

