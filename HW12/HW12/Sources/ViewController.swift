//
//  ViewController.swift
//  HW12
//
//  Created by Илья Капёрский on 11.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var seconds = 0
    var timer = Timer()
    var workFlag = true
    
    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.textColor = UIColor(named: "green")
        timerLabel.font = UIFont(name: "Chalkduster", size: 52)
        timerLabel.text = "00:00"
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()
    
    private lazy var ppButton: UIButton = {
        var ppButton = UIButton()
        ppButton.setTitle("", for: .normal)
        let playImg = UIImage(named: "play")?.withTintColor(UIColor(named: "green")!, renderingMode: .alwaysOriginal)
        let pauseImg = UIImage(named: "pause")?.withTintColor(UIColor(named: "green")!, renderingMode: .alwaysOriginal)
        ppButton.setImage(playImg, for: .normal)
        ppButton.setImage(pauseImg, for: .selected)
        ppButton.backgroundColor = nil
        ppButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ppButton.translatesAutoresizingMaskIntoConstraints = false
        return ppButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupHierarchy()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            ppButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ppButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            ppButton.widthAnchor.constraint(equalToConstant: 100),
            ppButton.heightAnchor.constraint(equalToConstant: 100),
              
            ])
    }
    
    private func setupHierarchy(){
        view.addSubview(timerLabel)
        view.addSubview(ppButton)
    }

    private func setupMainView(){
        view.backgroundColor = UIColor(named: "bgColor")
        
    }
    
    @objc private func tapButton(){
        
        if (!ppButton.isSelected)
        {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.seconds += 1
                let minutes = self.seconds / 60
                let minutesStr = minutes < 10 ? "0\(String(minutes))" : String(minutes)
                var secondsStr = String(self.seconds - (minutes * 60))
                secondsStr = secondsStr.count < 2 ? "0\(secondsStr)" : secondsStr
                self.timerLabel.text = "\(minutesStr):\(secondsStr)"
                
                if (self.workFlag && self.seconds == 15) {
                    self.setInterfaceColor("pink")
                    self.workFlag = false
                    self.seconds = 0
                }
                
                if (!self.workFlag && self.seconds == 5) {
                    self.setInterfaceColor("green")
                    self.workFlag = true
                    self.seconds = 0
                }
            }
        }
        else
        {
            timer.invalidate()
        }
            
        
        ppButton.isSelected = !ppButton.isSelected
    }
    
    private func setInterfaceColor(_ newColor: String)
    {
        let playImg = UIImage(named: "play")?.withTintColor(UIColor(named: newColor)!, renderingMode: .alwaysOriginal)
        let pauseImg = UIImage(named: "pause")?.withTintColor(UIColor(named: newColor)!, renderingMode: .alwaysOriginal)
        ppButton.setImage(playImg, for: .normal)
        ppButton.setImage(pauseImg, for: .selected)
        timerLabel.textColor = UIColor(named: newColor)
        setupHierarchy()
        setupLayout()
    }
    
}

