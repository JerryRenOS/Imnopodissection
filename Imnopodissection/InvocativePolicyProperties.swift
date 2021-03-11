//
//  InvocativePolicyProperties.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 2/19/21.
//

import Foundation

public class InvocativePolicyProperties {
    var policyIdentifier: TransmissionPolicy
    var paramas: [AnyHashable: Any]?
    var responseHandler: TransmissionResponseHandler?
    
    public init(_ policyID: TransmissionPolicy) {
        self.policyIdentifier = policyID
    }
    
    public func withParamas(_ params: [AnyHashable: Any]) -> InvocativePolicyProperties {
        self.paramas = params
        return self
    }
}

public enum TransmissionPolicy: String {
    case user_journey_66 = "user_journey_66"
    // etc.
}



