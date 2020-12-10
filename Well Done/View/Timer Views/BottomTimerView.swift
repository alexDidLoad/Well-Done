//
//  BottomTimerView.swift
//  Well Done
//
//  Created by Alexander Ha on 12/8/20.
//

import UIKit
import AVFoundation

protocol BottomTimerViewDelegate: class {
    func handlePlay()
    func handleReset()
    func handlePause()
    func handleCancel()
}

class BottomTimerView: UIView {
    
    //MARK: - UI Components
    private let playButton: CustomTimerButton = {
        let button = CustomTimerButton(withImage: "play.circle.fill", isHidden: false)
        button.setDimensions(height: 60, width: 60)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        return button
    }()
    
    private let pauseButton: CustomTimerButton = {
        let button = CustomTimerButton(withImage: "pause.circle", isHidden: true)
        button.setDimensions(height: 60, width: 60)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESET", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 16)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(animateTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    //MARK: - Properties
    weak var delegate: BottomTimerViewDelegate?
    
    private var soundEffect: AVAudioPlayer!
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handlePlay(button: UIButton) {
        delegate?.handlePlay()
        playButton.isHidden = true
        pauseButton.isHidden = false
        buttonSoundEffect()
        button.liftUp()
    }
    
    @objc func handleReset(button: UIButton) {
        delegate?.handleReset()
        pauseButton.isHidden = true
        playButton.isHidden = false
        button.liftUp()
    }
    
    @objc func handlePause(button: UIButton) {
        delegate?.handlePause()
        playButton.isHidden = false
        pauseButton.isHidden = true
        buttonSoundEffect()
        button.liftUp()
    }
    
    @objc func handleCancel(button: UIButton) {
        delegate?.handleCancel()
        button.liftUp()
    }
    
    @objc func animateTouchDown(button: UIButton) {
        button.pushDown()
    }
    
    //MARK: - Helpers
    
    private func buttonSoundEffect() {
        guard let url = Bundle.main.url(forResource: "buttonTock", withExtension: ".mp3") else { return }
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            soundEffect.play()
        } catch {
            print("DEBUG: Failed to play sound effect: \(error.localizedDescription)")
        }
    }
    
    private func configureUI() {
        
        backgroundColor = #colorLiteral(red: 0.9384854436, green: 0.4436456263, blue: 0.4033697844, alpha: 1)
        setDimensions(height: 1000, width: 1000)
        layer.cornerRadius = 1000 / 2
        
        let stack = UIStackView(arrangedSubviews: [playButton, pauseButton])
        stack.axis = .vertical
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: self.topAnchor, paddingTop: 20)
        
        addSubview(resetButton)
        resetButton.setHeight(height: 28)
        resetButton.anchor(top: stack.bottomAnchor,
                           leading: stack.trailingAnchor,
                           paddingTop: 5,
                           paddingLeading: 85)
        
        addSubview(cancelButton)
        cancelButton.setHeight(height: 28)
        cancelButton.anchor(top: stack.bottomAnchor,
                            trailing: stack.leadingAnchor,
                            paddingTop: 5,
                            paddingTrailing: 75)
        
    }
}
