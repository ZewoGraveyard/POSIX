// OperatingSystem.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Zewo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(Linux)
    @_exported import Glibc
#else
    @_exported import Darwin.C
#endif

import C7

public enum SystemError: ErrorProtocol {
    
    case argumentListTooLong(description: String, data: Data)
    case permissionDenied(description: String, data: Data)
    case addressInUse(description: String, data: Data)
    case addressNotAvailable(description: String, data: Data)
    case addressFamiltyNotSupported(description: String, data: Data)
    case resourceUnavailable(description: String, data: Data)
    case connectionAlreadyInProgress(description: String, data: Data)
    case badFileDescriptor(description: String, data: Data)
    case badMessage(description: String, data: Data)
    case deviceOrResourceBusy(description: String, data: Data)
    case operationCancelled(description: String, data: Data)
    case noChildProcesses(description: String, data: Data)
    case connectionAborted(description: String, data: Data)
    case connectionRefused(description: String, data: Data)
    case connectionReset(description: String, data: Data)
    case resourceDeadlockWouldOccur(description: String, data: Data)
    case destinationAddressRequired(description: String, data: Data)
    case outOfFunctionDomain(description: String, data: Data)
    case fileExists(description: String, data: Data)
    case badAddress(description: String, data: Data)
    case fileTooLarge(description: String, data: Data)
    case hostIsUnreachable(description: String, data: Data)
    case identifierRemoved(description: String, data: Data)
    case illegalByteSequence(description: String, data: Data)
    case operationInfProgress(description: String, data: Data)
    case interruptedFunction(description: String, data: Data)
    case invalidArgument(description: String, data: Data)
    case inputOutputError(description: String, data: Data)
    case socketIsConnected(description: String, data: Data)
    case isDirectory(description: String, data: Data)
    case tooManyLevelsOfSymbolicLinks(description: String, data: Data)
    case tooManyOpenFiles(description: String, data: Data)
    case tooManyLinks(description: String, data: Data)
    case messageTooLarge(description: String, data: Data)
    case filenameTooLong(description: String, data: Data)
    case networkIsDown(description: String, data: Data)
    case connectionAbortedByNetwork(description: String, data: Data)
    case networkUnreachable(description: String, data: Data)
    case tooManyFilesOpenInSystem(description: String, data: Data)
    case noBufferSpaceAvailable(description: String, data: Data)
    case noSuchDevice(description: String, data: Data)
    case noSuchFileOrDirectory(description: String, data: Data)
    case executableFileFormatError(description: String, data: Data)
    case noLocksAvailable(description: String, data: Data)
    case notEnoughSpace(description: String, data: Data)
    case noMessageOfTheDesiredType(description: String, data: Data)
    case protocolNotAvailable(description: String, data: Data)
    case noSpaceLeftOnDevice(description: String, data: Data)
    case noMessageIsAvailableOnTheStreamHeadReadQueue(description: String, data: Data)
    case noStreamResources(description: String, data: Data)
    case notAStream(description: String, data: Data)
    case functionNotSupported(description: String, data: Data)
    case socketIsNotConnected(description: String, data: Data)
    case notADirectory(description: String, data: Data)
    case directoryNotEmpty(description: String, data: Data)
    case notASocket(description: String, data: Data)
    case notSupported(description: String, data: Data)
    case inappropriateInputOutputControlOperation(description: String, data: Data)
    case noSuchDeviceOrAddress(description: String, data: Data)
    case operationNotSupportedOnSocket(description: String, data: Data)
    case valueTooLargeToBeStoredInDataType(description: String, data: Data)
    case operationNotPermitted(description: String, data: Data)
    case brokenPipe(description: String, data: Data)
    case protocolError(description: String, data: Data)
    case protocolNotSupported(description: String, data: Data)
    case protocolWrongTypeForSocket(description: String, data: Data)
    case resultTooLarge(description: String, data: Data)
    case readOnlyFileSystem(description: String, data: Data)
    case invalidSeek(description: String, data: Data)
    case noSuchProcess(description: String, data: Data)
    case streamTimeout(description: String, data: Data)
    case connectionTimedOut(description: String, data: Data)
    case textFileBusy(description: String, data: Data)
    case operationWouldBlock(description: String, data: Data)
    case crossDeviceLink(description: String, data: Data)
    case other(description: String)

}

extension SystemError {
    
    public static func lastErrorDescription() -> String {
        return String(validatingUTF8: strerror(errno))!
    }
    
    public static func lastError(with data: Data) -> SystemError {
        switch errno {
        case E2BIG:             return .argumentListTooLong(description: lastErrorDescription(), data: data)
        case EACCES:            return .permissionDenied(description: lastErrorDescription(), data: data)
        case EADDRINUSE:        return .addressInUse(description: lastErrorDescription(), data: data)
        case EADDRNOTAVAIL:     return .addressNotAvailable(description: lastErrorDescription(), data: data)
        case EAFNOSUPPORT:      return .addressFamiltyNotSupported(description: lastErrorDescription(), data: data)
        case EAGAIN:            return .resourceUnavailable(description: lastErrorDescription(), data: data)
        case EALREADY:          return .connectionAlreadyInProgress(description: lastErrorDescription(), data: data)
        case EBADF:             return .badFileDescriptor(description: lastErrorDescription(), data: data)
        case EBADMSG:           return .badMessage(description: lastErrorDescription(), data: data)
        case EBUSY:             return .deviceOrResourceBusy(description: lastErrorDescription(), data: data)
        case ECANCELED:         return .operationCancelled(description: lastErrorDescription(), data: data)
        case ECHILD:            return .noChildProcesses(description: lastErrorDescription(), data: data)
        case ECONNABORTED:      return .connectionAborted(description: lastErrorDescription(), data: data)
        case ECONNREFUSED:      return .connectionRefused(description: lastErrorDescription(), data: data)
        case ECONNRESET:        return .connectionReset(description: lastErrorDescription(), data: data)
        case EDEADLK:           return .resourceDeadlockWouldOccur(description: lastErrorDescription(), data: data)
        case EDESTADDRREQ:      return .destinationAddressRequired(description: lastErrorDescription(), data: data)
        case EDOM:              return .outOfFunctionDomain(description: lastErrorDescription(), data: data)
        case EEXIST:            return .fileExists(description: lastErrorDescription(), data: data)
        case EFAULT:            return .badAddress(description: lastErrorDescription(), data: data)
        case EFBIG:             return .fileTooLarge(description: lastErrorDescription(), data: data)
        case EHOSTUNREACH:      return .hostIsUnreachable(description: lastErrorDescription(), data: data)
        case EIDRM:             return .identifierRemoved(description: lastErrorDescription(), data: data)
        case EILSEQ:            return .illegalByteSequence(description: lastErrorDescription(), data: data)
        case EINPROGRESS:       return .operationInfProgress(description: lastErrorDescription(), data: data)
        case EINTR:             return .interruptedFunction(description: lastErrorDescription(), data: data)
        case EINVAL:            return .invalidArgument(description: lastErrorDescription(), data: data)
        case EIO:               return .inputOutputError(description: lastErrorDescription(), data: data)
        case EISCONN:           return .socketIsConnected(description: lastErrorDescription(), data: data)
        case EISDIR:            return .isDirectory(description: lastErrorDescription(), data: data)
        case ELOOP:             return .tooManyLevelsOfSymbolicLinks(description: lastErrorDescription(), data: data)
        case EMFILE:            return .tooManyOpenFiles(description: lastErrorDescription(), data: data)
        case EMLINK:            return .tooManyLinks(description: lastErrorDescription(), data: data)
        case EMSGSIZE:          return .messageTooLarge(description: lastErrorDescription(), data: data)
        case ENAMETOOLONG:      return .filenameTooLong(description: lastErrorDescription(), data: data)
        case ENETDOWN:          return .networkIsDown(description: lastErrorDescription(), data: data)
        case ENETRESET:         return .connectionAbortedByNetwork(description: lastErrorDescription(), data: data)
        case ENETUNREACH:       return .networkUnreachable(description: lastErrorDescription(), data: data)
        case ENFILE:            return .tooManyFilesOpenInSystem(description: lastErrorDescription(), data: data)
        case ENOBUFS:           return .noBufferSpaceAvailable(description: lastErrorDescription(), data: data)
        case ENODATA:           return .noMessageIsAvailableOnTheStreamHeadReadQueue(description: lastErrorDescription(), data: data)
        case ENODEV:            return .noSuchDevice(description: lastErrorDescription(), data: data)
        case ENOENT:            return .noSuchFileOrDirectory(description: lastErrorDescription(), data: data)
        case ENOEXEC:           return .executableFileFormatError(description: lastErrorDescription(), data: data)
        case ENOLCK:            return .noLocksAvailable(description: lastErrorDescription(), data: data)
        case ENOMSG:            return .noMessageOfTheDesiredType(description: lastErrorDescription(), data: data)
        case ENOPROTOOPT:       return .protocolNotAvailable(description: lastErrorDescription(), data: data)
        case ENOSPC:            return .noSpaceLeftOnDevice(description: lastErrorDescription(), data: data)
        case ENOSR:             return .noStreamResources(description: lastErrorDescription(), data: data)
        case ENOSTR:            return .notAStream(description: lastErrorDescription(), data: data)
        case ENOSYS:            return .functionNotSupported(description: lastErrorDescription(), data: data)
        case ENOTCONN:          return .socketIsNotConnected(description: lastErrorDescription(), data: data)
        case ENOTDIR:           return .notADirectory(description: lastErrorDescription(), data: data)
        case ENOTEMPTY:         return .directoryNotEmpty(description: lastErrorDescription(), data: data)
        case ENOTSOCK:          return .notASocket(description: lastErrorDescription(), data: data)
        case ENOTSUP:           return .notSupported(description: lastErrorDescription(), data: data)
        case ENOTTY:            return .inappropriateInputOutputControlOperation(description: lastErrorDescription(), data: data)
        case ENXIO:             return .noSuchDeviceOrAddress(description: lastErrorDescription(), data: data)
        case EOPNOTSUPP:        return .operationNotSupportedOnSocket(description: lastErrorDescription(), data: data)
        case EOVERFLOW:         return .valueTooLargeToBeStoredInDataType(description: lastErrorDescription(), data: data)
        case EPERM:             return .operationNotPermitted(description: lastErrorDescription(), data: data)
        case EPIPE:             return .brokenPipe(description: lastErrorDescription(), data: data)
        case EPROTO:            return .protocolError(description: lastErrorDescription(), data: data)
        case EPROTONOSUPPORT:   return .protocolNotSupported(description: lastErrorDescription(), data: data)
        case EPROTOTYPE:        return .protocolWrongTypeForSocket(description: lastErrorDescription(), data: data)
        case ERANGE:            return .resultTooLarge(description: lastErrorDescription(), data: data)
        case ESPIPE:            return .invalidSeek(description: lastErrorDescription(), data: data)
        case ESRCH:             return .noSuchProcess(description: lastErrorDescription(), data: data)
        case ETIME:             return .streamTimeout(description: lastErrorDescription(), data: data)
        case ETIMEDOUT:         return .connectionTimedOut(description: lastErrorDescription(), data: data)
        case ETXTBSY:           return .textFileBusy(description: lastErrorDescription(), data: data)
        case EWOULDBLOCK:       return .operationWouldBlock(description: lastErrorDescription(), data: data)
        case EXDEV:             return .crossDeviceLink(description: lastErrorDescription(), data: data)
        default:                return .other(description: lastErrorDescription())
        }
    }
    
    public static func lastError() -> SystemError {
        return lastError(with: Data([]))
    }
    
    public static func lastReceiveError(with data: Data, bytesProcessed: Int) -> SystemError {
        let wdata = Data(data.prefix(upTo: bytesProcessed))
        return lastError(with: wdata)
    }
    
    public static func lastSendError(with data: Data, bytesProcessed: Int) -> SystemError {
        let wdata = Data(data.suffix(from: bytesProcessed))
        return lastError(with: wdata)
    }
    
}

extension SystemError {
    
    public static func assertNoError() throws {
        if errno != 0 {
            throw SystemError.lastError()
        }
    }
    
    public static func assertNoReceiveError(with data: Data, bytesProcessed: Int) throws {
        if errno != 0 {
            throw SystemError.lastReceiveError(with: data, bytesProcessed: bytesProcessed)
        }
    }
    
    public static func assertNoSendError(with data: Data, bytesProcessed: Int) throws {
        if errno != 0 {
            throw SystemError.lastSendError(with: data, bytesProcessed: bytesProcessed)
        }
    }
    
}
