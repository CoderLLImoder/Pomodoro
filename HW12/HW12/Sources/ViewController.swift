//
//  ViewController.swift
//  HW12
//
//  Created by Илья Капёрский on 11.08.2023.
//

import UIKit

class ViewController: UIViewController {

    let currentColor = UIColor(named: "green")
    
    private lazy var timer: UILabel = {
        let timer = UILabel()
        timer.textColor = UIColor.yellow
        timer.font = UIFont(name: "Chalkduster", size: 52)
        timer.text = "00:00"
        timer.translatesAutoresizingMaskIntoConstraints = false
        return timer
    }()
    
    private lazy var ppButton: UIButton = {
        var ppButton = UIButton()
        ppButton.setTitle("", for: .normal)
        let playImg = UIImage(named: "play")?.withTintColor(UIColor.yellow, renderingMode: .alwaysOriginal)
        let pauseImg = UIImage(named: "pause")?.withTintColor(currentColor!, renderingMode: .alwaysOriginal)
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
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            ppButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ppButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            ppButton.widthAnchor.constraint(equalToConstant: 100),
            ppButton.heightAnchor.constraint(equalToConstant: 100),
            ])
    }
    
    private func setupHierarchy(){
        view.addSubview(timer)
        view.addSubview(ppButton)
    }

    private func setupMainView(){
        view.backgroundColor = UIColor(named: "bgColor")
    }
    
    @objc private func tapButton(){
        ppButton.isSelected = !ppButton.isSelected
        timer.textColor = ppButton.isSelected ? currentColor : UIColor.yellow
        
    }
}

