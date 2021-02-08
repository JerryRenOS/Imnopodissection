//
//  PathStation.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/5/21.
//

public protocol MapperProtocolNaviataModule {
    func mappa(_ rootedview: SerialUniversalBoomNaviata.RootedView) -> PathStation
}

public struct PathStation {
    var stationModule: String
    var stationBundleName: String?
    var stationScreen: String
    
    public init(screen: String, bundlename: String?, module: String) {
        self.stationBundleName = bundlename
        self.stationModule = module
        self.stationScreen = screen
    }
}       
