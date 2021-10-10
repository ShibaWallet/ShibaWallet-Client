//
//  Data+Extension.swift
//  Runner
//
//  Created by admin on 2021/7/14.
//

extension Data {
    
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    // https://stackoverflow.com/questions/39075043/how-to-convert-data-to-hex-string-in-swift
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
    
}
