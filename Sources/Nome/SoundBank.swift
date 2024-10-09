//
//  SoundBank.swift
//  
//
//  Created by Theo Lampert on 23.09.20.
//
import Foundation

public struct SoundSample: Equatable {
    public var name: String
    var normalMidiNote: UInt8
    var emphasedMidiNote: UInt8
}

public func ==(lhs: SoundSample, rhs: SoundSample) -> Bool {
    return lhs.name == rhs.name
        && lhs.normalMidiNote == rhs.normalMidiNote
        && lhs.emphasedMidiNote == lhs.emphasedMidiNote
}

public enum Sample {
    case RimShot
    case HiHat
    case Clock
    case CowBell
    case Beep
    case FingerSnap
    case Classic
    case Triangle
    case Woodstick1
    case Woodstick2
    case Tone1
    case Tone2

    public var sample: SoundSample {
        switch self {
        case .RimShot:
            return SoundSample(name: "Rimshot", normalMidiNote: 48, emphasedMidiNote: 49)
        case .HiHat:
            return SoundSample(name: "Hi-Hat", normalMidiNote: 50, emphasedMidiNote: 51)
        case .Clock:
            return SoundSample(name: "Old clock", normalMidiNote: 52, emphasedMidiNote: 53)
        case .CowBell:
            return SoundSample(name: "Cow bell", normalMidiNote: 54, emphasedMidiNote: 55)
        case .Beep:
            return SoundSample(name: "Beep", normalMidiNote: 56, emphasedMidiNote: 57)
        case .FingerSnap:
            return SoundSample(name: "Fingersnap", normalMidiNote: 58, emphasedMidiNote: 59)
        case .Classic:
            return SoundSample(name: "Clasic", normalMidiNote: 60, emphasedMidiNote: 61)
        case .Triangle:
            return SoundSample(name: "Triangle", normalMidiNote: 62, emphasedMidiNote: 63)
        case .Woodstick1:
            return SoundSample(name: "Woodstick 1", normalMidiNote: 64, emphasedMidiNote: 65)
        case .Woodstick2:
            return SoundSample(name: "Woodstick 2", normalMidiNote: 66, emphasedMidiNote: 67)
        case .Tone1:
            return SoundSample(name: "Tone 1", normalMidiNote: 68, emphasedMidiNote: 69)
        case .Tone2:
            return SoundSample(name: "Tone 2", normalMidiNote: 70, emphasedMidiNote: 71)
        }
    }
}

public struct SoundBank {
    public static let bank: [Sample] = [
        .RimShot,
        .HiHat,
        .Clock,
        .CowBell,
        .Beep,
        .FingerSnap,
        .Classic,
        .Triangle,
        .Woodstick1,
        .Woodstick2,
        .Tone1,
        .Tone2
    ]
}
