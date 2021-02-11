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
        case othercrap
        case bmci
    }
    
    open func resettingNaviataStockholm(with rootedView: RootedView, payload: [String: Any]? = nil, completion: (() -> Void)? = nil) {
        let mappa = delegate?.mappa(rootedView)
        _ = mappa?.stationBundleName
        _ = mappa?.stationModule
        _ = mappa?.stationScreen
    }
}
 



