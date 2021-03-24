//
//  NaviataTourGuide.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/11/21.
//


import UIKit


extension SerialUniversalBoomNaviata {

    internal func gettingViewController(bundlename: String? = nil, module: String, screen: String) -> UIBroker? {
        guard let screenPath = readableFromPropertyListo(screen: screen, module: module, bundle: bundlename) else {
            return nil
        }
        
        if checkingWhetherSBoardOrNot(potentialScreenPath: screenPath) {
            var bname: String?
            var sboardname: String?
            var sboardidentifier: String?
            
            let components = screenPath.components(separatedBy: ".")
            
            if let bundlename = bundlename {
                bname = bundlename
            }
            
            if components.count == 3 {
                bname = components.first
                sboardname = components[1]
                sboardidentifier = components.last
            } else {
                sboardname = components.first
                sboardidentifier = components.last
            }
            
            var customizedBundle: Bundle?
            
            // fill out in future commits
        }
        
        return nil
    }
    
    internal func readableFromPropertyListo(screen: String, module: String, bundle: String?) -> String? {
        return String.init()
    }
    
    private func checkingWhetherSBoardOrNot(potentialScreenPath: String) -> Bool {
        let data = potentialScreenPath.components(separatedBy: ".")
        if data.count == 2 || data.count == 3 {
            return true
        }
        return false
    }
    
}
