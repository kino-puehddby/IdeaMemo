//
//  AppError.swift
//  IdeaMemo
//
//  Created by Hisaya Sugita on 2020/12/26.
//

import Foundation

public enum AppError: LocalizedError, Equatable {
    case authorization
    case network
    case server(Int)
    case system
    case business
    case icloud
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .authorization: return L10n.AppError.authorization
        case .network: return L10n.AppError.network
        case .server(let statusCode): return L10n.AppError.server(statusCode)
        case .system: return L10n.AppError.system
        case .business: return L10n.AppError.business
        case .icloud: return L10n.AppError.icloud
        case .unknown: return L10n.AppError.unknown
        }
    }
}
