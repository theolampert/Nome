import Foundation
import MediaPlayer
import AVFoundation

public typealias BPM = Double

@available(macOS 10.11, *)
public class Nome {
    var currentMusicSequence: MusicSequence?
    var pauseOnAppExit = false
    
    public var audioEngine = AudioEngine()
    public let soundBank = SoundBank.bank
    
    public init() { }
    
    public func start() throws {
        let musicSequence = musicSequenceForMetre(metre, sound: soundSample, emphasisEnabled: emphasisEnabled)
        try start(withSequence: musicSequence)
    }
        
    func start(withSequence musicSequence: MusicSequence) throws {
        self.currentMusicSequence = musicSequence
        try audioEngine.playMusicSequence(musicSequence)
    }
    
    public func stop() {
        audioEngine.stopMusicSequence()
    }
    
    public var isPlaying: Bool {
        return audioEngine.isPlaying
    }
    
    var metre: Metre? {
        didSet {
            let newMusicSequence = musicSequenceForMetre(metre, sound: soundSample, emphasisEnabled: emphasisEnabled)
            try! reloadSequenceAndPlayIfWasPlayingBefore(newMusicSequence)
        }
    }
    
    var emphasisEnabled: Bool? {
        didSet {
            let newMusicSequence = musicSequenceForMetre(metre, sound: soundSample, emphasisEnabled: emphasisEnabled)
            try! reloadSequenceAndPlayIfWasPlayingBefore(newMusicSequence)
        }
    }
    
    public var soundSample: Sample? {
        didSet {
            let newMusicSequence = musicSequenceForMetre(metre, sound: soundSample, emphasisEnabled: emphasisEnabled)
            try! reloadSequenceAndPlayIfWasPlayingBefore(newMusicSequence)
        }
    }
    
    public var tempo: BPM? {
        didSet {
            if let tempo = tempo {
                let playbackRate = tempo / SequenceComposer.defaultTempoForQuaterNote
                self.audioEngine.playbackRate = playbackRate
            }
        }
    }
    
    func reloadSequenceAndPlayIfWasPlayingBefore(_ musicSequence: MusicSequence) throws {
        let wasPlaying = self.isPlaying
        
        if wasPlaying {
            stop()
            try start(withSequence: musicSequence)
        }
    }
    
    func musicSequenceForMetre(_ metre: Metre?, sound: Sample?, emphasisEnabled: Bool?) -> MusicSequence {
        let metre = metre ?? Metre.fourByFour()
        let soundSample = sound ?? .Beep
        let emphasisEnabled = emphasisEnabled ?? true
        
        return SequenceComposer.prepareSequenceForMetre(metre, soundSample: soundSample.sample, emphasisEnabled: emphasisEnabled)
    }
}
