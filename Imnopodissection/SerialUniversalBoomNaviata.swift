//
//  SerialUniversalBoomNaviata.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/5/21.
//

import Foundation

public class SerialUniversalBoomNaviata {
    
    public var delegate: MapperProtocolNaviataModule?
    public static let sharedInstance = SerialUniversalBoomNaviata.init()
    
    public enum RootedView {
        case bmci
        case othercrap
    }
    
    public func resettingNaviataStockholm(with rootedView: RootedView, payload: [String: Any]? = nil, completion: (() -> Void)? = nil) {
        let mappa = delegate?.mappa(rootedView)
        let bundleName = mappa?.stationBundleName
        let module = mappa?.stationModule ?? ""
        let screen = mappa?.stationScreen ?? ""
        
    }
}
