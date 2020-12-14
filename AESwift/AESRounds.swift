//
//  AESRounds.swift
//  AESwift
//
//  Created by Omar Khodr on 12/12/20.
//

import Foundation

struct AESRounds {
    
    let aes: AES
    let roundMessageBytes: [[UInt8]]
    let roundKeyBytes: [[UInt8]]
    
    init(message: String, key: String) {
        
        var messageBytes: [UInt8] = []
        var keyBytes: [UInt8] = []
        
        var i = 0
        while i < message.count-1 {
            let start = message.index(message.startIndex, offsetBy: i)
            let end = message.index(message.startIndex, offsetBy: i+1)
            let range = start...end

            let byteStr = message[range]
            let byte = UInt8(byteStr, radix: 16)!
            messageBytes.append(byte)
            i += 2
        }
        
        
        i = 0
        while i < key.count-1 {
            let start = key.index(key.startIndex, offsetBy: i)
            let end = key.index(key.startIndex, offsetBy: i+1)
            let range = start...end

            let byteStr = key[range]
            let byte = UInt8(byteStr, radix: 16)!
            keyBytes.append(byte)
            i += 2
        }
        
//        let aesKey: Array<UInt8> = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f]
//
//        let input: Array<UInt8> = [0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff]
        
        aes = try! AES(key: keyBytes, blockMode: ECB(), padding: .noPadding)
        let encrypted = try! aes.encrypt(messageBytes)
        
        roundMessageBytes = aes.roundMessageBytes
        roundKeyBytes = aes.roundKeyBytes
        
        print(roundMessageBytes)
        print(roundKeyBytes)
        
        print("input: \(messageBytes)")
        print("encrypted: \(encrypted)")
        
        var text = ""
        
        for byte in encrypted {
            text += String(format:"%02X", byte) + ", "
        }
        
        
    }
    
    func buildRoundStrings(from rounds: [[UInt8]]) -> [String] {
        var res: [String] = []
        
        for roundBytes in rounds {
            var round = ""
            var counter = 0
            for byte in roundBytes {
                round += String(format:"%02X", byte)
                if counter%4 != 3 {
                    round += " "
                } else if counter != roundBytes.count-1 {
                    round += "\n"
                }
                counter += 1
            }
            res.append(round)
        }
        
        return res
    }
    
    func roundMessageStrings() -> [String] {
        return buildRoundStrings(from: roundMessageBytes)
    }
    
    func roundKeyStrings() -> [String] {
        return buildRoundStrings(from: roundKeyBytes)
    }
    
}
