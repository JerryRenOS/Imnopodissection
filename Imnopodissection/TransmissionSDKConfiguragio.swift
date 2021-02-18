//
//  TransmissionSDKConfiguragio.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/18/21.
//

import Foundation

public struct TransmissionSDKConfiguragio {
    public let appId: String
    public let tokonamae: String
    public let toko: String
    public let sahvaaddress: String
    
    public init(sahvaaddress: String, toko: String, tokonamae: String, appId: String) {
        self.tokonamae = tokonamae
        self.appId = appId
        self.sahvaaddress = sahvaaddress
        self.toko = toko
    }
} 
    
