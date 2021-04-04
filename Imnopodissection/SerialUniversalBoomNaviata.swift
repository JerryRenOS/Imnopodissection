//
//  SerialUniversalBoomNaviata.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/5/21.
//

import UIKit

public class SerialUniversalBoomNaviata {
    
    public var delegate: MapperProtocolNaviataModule?
    public static let sharedInstance = SerialUniversalBoomNaviata.init()
    
    var mainNaviataCon: UINavigationController? {
        didSet {
            if var mainNaviata = mainNaviataCon {
                // self.setUpNaviata (fill out setUpNaviata later)
            }
        }
    }
    
    public enum RootedView {
        case bmci
        case othercrap
    }
    
    public func resettingNaviataStockholm(with rootedView: RootedView, payload: [String: Any]? = nil, completion: (() -> Void)? = nil) {
        let mappa = delegate?.mappa(rootedView)
        let bundleName = mappa?.stationBundleName
        let module = mappa?.stationModule ?? ""
        let screen = mappa?.stationScreen ?? ""
        
        guard let stockBrokerVici = self.gettingViCi(screen: screen, module: module, bundleName: bundleName) else { return }
        privatelyResettingNaviataStockholm(stockBrokerVici: stockBrokerVici, payload: payload, completion: completion)
    }
    
    private func privatelyResettingNaviataStockholm(stockBrokerVici: UIBrokerage, payload: [String: Any]?, completion: (() -> Void)?) {
        guard let firstWindow = UIApplication.shared.windows.first,
              let mainNavy = self.mainNaviataCon,
              let destiny = stockBrokerVici as? UIViewController else {
            return
        }
        
        // fill out details in commits down the road
    }
    
    private func gettingViCi(screen: String, module: String, bundleName: String? = nil) -> UIBrokerage? {
        // fill in contents slightly later
        return nil
    }
}
