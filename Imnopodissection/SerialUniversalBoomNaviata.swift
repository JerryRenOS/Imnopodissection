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
    
    var mainNaviatalController: UINavigationController? {
        didSet {
            if var mainNaviata = mainNaviatalController {
                self.settingUpNaviatalController(&mainNaviata)
            }
        }
    }
          
    private func settingUpNaviatalController(_ naviContr: inout UINavigationController) {
        naviContr.setNavigationBarHidden(true, animated: false)
        naviContr.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        naviContr.navigationBar.shadowImage = UIImage()
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
        
    }
}
