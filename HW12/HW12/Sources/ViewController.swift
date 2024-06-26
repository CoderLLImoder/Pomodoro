//
//  ViewController.swift
//  HW12
//
//  Created by Илья Капёрский on 11.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var seconds = 1
    var timer = Timer()
    var workFlag = true
    var circularProgressBarView: CircularProgressBarView!
    var workInterval: TimeInterval = 15
    var relaxInterval: TimeInterval = 5
    
    private lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.textColor = UIColor(named: "golden")
        timerLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 52)
        timerLabel.text = "00:00"
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()
    
    private lazy var ppButton: UIButton = {
        var ppButton = UIButton()
        ppButton.setTitle("", for: .normal)
        let playImg = UIImage(named: "play")?.withTintColor(UIColor(named: "golden")!, renderingMode: .alwaysOriginal)
        let pauseImg = UIImage(named: "pause")?.withTintColor(UIColor(named: "golden")!, renderingMode: .alwaysOriginal)
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
        setUpCircularProgressBarView()
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
            if(workFlag) {
                self.circularProgressBarView.progressAnimation(duration: workInterval - Double(seconds - 1), fromValue: Double(seconds - 1) / Double(workInterval))
            }
            else {
                self.circularProgressBarView.progressAnimation(duration: relaxInterval - Double(seconds - 1), fromValue: Double(seconds - 1) / Double(relaxInterval))
            }
                
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                
                if (self.workFlag && self.seconds > 15) {
                    self.circularProgressBarView.progressAnimation(duration: self.relaxInterval, fromValue: 0.0)
                    self.seconds = 0
                    self.setInterfaceColor("silver")
                    self.workFlag = false
                }
                
                if (!self.workFlag && self.seconds > 5) {
                    self.circularProgressBarView.progressAnimation(duration: self.workInterval, fromValue: 0.0)
                    self.seconds = 0
                    self.setInterfaceColor("golden")
                    self.workFlag = true
                }
                

                let minutes = self.seconds / 60
                let minutesStr = minutes < 10 ? "0\(String(minutes))" : String(minutes)
                var secondsStr = String(self.seconds - (minutes * 60))
                secondsStr = secondsStr.count < 2 ? "0\(secondsStr)" : secondsStr
                self.timerLabel.text = "\(minutesStr):\(secondsStr)"
                self.seconds += 1
                }
            
        }
        else
        {
            timer.invalidate()
            self.circularProgressBarView.stopAnimation(fromValue: Double(seconds - 1) / Double(workFlag ? workInterval : relaxInterval))
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
        circularProgressBarView.setColor(newColor)
        setupHierarchy()
        setupLayout()
    }
       
   func setUpCircularProgressBarView() {
       // set view
       circularProgressBarView = CircularProgressBarView(frame: view.frame)
       // align to the center of the screen
       circularProgressBarView.center = view.center
       circularProgressBarView.createCircularPath()
       // add this view to the view controller
       view.addSubview(circularProgressBarView)
   }
}

