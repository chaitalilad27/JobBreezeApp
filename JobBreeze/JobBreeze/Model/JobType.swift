//
//  JobType.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 08/01/24.
//

import Foundation

// MARK: - JobType
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

// MARK: - JobEmploymentType
enum JobEmploymentType: String, Codable, CaseIterable {
    case contractor = "CONTRACTOR"
    case fulltime = "FULLTIME"
    case parttime = "PARTTIME"

    var rawValue: String {
        switch self {
        case .fulltime:
            return NSLocalizedString("fullTime", comment: "")
        case .parttime:
            return NSLocalizedString("partTime", comment: "")
        case .contractor:
            return NSLocalizedString("contractor", comment: "")
        }
    }
}

// MARK: - JobHighlights
struct JobHighlights: Codable {
    var qualifications, responsibilities, benefits: [String]?

    enum CodingKeys: String, CodingKey {
        case qualifications = "Qualifications"
        case responsibilities = "Responsibilities"
        case benefits = "Benefits"
    }
}

// MARK: - JobDetailsTabsType
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
