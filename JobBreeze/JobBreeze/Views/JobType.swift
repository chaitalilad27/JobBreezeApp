//
//  JobType.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 08/01/24.
//

import Foundation

enum JobType: CaseIterable {
    case fullTime
    case partTime
    case contractor

    var rawValue: String {
        switch self {
        case .fullTime:
            return NSLocalizedString("fullTime", comment: "")
        case .partTime:
            return NSLocalizedString("partTime", comment: "")
        case .contractor:
            return NSLocalizedString("contractor", comment: "")
        }
    }
}
