//
//  String+Extension.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 28/11/2023.
//

import Foundation
import CryptoKit

extension String {
    public var md5: Self {
        let data = self.data(using: .utf8) ?? Data()
        let hash = Insecure.MD5.hash(data: data)
        let stringHash = hash.map({ String(format: "%02hhx", $0) }).joined()
        return stringHash
     }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
