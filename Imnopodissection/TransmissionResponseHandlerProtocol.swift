//
//  TransmissionResponseHandlerProtocol.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 3/10/21.
//

import Foundation

public protocol TransmissionResponseHandler {
    func handlingErro(erro: TSXAuthenticationErro)
    func handlingResult(result: TSXAuthenticationResult)
    
    var extraErroHandlingActions:  [(TSXAuthenticationErro) -> Void] { get set }
    var extraResultHandlingActions: [(TSXAuthenticationResult) -> Void] { get set }
    var extraCommonHandlingActions: [(TSXAuthenticationResult?, TSXAuthenticationErro?) -> Void] { get set }
}

public extension TransmissionResponseHandler {
    // fill this out next commit
    func handlingTheResponse(res: TSXAuthenticationResult?, erro: TSXAuthenticationErro? ) {
        if let erro = erro {
            var isGlobalErro = false
            let erroData = erro.data ?? [:]
            if erroData.count > 0 {
                if let failureData = erroData["failure_data"] as? [AnyHashable: Any], let reason = failureData["reason"] as? [AnyHashable: Any], let reasonData = reason["reasonData"] as? [AnyHashable: Any], let lockedIn = reasonData["lockedIn"] as? Bool, lockedIn == true {
                    // TransmissionErroHandlerWorker.sharedInstance.handleUserLockedInsideScenario()
                    isGlobalErro = true
                }
            }
            if !isGlobalErro {
                handlingErro(erro: erro)
                // extra line of code
            }
            
            else if let res = res {
                handlingResult(result: res)
                // extra line of code
            }
        }
    }
}



public class TSXAuthenticationResult: NSObject {
    // should be an @interface, but 先做做样子
}

public class TSXAuthenticationErro: NSObject {
    // should be an @interface, but 先做做样子
    public let data: NSDictionary? = [:]
}
