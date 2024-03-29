//
//  ApolloPodoro.swift
//  Imnopodissection
//
//  Created by Jerry Ren on 8/2/21.
//

import Foundation

open class ApolloURLSessionClient: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    
    public typealias RawCompletion = (Data?, HTTPURLResponse?, Error?) -> Void
    public typealias Completion = (Result<(Data, HTTPURLResponse), Error>) -> Void
}
