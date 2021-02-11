//
//  StockBroker.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/6/21.
//

import Foundation

@objc public protocol StockBroker: AnyObject {
    var payload: [String: Any]? { get }
    @objc optional func callbackNaviata(result: Any?) // anyobject minus object
    @objc optional func transioningCustomized()
}
 
  
 
