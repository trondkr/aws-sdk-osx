// Software License Agreement (BSD License)
//
// Copyright (c) 2014-2016, Deusty, LLC
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Neither the name of Deusty nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission of Deusty, LLC.

import Foundation

extension AWSDDLogFlag {
    public static func from(_ logLevel: AWSDDLogLevel) -> AWSDDLogFlag {
        return AWSDDLogFlag(rawValue: logLevel.rawValue)
    }
	
	public init(_ logLevel: AWSDDLogLevel) {
        self = AWSDDLogFlag(rawValue: logLevel.rawValue)
	}
    
    ///returns the log level, or the lowest equivalant.
    public func toLogLevel() -> AWSDDLogLevel {
        if let ourValid = AWSDDLogLevel(rawValue: rawValue) {
            return ourValid
        } else {
            if contains(.verbose) {
                return .verbose
            } else if contains(.debug) {
                return .debug
            } else if contains(.info) {
                return .info
            } else if contains(.warning) {
                return .warning
            } else if contains(.error) {
                return .error
            } else {
                return .off
            }
        }
    }
}

public var defaultDebugLevel = AWSDDLogLevel.verbose

public func resetDefaultDebugLevel() {
    defaultDebugLevel = AWSDDLogLevel.verbose
}

public func _AWSDDLogMessage(_ message: @autoclosure () -> String, level: AWSDDLogLevel, flag: AWSDDLogFlag, context: Int, file: StaticString, function: StaticString, line: UInt, tag: Any?, asynchronous: Bool, AWSDDlog: AWSDDLog) {
    if level.rawValue & flag.rawValue != 0 {
        // Tell the AWSDDLogMessage constructor to copy the C strings that get passed to it.
        let logMessage = AWSDDLogMessage(message: message(), level: level, flag: flag, context: context, file: String(describing: file), function: String(describing: function), line: line, tag: tag, options: [.copyFile, .copyFunction], timestamp: nil)
        AWSDDlog.log(asynchronous: asynchronous, message: logMessage)
    }
}

public func AWSDDLogDebug(_ message: @autoclosure () -> String, level: AWSDDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = true, AWSDDlog: AWSDDLog = AWSDDLog.sharedInstance) {
    _AWSDDLogMessage(message(), level: level, flag: .debug, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, AWSDDlog: AWSDDlog)
}

public func AWSDDLogInfo(_ message: @autoclosure () -> String, level: AWSDDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = true, AWSDDlog: AWSDDLog = AWSDDLog.sharedInstance) {
    _AWSDDLogMessage(message(), level: level, flag: .info, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, AWSDDlog: AWSDDlog)
}

public func AWSDDLogWarn(_ message: @autoclosure () -> String, level: AWSDDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = true, AWSDDlog: AWSDDLog = AWSDDLog.sharedInstance) {
    _AWSDDLogMessage(message(), level: level, flag: .warning, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, AWSDDlog: AWSDDlog)
}

public func AWSDDLogVerbose(_ message: @autoclosure () -> String, level: AWSDDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = true, AWSDDlog: AWSDDLog = AWSDDLog.sharedInstance) {
    _AWSDDLogMessage(message(), level: level, flag: .verbose, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, AWSDDlog: AWSDDlog)
}

public func AWSDDLogError(_ message: @autoclosure () -> String, level: AWSDDLogLevel = defaultDebugLevel, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = false, AWSDDlog: AWSDDLog = AWSDDLog.sharedInstance) {
    _AWSDDLogMessage(message(), level: level, flag: .error, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, AWSDDlog: AWSDDlog)
}

/// Returns a String of the current filename, without full path or extension.
///
/// Analogous to the C preprocessor macro `THIS_FILE`.
public func CurrentFileName(_ fileName: StaticString = #file) -> String {
    var str = String(describing: fileName)
    if let idx = str.range(of: "/", options: .backwards)?.upperBound {
        str = String(str[idx...])
    }
    if let idx = str.range(of: ".", options: .backwards)?.lowerBound {
        str = String(str[..<idx])
    }
    return str
}
