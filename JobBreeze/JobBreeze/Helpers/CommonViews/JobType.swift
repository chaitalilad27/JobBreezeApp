//
//  JobType.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 08/01/24.
//

import Foundation

enum JobType: CaseIterable {
    case popularJobs
    case nearbyJobs

    var rawValue: String {
        switch self {
        case .popularJobs:
            return NSLocalizedString("popularJobs", comment: "")
        case .nearbyJobs:
            return NSLocalizedString("nearbyJobs", comment: "")
        }
    }
}

enum JobDetailsTabsType: CaseIterable {
    case about
    case qualifications
    case responsibilities

    var rawValue: String {
        switch self {
        case .about:
            return NSLocalizedString("about", comment: "")
        case .qualifications:
            return NSLocalizedString("qualifications", comment: "")
        case .responsibilities:
            return NSLocalizedString("responsibilities", comment: "")
        }
    }
}
