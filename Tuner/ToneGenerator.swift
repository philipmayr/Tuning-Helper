//
//  ToneGenerator.swift
//  ToneGeneratorSwift
//
//  Created by Andy Cho on 10/10/22.
//

import AudioUnit
import AVFoundation

class ToneGenerator: NSObject {
    private static let BytesPerFloat: UInt32 = 4
    private static let BitsPerByte: UInt32 = 8
    private static let SampleRate: Double = 44100
    private static var Amplitude: Double = 0.25
    private static var FadeIn: Bool = true
    private static var FadeOut: Bool = false
    private static let MonotoneChannel = 0
    
    private var audioComponentInstance: AudioComponentInstance?
    private var theta: Double = 0

    // MARK: Public APIs

    /**
     * This is the frequency actually being changed
     * Set this to play a different frequency
     */
    public var frequency: Double = 0

    /**
     * Start playing the tone at the frequency if not already playing
     */
    
    public var isPlaying: Bool = false
    
    func play() {
        if audioComponentInstance == nil {
            audioComponentInstance = createAudioUnit()
            guard let audioComponentInstance else {
                print("Audio component could not be created")
                return
            }
            
            // This starts the sound
            
            if isPlaying {
                let factor = UInt32(ToneGenerator.Amplitude / 0.25)
                usleep(670000 * factor + 330000)
            } else
            {
                ToneGenerator.Amplitude = 0.001
            }
                
            ToneGenerator.FadeOut = false
            ToneGenerator.FadeIn = true
            AudioUnitInitialize(audioComponentInstance)
            AudioOutputUnitStart(audioComponentInstance)
            isPlaying.toggle()
        }
    }
    
    /**
     * Stop playing the tone if currently playing
     */
    func stop() {
        //NSObject.cancelPreviousPerformRequests(withTarget: self)

        guard let audioComponentInstance else {
            return
        }
        
        ToneGenerator.FadeIn.toggle()
        ToneGenerator.FadeOut.toggle()
        
//        while ToneGenerator.Amplitude > 0.0 {
//            ToneGenerator.Amplitude -= 0.00000001
//        }
        
        let factor = UInt32(ToneGenerator.Amplitude / 0.25)
        usleep(670000 * factor + 330000)
        AudioOutputUnitStop(audioComponentInstance)
        AudioUnitUninitialize(audioComponentInstance)
        AudioComponentInstanceDispose(audioComponentInstance)
        self.audioComponentInstance = nil
        ToneGenerator.Amplitude = 0.001
        ToneGenerator.FadeOut.toggle()
        //perform(#selector(hush), with: nil, afterDelay: 0.5)
        isPlaying.toggle()
    }
    
//    @objc func hush() {
//        AudioOutputUnitStop(audioComponentInstance!)
//        AudioUnitUninitialize(audioComponentInstance!)
//        AudioComponentInstanceDispose(audioComponentInstance!)
//        self.audioComponentInstance = nil
//    }
    
    // MARK: Private helpers

    // This is equivalent to RenderTone in the original example
    private static func RenderToneCallback(
        inRefCon: UnsafeMutableRawPointer,
        ioActionFlags: UnsafeMutablePointer<AudioUnitRenderActionFlags>,
        inTimeStamp: UnsafePointer<AudioTimeStamp>,
        inBusNumber: UInt32,
        inNumberFrames: UInt32,
        ioData: UnsafeMutablePointer<AudioBufferList>?) -> OSStatus {

        // Get the tone parameters
        let toneGenerator = unsafeBitCast(inRefCon, to: ToneGenerator.self)
        var theta = toneGenerator.theta
        let thetaIncrement = 2.0 * Double.pi * toneGenerator.frequency / ToneGenerator.SampleRate

        // This is a mono tone generator so we only need the first buffer
        guard let ioPtr = UnsafeMutableAudioBufferListPointer(ioData),
              let monotoneChannel = ioPtr[ToneGenerator.MonotoneChannel].mData else {
            fatalError("Could not access the monotone channel in the passed in buffer")
        }
        let buffer = monotoneChannel.assumingMemoryBound(to: Float.self)
            
        if FadeIn && Amplitude < 0.25 {
//            Amplitude += 0.001
            Amplitude += (log(Amplitude) + 7) / 1000
        }
        if FadeOut && Amplitude > 0.001 {
//            Amplitude -= 0.001
            Amplitude -= (log(Amplitude) + 7) / 1000
            if Amplitude < 0.001 {
                Amplitude = 0.001
            }
        }
         
        for frame in 0 ..< inNumberFrames {
            buffer[Int(frame)] = Float(sin(theta) * (Amplitude))
            theta += thetaIncrement
            if theta > 2.0 * Double.pi {
                theta -= 2.0 * Double.pi
            }
        }
            
        // Store the updated theta
        toneGenerator.theta = theta

        return noErr
    }

    private func createAudioUnit() -> AudioComponentInstance? {
        // Configure the search parameters to find the default playback output unit
        // (called the kAudioUnitSubType_RemoteIO on iOS but
        // kAudioUnitSubType_DefaultOutput on Mac OS X)
        var audioComponentDescription = AudioComponentDescription(componentType: kAudioUnitType_Output,
                                                                  componentSubType: kAudioUnitSubType_RemoteIO,
                                                                  componentManufacturer: kAudioUnitManufacturer_Apple,
                                                                  componentFlags: 0,
                                                                  componentFlagsMask: 0)

        // Get the default playback output unit
        guard let defaultOutput = AudioComponentFindNext(nil, &audioComponentDescription) else {
            assertionFailure("Can't find default output")
            return nil
        }

        // Create a new unit based on this that we'll use for output
        var toneUnit: AudioComponentInstance?
        guard AudioComponentInstanceNew(defaultOutput, &toneUnit) == noErr, let toneUnit else {
            assertionFailure("Could not create AudioComponentInstance")
            return nil
        }

        // Set our tone rendering function on the unit
        var renderCallback = AURenderCallbackStruct(inputProc: { (inRefCon,
                                                                  ioActionFlags,
                                                                  inTimeStamp,
                                                                  inBusNumber,
                                                                  inNumberFrames,
                                                                  ioData) -> OSStatus in
            return ToneGenerator.RenderToneCallback(
                inRefCon: inRefCon,
                ioActionFlags: ioActionFlags,
                inTimeStamp: inTimeStamp,
                inBusNumber: inBusNumber,
                inNumberFrames: inNumberFrames,
                ioData: ioData)
        }, inputProcRefCon: Unmanaged.passUnretained(self).toOpaque())

        if AudioUnitSetProperty(toneUnit,
                                kAudioUnitProperty_SetRenderCallback,
                                kAudioUnitScope_Input,
                                0 /* inElement */,
                                &renderCallback,
                                UInt32(MemoryLayout.size(ofValue: renderCallback))) != noErr {
            assertionFailure("Could not set the callback")
            return nil
        }

        // Set the format to 32 bit, single channel, floating point, linear PCM
        var streamFormat = AudioStreamBasicDescription()
        streamFormat.mSampleRate = ToneGenerator.SampleRate
        streamFormat.mFormatID = kAudioFormatLinearPCM
        streamFormat.mFormatFlags = kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved
        streamFormat.mBytesPerPacket = ToneGenerator.BytesPerFloat
        streamFormat.mFramesPerPacket = 1
        streamFormat.mBytesPerFrame = ToneGenerator.BytesPerFloat
        streamFormat.mChannelsPerFrame = 1
        streamFormat.mBitsPerChannel = ToneGenerator.BytesPerFloat * ToneGenerator.BitsPerByte

        if AudioUnitSetProperty(toneUnit,
                                kAudioUnitProperty_StreamFormat,
                                kAudioUnitScope_Input,
                                0 /* inElement */,
                                &streamFormat,
                                UInt32(MemoryLayout.size(ofValue: streamFormat))) != noErr {
            assertionFailure("Could not set the callback")
            return nil
        }

        return toneUnit
    }
}
