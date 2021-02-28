//
//  TransmissionPolicyInvocativeWorker.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/24/21.
//

import Foundation

public class TSXAuthenticationResult: NSObject {
    // should be an @interface, but 先做做样子
}

public enum TransmissionSdkErro: Error {
    
}

public typealias TransmissionWithErroCallback = (TSXAuthenticationResult?, TransmissionSdkErro?) -> Bool


public class TransmissionPolicyInvocativeWorker {
    
    public static var shared = TransmissionPolicyInvocativeWorker()
    
    private func invokingPolicy(withPolicyIdentifier policyId: TransmissionPolicy, params: [AnyHashable: Any]?,
                                context: [AnyHashable: Any]?, callback: @escaping TransmissionWithErroCallback, preExecutionHandler: (() -> Void)? = nil, sessionExpireHandler: (() -> Void)? = nil) {
        
        let policyParams = self.params(withPolicyParams: params, forPolicy: policyId)
        
        // 有待
    }
    
    private func params(withPolicyParams policyParams: [AnyHashable: Any]? = nil, forPolicy policyId: TransmissionPolicy) -> [AnyHashable: Any] {
        // 之后填补 csid, appversion, routingkey
        
        var params = [AnyHashable: Any]()
        
        if let policyParams = policyParams {
            params.merge(policyParams) { (_, new) -> Any in
                new
            }
        }

        return params
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
