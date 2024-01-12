//
//  JobDetailsTabsTitleView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 12/01/24.
//

import SwiftUI

struct JobDetailsTabsTitleView: View {

    // MARK: - Properties
    
    var tabTypes: [JobDetailsTabsType]
    @Binding var selectedTabType: JobDetailsTabsType

    // MARK: - Body

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: CustomSize.medium.rawValue) {
                ForEach(tabTypes, id: \.self) { tabType in
                    tabButton(for: tabType)
                }
            }
        }
    }

    // MARK: - Tab Button View

    private func tabButton(for tabType: JobDetailsTabsType) -> some View {
        Button {
            selectedTabType = tabType
        } label: {
            Text(tabType.rawValue)
                .font(.poppins(.medium, size: .medium))
        }
        .tabButtonStyle(selected: selectedTabType == tabType)
    }
}

struct JobDetailsTabsTitleView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsTabsTitleView(tabTypes: JobDetailsTabsType.allCases, selectedTabType: .constant(.about))
    }
}
