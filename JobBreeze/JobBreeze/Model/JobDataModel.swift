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
    var jobEmploymentType: JobEmploymentType?
    var jobTitle: String?
    var jobDescription: String?
    var jobCountry: String?
    var jobGoogleLink: String?
    var jobRequiredSkills: [String]?
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
        case jobRequiredSkills = "job_required_skills"
        case jobHighlights = "job_highlights"
    }

    init(employerName: String, employerLogo: String, jobID: String, jobEmploymentType: JobEmploymentType, jobTitle: String, jobDescription: String, jobCountry: String, jobGoogleLink: String, jobRequiredSkills: [String], jobHighlights: JobHighlights) {
        self.employerName = employerName
        self.employerLogo = employerLogo
        self.jobID = jobID
        self.jobEmploymentType = jobEmploymentType
        self.jobTitle = jobTitle
        self.jobDescription = jobDescription
        self.jobCountry = jobCountry
        self.jobGoogleLink = jobGoogleLink
        self.jobRequiredSkills = jobRequiredSkills
        self.jobHighlights = jobHighlights
    }
}

enum JobEmploymentType: String, Codable {
    case contractor = "CONTRACTOR"
    case fulltime = "FULLTIME"
    case parttime = "PARTTIME"
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
