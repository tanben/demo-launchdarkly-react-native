//
//  HTTPHeaders.swift
//  LaunchDarkly
//
//  Copyright © 2017 Catamorphic Co. All rights reserved.
//

import Foundation

struct HTTPHeaders {

    struct HeaderKey {
        static let authorization = "Authorization"
        static let userAgent = "User-Agent"
        static let contentType = "Content-Type"
        static let accept = "Accept"
        static let eventSchema = "X-LaunchDarkly-Event-Schema"
        static let ifNoneMatch = "If-None-Match"
        static let eventPayloadIDHeader = "X-LaunchDarkly-Payload-ID"
        static let sdkWrapper = "X-LaunchDarkly-Wrapper"
    }

    struct HeaderValue {
        static let apiKey = "api_key"
        static let applicationJson = "application/json"
        static let eventSchema3 = "3"
    }

    private let mobileKey: String
    private let additionalHeaders: [String: String]
    private let authKey: String
    private let userAgent: String
    private let wrapperHeaderVal: String?

    init(config: LDConfig, environmentReporter: EnvironmentReporting) {
        self.mobileKey = config.mobileKey
        self.additionalHeaders = config.additionalHeaders
        self.userAgent = "\(environmentReporter.systemName)/\(environmentReporter.sdkVersion)"
        self.authKey = "\(HeaderValue.apiKey) \(config.mobileKey)"

        if let wrapperName = config.wrapperName {
            if let wrapperVersion = config.wrapperVersion {
                wrapperHeaderVal = "\(wrapperName)/\(wrapperVersion)"
            } else {
                wrapperHeaderVal = wrapperName
            }
        } else {
            wrapperHeaderVal = nil
        }
    }

    private var baseHeaders: [String: String] {
        var headers = [HeaderKey.authorization: authKey,
                       HeaderKey.userAgent: userAgent]

        if let wrapperHeader = wrapperHeaderVal {
            headers[HeaderKey.sdkWrapper] = wrapperHeader
        }

        return headers
    }

    var eventSourceHeaders: [String: String] { withAdditionalHeaders(baseHeaders) }
    var flagRequestHeaders: [String: String] { withAdditionalHeaders(baseHeaders) }

    var eventRequestHeaders: [String: String] {
        var headers = baseHeaders
        headers[HeaderKey.contentType] = HeaderValue.applicationJson
        headers[HeaderKey.accept] = HeaderValue.applicationJson
        headers[HeaderKey.eventSchema] = HeaderValue.eventSchema3
        return withAdditionalHeaders(headers)
    }

    var diagnosticRequestHeaders: [String: String] {
        var headers = baseHeaders
        headers[HeaderKey.contentType] = HeaderValue.applicationJson
        headers[HeaderKey.accept] = HeaderValue.applicationJson
        return withAdditionalHeaders(headers)
    }

    private func withAdditionalHeaders(_ headers: [String: String]) -> [String: String] {
        headers.merging(additionalHeaders) { $1 }
    }
}
