//
//  JobDataModel.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 09/01/24.
//

import Foundation

// MARK: - JobDataModel
struct JobsDataModel: Decodable {
    let data: [JobDetailsDataModel]

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - JobDetailsDataModel
struct JobDetailsDataModel: Decodable {
    var employerName: String?
    var employerLogo: String?
    var jobID: String
    var jobEmploymentType: String?
    var jobTitle: String?
    var jobDescription: String?
    var jobCountry: String?
    var jobGoogleLink: String?
    var jobHighlights: JobHighlights?

    enum CodingKeys: String, CodingKey {
        case employerName = "employer_name"
        case employerLogo = "employer_logo"
        case jobID = "job_id"
        case jobEmploymentType = "job_employment_type"
        case jobTitle = "job_title"
        case jobDescription = "job_description"
        case jobCountry = "job_country"
        case jobGoogleLink = "job_google_link"
        case jobHighlights = "job_highlights"
    }
}
