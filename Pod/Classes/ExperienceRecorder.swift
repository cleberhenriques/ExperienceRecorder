//
//  UXRecorder.swift
//  UXRecorder
//
//  Created by Cleber Henriques on 1/7/16.
//  Copyright © 2016 Cleber Henriques. All rights reserved.
//

import UIKit
import AVFoundation

public enum Folder {
    case CameraRoll
    case CustomPath(path:NSURL)
}

public class ExperienceRecorder: NSObject {
    private let faceCaptureSession = AVCaptureSession()
    private let faceCaptureOutput = AVCaptureMovieFileOutput()
    private var faceCaptureOutputPath:  NSURL?
    private var faceCaptureDevice: AVCaptureDevice?
    private(set) var isRecording = false
    private let screenRecorder = ASScreenRecorder.sharedInstance()
    
    public static let sharedRecorder = ExperienceRecorder()
    
    public var debug = false
    public var screenRecorderFolder = Folder.CameraRoll
    public var faceRecorderFolder = Folder.CameraRoll
    
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
        
        faceCaptureSession.startRunning()
    }
    
    private func beginRecordingScreen(){
        
        switch screenRecorderFolder {
        case .CameraRoll:
            screenRecorder.videoURL = nil
        case .CustomPath(let url):
            screenRecorder.videoURL = url
        }
        
        screenRecorder.startRecording()
        
        if debug {
            print("Did begin recording screen")
        }
    }
    
    private func stopRecordingScreen(){
        screenRecorder.stopRecordingWithCompletion { () -> Void in
            
            if self.debug {
                print("Did stop recording screen")
            }
        }
    }
    
    private func beginRecordingFace(){
        
        switch faceRecorderFolder {
        case .CameraRoll:
            faceCaptureOutputPath = ExperienceRecorder.defaultPath(withFileName: "face.mov")
        case .CustomPath(let url):
            faceCaptureOutputPath = url
        }
        
        faceCaptureOutput.startRecordingToOutputFileURL(faceCaptureOutputPath, recordingDelegate: self)
        
        if debug {
            print("Did begin recording face")
        }
    }
    
    private func stopRecordingFace(){
        faceCaptureOutput.stopRecording()
        
        if debug {
            print("Did stop recording face")
        }
    }
    
    private func moveFaceVideoToCameraRoll(){
        if let path = faceCaptureOutputPath?.path where NSFileManager.defaultManager().fileExistsAtPath(path){
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, "video:didFinishSavingWithError:contextInfo:", nil)
            }
        }
    }
    
    public func video(videoPath: String, didFinishSavingWithError error: NSError, contextInfo info: UnsafeMutablePointer<Void>) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let fileManager = NSFileManager.defaultManager()
            
            if let path = self.faceCaptureOutputPath?.path where fileManager.fileExistsAtPath(path){
                do {
                    try fileManager.removeItemAtPath(path)
                } catch {
                    if self.debug {
                        print("Could not remove file at current path")
                    }
                }
            }
        }
    }
    
    static private func defaultPath(withFileName fileName: String) -> NSURL {
        let pathToDocuments = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let faceCapturePath = pathToDocuments.stringByAppendingPathComponent(fileName)
        return NSURL(fileURLWithPath: faceCapturePath)
    }
    
    // MARK: Methods

    @available(*, deprecated=0.1.3, message="You should use 'startRecordingUX' instead.") public func beginRecordingUX() {
        startRecordingUX()
    }
    
    public func startRecordingUX() {
        if !isRecording {
            self.beginRecordingScreen()
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
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
        
        switch faceRecorderFolder {
        case .CameraRoll:
            moveFaceVideoToCameraRoll()
        case .CustomPath:
            break
        }
        
    }
    
    public func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {

    }
}
