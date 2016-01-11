//
//  UXRecorder.swift
//  UXRecorder
//
//  Created by Cleber Henriques on 1/7/16.
//  Copyright © 2016 Cleber Henriques. All rights reserved.
//

import UIKit
import AVFoundation

public class ExperienceRecorder: NSObject {
    private let faceCaptureSession = AVCaptureSession()
    private let faceCaptureOutput = AVCaptureMovieFileOutput()
    private let faceCaptureOutputPath:  NSURL?
    private var faceCaptureDevice: AVCaptureDevice?
    private(set) var isRecording = false
    private let screenRecorder = ASScreenRecorder.sharedInstance()
    
    public static let sharedRecorder = ExperienceRecorder()
    
    
    override init(){
        faceCaptureSession.sessionPreset = AVCaptureSessionPreset352x288
        faceCaptureSession.addOutput(faceCaptureOutput)
        for device in AVCaptureDevice.devices() {
            if device.hasMediaType(AVMediaTypeVideo){
                if device.position == AVCaptureDevicePosition.Front {
                    faceCaptureDevice = device as? AVCaptureDevice
                }
            }
        }
        
        do {
           try faceCaptureSession.addInput(AVCaptureDeviceInput(device: faceCaptureDevice))
        } catch {
            print("Warning: Unable to add front camera as an device input in faceCaptureSession")
        }
        
        let pathToDocuments = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let faceCapturePath = pathToDocuments.stringByAppendingPathComponent("face.mov")
        faceCaptureOutputPath = NSURL(fileURLWithPath: faceCapturePath)
        faceCaptureSession.startRunning()
    }
    
    private func beginRecordingScreen(){
        screenRecorder.startRecording()
        print("Did begin recording screen")
    }
    
    private func stopRecordingScreen(){
        screenRecorder.stopRecordingWithCompletion { () -> Void in
            print("Did stop recording screen")
        }
    }
    
    private func beginRecordingFace(){
        faceCaptureOutput.startRecordingToOutputFileURL(faceCaptureOutputPath, recordingDelegate: self)
        print("Did begin recording face")
    }
    
    private func stopRecordingFace(){
        faceCaptureOutput.stopRecording()
        print("Did stop recording face")
    }

    public func beginRecordingUX() {
        if !isRecording {
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                self.beginRecordingScreen()
                self.beginRecordingFace()
            }
            isRecording = true
        }
    }
    
    
    public func stopRecordingUX() {
        if isRecording {
            self.stopRecordingScreen()
            self.stopRecordingFace()
            isRecording = false
        }
    }
}

extension ExperienceRecorder: AVCaptureFileOutputRecordingDelegate{
    public func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        
        if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(faceCaptureOutputPath!.path!) {
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                UISaveVideoAtPathToSavedPhotosAlbum(self.faceCaptureOutputPath!.path!, nil, nil, nil)
            }
        }
    }
    
    public func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {

    }
}