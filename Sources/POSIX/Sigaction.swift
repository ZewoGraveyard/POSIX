//
//  Sigaction.swift
//  Zewo
//
//  Created by Ronaldo Faria Lima on 12/01/17.
//
//

#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import CPOSIX

/// This enumaration declares all signals according to header file signal.h,
/// exposing them to swift
/// - seealso: sys/signal.h on Darwin platforms
public enum SignalType : Int32 {
    /// Hangup
    case hup = 1
    /// Interrupt
    case int    = 2
    /// Quit
    case quit   = 3
    /// Illegal instruction
    case ill    = 4
    /// Trace trap
    case trap   = 5
    /// Abort
    case abrt   = 6
    /// Pollable event
    case poll   = 7
    /// Floating point exception
    case fpe    = 8
    /// Kill - cannot be caught or ignored
    case kill   = 9
    /// Bus error
    case bus    = 10
    /// Segmentation violation
    case segv   = 11
    /// Bad argument to system call
    case sys    = 12
    /// Write on a pipe with no one to read it
    case pipe   = 13
    /// Alarm clock
    case alrm   = 14
    /// Software termination signal from kill
    case term   = 15
    /// Urgent condition on IO channel
    case urg    = 16
    /// Sendable stop signal not from TTY
    case stop   = 17
    /// Stop signal from TTY
    case stp    = 18
    /// Continue a stopped process
    case cont   = 19
    /// To parent, on child stop or exit
    case chld   = 20
    /// To readers pgrp upon background tty read
    case ttin   = 21
    /// Like TTIN for output
    case ttou   = 22
    /// Input/output possible signal
    case io     = 23
    /// Exceeded CPU time limit
    case xcpu   = 24
    /// Exceeded file size limit
    case xfsz   = 25
    /// Virtual time alarm
    case vtalrm = 26
    /// Profiling time alarm
    case prof   = 27
    /// Window size changes
    case winch  = 28
    /// Information request
    case info   = 29
    /// User-defined signal 1
    case usr1   = 30
    /// User-defined signal 2
    case usr2   = 31
    /// Unknown or not supported signal
    case unknown
    
    /// Initializer that avoids failable initialization. If the raw value is not recognized,
    /// uses .unknown as default value.
    ///
    /// - Parameter rawValue: Signal number
    public init(rawValue: Int32) {
        switch rawValue {
        case  1: self = .hup;   case  2: self = .int;       case  3: self = .quit;  case  4: self = .ill;
        case  5: self = .trap   case  6: self = .abrt;      case  7: self = .poll;  case  8: self = .fpe;
        case  9: self = .kill;  case 10: self = .bus        case 11: self = .segv;  case 12: self = .sys;
        case 13: self = .pipe;  case 14: self = .alrm;      case 15: self = .term   case 16: self = .urg;
        case 17: self = .stop;  case 18: self = .stp;       case 19: self = .cont;  case 20: self = .chld
        case 21: self = .ttin;  case 22: self = .ttou;      case 23: self = .io;    case 24: self = .xcpu;
        case 25: self = .xfsz   case 26: self = .vtalrm;    case 27: self = .prof;  case 28: self = .winch;
        case 29: self = .info;  case 30: self = .usr1       case 31: self = .usr2
        default: self = .unknown
        }
    }
}

/// Defines the kind of action to take when a signal is delivered
public enum SignalAction : Int32 {
    /// Ignores the signal. Does nothing.
    case ignore = 0
    /// Use a default handler
    case useDefault = 1
    /// Let the delegate handle the signal.
    case handle = 2
}

public protocol SignalHandlerDelegate {
    mutating func handleSignal(signal: SignalType)
}

public typealias SignalResponder = (SignalType?)->Void

/// This class encapsulates all necessary functionality to handle signals sent by a given operating system.
/// - remarks: 
/// By design, this struct have only static methods. It was done that way because of the nature of signals: they
/// are delivered to the process, not to a given scope within the process. Also, sigaction system call is global
/// to the process. Therefore, it means that Signal structure must be a singleton. Since sigaction need a method
/// from a static structure, it was preferred to use only static methods and properties instead of sticking with
/// a normal singleton implementation.
public struct Signal {
    /// Delegate. It can respond to signal events.
    public static var delegate : SignalHandlerDelegate?
    
    /// Adjusts how a given signal will be handled when delivered to the process.
    /// - parameters:
    ///     - signal: Signal to add treatment to
    ///     - action: What to do when the signal is delivered.
    public static func setTrap(signal: SignalType, action: SignalAction) {
        guard signal != .unknown else {
            return
        }
        CPOSIXInstallSignalHandler(signal.rawValue, action.rawValue) { (signal) in
            Signal.handleSignal(signal: signal)
        }
    }
    
    /// Sends a signal to a given process
    ///
    /// - parameters:
    ///     - pid: The pid to send the signal to. Defaults to current process
    ///     - signal: What signal to send.
    public static func killPid(pid: pid_t = getpid(), signal: SignalType) {
        guard signal != .unknown else {
            return
        }
        kill(pid, signal.rawValue)
    }
    
    /// Signal handler. Wraps a call to the delegate, if available.
    /// - parameters:
    ///     - signal: Signal delivered to the process.
    static func handleSignal(signal: Int32) {
        guard Signal.delegate != nil else {
            return
        }
        Signal.delegate!.handleSignal(signal: SignalType(rawValue:signal))
    }
}
