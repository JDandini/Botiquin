//
//  StringExtension.swift
//  Botiquin
//
//  Created by Javier Castañeda on 14/11/22.
//

import UIKit
import CommonCrypto

extension String {
    var diacriticFree: String {
        return self
               .folding(options: .diacriticInsensitive,
                        locale: Locale(identifier: "es"))
               .lowercased()
    }

    var capitalizingOnlyFirstLetter: String {
        return prefix(1).uppercased() + dropFirst().lowercased()
    }

    var capitalizingFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }

    func trim() -> String {
        return isEmpty ? "" : trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func containsRegex(_ pattern: String) -> Bool {

        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return false
        }

        let range = NSRange(location: 0, length: count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }

    var md5: String? {
        guard let md5Data = MD5(string: self) else { return .none }
        return md5Data.map { String(format: "%02hhx", $0) }.joined()
    }

    private func MD5(string: String) -> Data? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using: .utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress,
                    let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }

    func base64Encoded() -> String? {
        guard let data = self.data(using: .utf8) else {
            return .none
        }
        return data.base64EncodedString()
    }
}
