//
//  StockBroker.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/6/21.
//

import Foundation

@objc public protocol StockBroker: class {
    var payload: [String: Any]? { get set }
    @objc optional func callbackNaviata(result: AnyObject?) // anyobject minus object
    @objc optional func transioningCustomized()
}
 
@objc public protocol UIBroker: class { }
