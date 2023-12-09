//
//  ViewController.swift
//  HomeworkPanGestureRecognizer
//
//  Created by Иван Знак on 03/12/2023.
//

import UIKit

class ViewController: UIViewController {

    var staticView: UIView!
    var movingView: UIView!
    var resetButton: UIButton!
    var pointCheckStatus = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        staticView = UIView(frame: CGRect(x: view.center.x , y: view.frame.maxY - 200, width: 100, height: 100))
        
        staticView.backgroundColor = UIColor.blue
        view.addSubview(staticView)

        movingView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        movingView.backgroundColor = UIColor.red
        view.addSubview(movingView)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        movingView.addGestureRecognizer(panGesture)
        
        resetButton = UIButton(type: .system)
        resetButton.setTitle("", for: .normal)
        resetButton.frame = CGRect(x: view.center.x/2, y: view.center.y, width: 200, height: 40)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        view.addSubview(resetButton)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if pointCheckStatus == 0 {
            movingView.center = CGPoint(x: movingView.center.x + translation.x, y: movingView.center.y + translation.y)
            gesture.setTranslation(.zero, in: view)
            
            if staticView.frame.intersects(movingView.frame) {
                stopMovingView()
            }
        }
    }

    func stopMovingView() {
        movingView.layer.removeAllAnimations()
        resetButton.setTitle("Start again", for: .normal)
        pointCheckStatus = 1
    }

    @objc func resetButtonTapped() {
        staticView.frame = CGRect(x: view.center.x , y: view.frame.maxY - 200, width: 100, height: 100)
        movingView.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        pointCheckStatus = 0
        resetButton.setTitle("", for: .normal)
    }
}
