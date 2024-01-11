//
//  ViewExtension.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 12/07/23.
//

import SwiftUI

// MARK: View Extension
extension View {
    /// Displays a toast message view overlaying the current view when the `isPresented` binding is `true`.
    ///
    /// - Parameters:
    ///   - isPresented: Binding that controls the presentation of the toast message view.
    ///   - message: The message to be displayed in the toast.
    ///   - backgroundColor: The background color of the toast message view.
    ///   - textColor: The text color of the toast message.
    ///   - cornerRadius: The corner radius of the toast message view.
    ///   - displayDuration: The duration for which the toast message is displayed.
    /// - Returns: The modified view with a toast message overlay.
    func toast(
        isPresented: Binding<Bool>,
        message: String,
        backgroundColor: Color = Color.appThemeColor.opacity(0.7),
        textColor: Color = .white,
        cornerRadius: CGFloat = 10,
        displayDuration: TimeInterval = 2.0
    ) -> some View {
        ZStack(alignment: .top, content: {
            self
            if isPresented.wrappedValue {
                ToastMessageView(
                    message: message,
                    backgroundColor: backgroundColor,
                    textColor: textColor,
                    cornerRadius: cornerRadius
                )
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.3), value: isPresented.wrappedValue)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {
                        withAnimation {
                            isPresented.wrappedValue = false
                        }
                    }
                }
            }
        })
    }

    // MARK: - Navigation Bar Style

    /// Sets a custom navigation bar style for the view.
    /// - Parameters:
    ///   - title: The title to be displayed in the navigation bar.
    ///   - displayMode: The display mode for the navigation bar title.
    ///   - navigationBarColor: The background color for the navigation bar.
    /// - Returns: A modified view with the specified navigation bar style.
    func navigationBarStyle(title: String, displayMode: NavigationBarItem.TitleDisplayMode = .inline, navigationBarColor: Color = Color.appThemeColor) -> some View {
        self.navigationTitle(NSLocalizedString(title, comment: ""))  // Set the localized title for the navigation bar
            .toolbarColorScheme(.dark, for: .navigationBar)  // Set color scheme for the navigation bar
            .navigationBarTitleDisplayMode(displayMode)  // Set the display mode for the navigation bar title
            .toolbarBackground(navigationBarColor, for: .navigationBar)  // Set the background color for the navigation bar
            .toolbarBackground(.visible, for: .navigationBar)  // Make the navigation bar background visible
    }

    func shadowStyle(isSmall: Bool) -> some View {
        self.shadow(color: .black.opacity(0.25), radius: isSmall ? 3.84 : 5.84, x: 0, y: 2)
    }
}
