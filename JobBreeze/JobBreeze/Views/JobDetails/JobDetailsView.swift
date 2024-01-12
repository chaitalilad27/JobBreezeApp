//
//  JobDetailsView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 10/01/24.
//
import SwiftUI

struct JobDetailsView: View {

    // MARK: - Properties

    var jobDetails: JobDetailsDataModel
    var tabTypes: [JobDetailsTabsType] = JobDetailsTabsType.allCases
    @State private var isLiked: Bool = false
    @State private var selectedTabType: JobDetailsTabsType = .about

    // MARK: - Body

    var body: some View {
        mainSection
    }

    // MARK: - Sections

    private var mainSection: some View {
        VStack(spacing: 0) {
            ScrollView {
                employerDetailsSection
            }
            bottomBar
        }
        .background(Color.appLightWhiteColor.ignoresSafeArea(.all))
    }

    private var employerDetailsSection: some View {
        VStack(alignment: .center, spacing: CustomSize.small.rawValue) {
            employerLogoSection
            jobTitleSection
            employerInfoSection
            tabsTitleView
            tabsDetailsView
        }
        .padding(CustomSize.medium.rawValue)
    }

    private var employerLogoSection: some View {
        ImageView(imageURL: jobDetails.employerLogo ?? "",
                  placeHolderImageName: "jobPlaceholder",
                  size: 80,
                  placeholderImageSize: 80,
                  cornerRadius: CustomSize.large.rawValue)
    }

    private var jobTitleSection: some View {
        Text(jobDetails.jobTitle ?? "")
            .font(.poppins(.bold, size: .large))
            .foregroundColor(.appPrimaryColor)
            .lineLimit(2)
    }

    private var employerInfoSection: some View {
        HStack {
            Text(jobDetails.employerName ?? "")
                .font(.poppins(.medium, size: .medium))
                .foregroundColor(.primary)
                .lineLimit(1)

            HStack(spacing: 4) {
                Image(systemName: "location")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.appGrayColor)

                Text(jobDetails.jobCountry ?? "")
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGrayColor)
                    .lineLimit(1)
            }
        }
    }

    private var bottomBar: some View {
        HStack(spacing: 20) {
            likeToggleButton
            applyButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(CustomSize.small.rawValue)
        .background(Color.white)
    }

    private var likeToggleButton: some View {
        ToggleImageView(selectedImageName: "heart.fill",
                        unSelectedImageName: "heart",
                        size: CGSize(width: 45, height: 40),
                        selectedImageColor: .appLightBlueColor,
                        unSelectedImageColor: .appLightBlueColor,
                        isSelected: $isLiked) {}
        .padding(5)
    }

    private var applyButton: some View {
        Button(action: {
            openJobLink()
        }) {
            HStack {
                Spacer()
                Text(NSLocalizedString("applyForJob", comment: ""))
                    .font(.poppins(.bold, size: .medium))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
        }
        .background(Color.appPrimaryColor)
        .cornerRadius(CustomSize.medium.rawValue)
    }

    // MARK: - Tabs Title View

    private var tabsTitleView: some View {
        JobDetailsTabsTitleView(tabTypes: tabTypes, selectedTabType: $selectedTabType)
    }

    // MARK: - Tabs Details View

    private var tabsDetailsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            switch selectedTabType {
            case .about:
                JobDetailsTabsDetailsView(selectedTabType: selectedTabType, details: [jobDetails.jobDescription ?? ""])
            case .qualifications:
                JobDetailsTabsDetailsView(selectedTabType: selectedTabType, details: jobDetails.jobHighlights?.qualifications)
            case .responsibilities:
                JobDetailsTabsDetailsView(selectedTabType: selectedTabType, details: jobDetails.jobHighlights?.responsibilities)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(CustomSize.small.rawValue)
        .background(Color.white.ignoresSafeArea(.all))
        .cornerRadius(CustomSize.medium.rawValue)
    }

    // MARK: - Methods

    private func openJobLink() {
        if let url = URL(string: jobDetails.jobGoogleLink ?? "") {
            UIApplication.shared.open(url)
        }
    }
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(jobDetails: JobDetailsDataModel(employerName: "TEKsystems", employerLogo: "https://www.teksystems.com/-/media/teksystems/images/logos/teksystems-logo.svg?iar=0&rev=7059329eede9499a9965f7b1d91cc97f", jobID: "iXki4pXSSRwAAAAAAAAAAA==", jobEmploymentType: .fulltime, jobTitle: "Python Developer (W2)", jobDescription: "Description:\n\nPython Developer in Houston Texas. W2 only. Contract. Hybrid.\n\nSkills:\n\nPython, React, Linux, Unix, API\n\nAdditional Skills & Qualifications:\n\nRequired Skills-\n\n• Strong development experience using Python, REST API Service\n\n• 3+ years of extensive experience working as a full stack React JS developer (familiarity with redux a plus)\n\n• Database development skills, experience with Object-oriented and Relational databases - SQL Server/Oracle/Sybase.\n\n• Experience developing software using Agile methodology.\n\n• Knowledge of JIRA tools and Continuous Integration capabilities.\n\n• Familiarity with web services, web sockets and microservice based architecture is a plus\n\n• Hands on experience in writing unit and UI integration test cases.\n\nExperience Level:\n\nIntermediate Level\n\nAbout TEKsystems:\n\nWe're partners in transformation. We help clients activate ideas and solutions to take advantage of a new world of opportunity. We are a team of 80,000 strong, working with over 6,000 clients, including 80% of the Fortune 500, across North America, Europe and Asia. As an industry leader in Full-Stack Technology Services, Talent Services, and real-world application, we work with progressive leaders to drive change. That's the power of true partnership. TEKsystems is an Allegis Group company.\n\nThe company is an equal opportunity employer and will consider all applications without regards to race, sex, age, color, religion, national origin, veteran status, disability, sexual orientation, gender identity, genetic information or any characteristic protected by law.", jobCountry: "US", jobGoogleLink: "https://www.google.com/search?gl=us&hl=en&q=iXki4pXSSRwAAAAAAAAAAA%3D%3D&cs=1&ibp=htl;jobs#fpstate=tldetail&htivrt=jobs&htiq=iXki4pXSSRwAAAAAAAAAAA%3D%3D&htidocid=iXki4pXSSRwAAAAAAAAAAA%3D%3D", jobRequiredSkills: [
            "Python",
            "Redux",
            "ui integration",
            "REST API",
            "UI",
            "Jira",
            "Full Stack",
            "Linux",
            "SQL Server",
            "Agile Methodology",
            "Unix",
            "React",
            "Oracle",
            "Continuous Integration",
            "jira tools",
            "Integration",
            "Database Development",
            "Sybase",
            "Architecture",
            "Web Services",
            "Technology Services",
            "Transformation",
            "Writing",
            "Development",
            "Senior Developer & Software Engineer .Net & Full Stack Developer & Full Stack Software Engineer .Net",
            ".Net Developer & Full Stack Developer & Full Stack Application Developer & .Net Software Engineer",
            "Big Data Developer & Java Developer",
            "Senior Software Developer - Java",
            "Swiggy Full Stack Developer - SDE I",
            "Java Developer & Software Engineer",
            "Python Developer",
            "Big Data Developer &  Full Stack Developer",
            "Senior Software Engineer - Java",
            "Python",
            "Sql Relational Database",
            "Senior Software Developer - Java & J2ee & UI Developer"
          ], jobHighlights: JobHighlights(qualifications: [
            "Python, React, Linux, Unix, API",
            "Strong development experience using Python, REST API Service",
            "Database development skills, experience with Object-oriented and Relational databases - SQL Server/Oracle/Sybase",
            "Experience developing software using Agile methodology",
            "Knowledge of JIRA tools and Continuous Integration capabilities",
            "Hands on experience in writing unit and UI integration test cases"
          ])))
    }
}
