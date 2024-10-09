//
//  Engine.swift
//  
//
//  Created by Theo Lampert on 23.09.20.
//

import Foundation
import AVFoundation

public class AudioEngine {
    private let audioEngine: AVAudioEngine
    private var sampler: AVAudioUnitSampler!
    public var sequencer: AVAudioSequencer!
    
    init() {
        audioEngine = AVAudioEngine()
        setupCoreAudioEngine(audioEngine)
        
        let url = Bundle.module.url(forResource: "metronome", withExtension: "aupreset")!
        try! sampler.loadInstrument(at: url)
        
        do {
            try audioEngine.start()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playMusicSequence(_ musicSequence: MusicSequence) throws {
        sequencer.currentPositionInBeats = 0
        
        var data: Unmanaged<CFData>?
        MusicSequenceFileCreateData(musicSequence, .midiType, .eraseFile, 480, &data)
        
        if let midiData = data?.takeRetainedValue() as Data? {
            try sequencer.load(from: midiData, options: AVMusicSequenceLoadOptions())
        }
        
        for track in sequencer.tracks {
            track.isLoopingEnabled = true
            track.numberOfLoops = AVMusicTrackLoopCount.forever.rawValue
        }
        
        try sequencer.start()
    }
    
    func stopMusicSequence() {
        sequencer.stop()
    }
    
    var isPlaying: Bool { return sequencer!.isPlaying }
    
    var playbackRate: Double {
        set {
            sequencer.rate = Float(newValue)
        }
        
        get {
            return Double(sequencer.rate)
        }
    }
    
    fileprivate func setupCoreAudioEngine(_ engine: AVAudioEngine) {
        let mixer = engine.mainMixerNode
        
        sampler = AVAudioUnitSampler()
        engine.attach(sampler)
        engine.connect(sampler, to: mixer, format: mixer.outputFormat(forBus: 0))
        
        sequencer = AVAudioSequencer(audioEngine: engine)
    }
}
