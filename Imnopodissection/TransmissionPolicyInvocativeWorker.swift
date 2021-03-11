//
//  TransmissionPolicyInvocativeWorker.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/24/21.
//

import Foundation

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
    
    public func addingIovationDataTo(policyParams: [AnyHashable: Any]? = nil, forPolicy policyId: TransmissionPolicy) -> [AnyHashable: Any] {
        
        var totalParams = [AnyHashable: Any]()
        
        if let policyParams = policyParams {
            totalParams.merge(policyParams) { (_, new) -> Any in
                new
            }
        }
        
        if let blackboxData = DeviceInfo.blackBox(policyId: policyId) {
            totalParams[TransmissionConstants.DictionaryKeys.blackBoxData] = blackboxData
            // Tdd-ish (red green refactor)
        }
        
        return totalParams
    }
}
    
//  separate into another file later
    
    public struct DeviceInfo {
        
    }
    
 public extension DeviceInfo {
        static func blackBox(policyId: TransmissionPolicy?) -> String? {
            // fill blanks later
            return String.init()
        }
    }
    

