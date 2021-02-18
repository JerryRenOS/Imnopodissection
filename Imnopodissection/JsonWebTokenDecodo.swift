//
//  JsonWebTokenDecodo.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/18/21.
//

import Foundation

public class JsonWebTokenDecodo {
    public init() {  }
    
    public func decodingJwt(jwtToken jwt: String) throws -> [String:  Any] {
        let segments = jwt.components(separatedBy: ".")
        guard let dataFromJwt = segments[1].decodingBase64Url(), let jsonObj = try? JSONSerialization.jsonObject(with: dataFromJwt, options: []), let payload = jsonObj as? [String:Any] else {
            return [:]
        }
        return payload
    }
}

extension String {
    public func decodingBase64Url() -> Data? {
        var base64 = self.replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let leng = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let lengRequired = ceil(leng / 4.0) * 4
        let paddingLeng = lengRequired - leng
        
        if paddingLeng > 0 {
            let padding = "".padding(toLength: Int(paddingLeng), withPad: "=", startingAt: 0)
            base64 += padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
}
