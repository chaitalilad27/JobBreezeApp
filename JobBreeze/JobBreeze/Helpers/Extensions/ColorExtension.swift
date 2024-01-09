//
//  ColorExtension.swift
//  NewsFlasher
//
//  Created by Chaitali Lad on 19/06/23.
//

import SwiftUI

// MARK: Color Extension
extension Color {
    
    // MARK: - Custom App Colors

    static let appThemeColor = Color("AppTheme")
    static let appLightRedColor = Color("AppLightRed")
    static let appLightBlueColor = Color("AppLightBlue")
    static let appDarkBlueColor = Color("AppDarkBlue")
    static let appPrimaryColor = Color("AppPrimary")
    static let appSecondaryColor = Color("AppSecondary")
    static let appTertiaryColor = Color("AppTertiary")
    static let appGrayColor = Color("AppGray")
    static let appGray2Color = Color("AppGray2")
    static let appWhiteColor = Color("AppWhite")
    static let appLightWhiteColor = Color("AppLightWhite")


    // MARK: - Random Color Generator

    // Generate a random color.
    static func random() -> Color {
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        let color = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
        print(color)
        return Color(color)
    }
}
