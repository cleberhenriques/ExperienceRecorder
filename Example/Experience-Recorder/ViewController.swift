//
//  ViewController.swift
//  Experience-Recorder
//
//  Created by Cleber Henriques on 01/11/2016.
//  Copyright (c) 2016 Cleber Henriques. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = randomColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    
    func randomColor() -> UIColor{
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
    }

    // MARK: Actions

    @IBAction func stopTouched(sender: AnyObject) {
        
    }
}

