//
//  ViewController.swift
//  Experience-Recorder
//
//  Created by Cleber Henriques on 01/11/2016.
//  Copyright (c) 2016 Cleber Henriques. All rights reserved.
//

import UIKit
import ExperienceRecorder

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = randomColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        startRecording()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    
    func randomColor() -> UIColor{
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        
    }
    
    func startRecording(){
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            simulatorMessage()
        #else
            ExperienceRecorder.sharedRecorder.startRecordingUX()
        #endif
    }
    
    func simulatorMessage(){
        let alert = UIAlertController(title: "Simulator", message: "You can not use ExperienceRecorder in Simulator.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }

    // MARK: Actions

    @IBAction func stopTouched(sender: AnyObject) {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            simulatorMessage()
        #else
            ExperienceRecorder.sharedRecorder.stopRecordingUX()
        #endif
    }
}

