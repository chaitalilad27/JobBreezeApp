💼 🔍 JobBreezeApp
===========
Welcome to JobBreeze, an iOS application designed to enhance your job search experience. This app, developed natively in iOS, is inspired by the [ReactNativeJobsApp](https://github.com/chaitalilad27/ReactNativeJobsApp), offering a customized experience for iOS users. The app provides a user-friendly interface to discover jobs based on different criteria, such as job type, popularity, and proximity.

🚀 Features
-----------
- **Job List:** Browse popular and nearby jobs through a paginated view for a smoother experience. 
- **Job Search:** Easily search for jobs based on your preferences.
- **Job Categories:** Explore jobs categorized by employment type like full-time, part-time, or contractor.
- **Detailed Job Information:** View detailed information about each job, including description, qualifications, and responsibilities, and apply via a redirect link to the respective job portal.
- **Favorites:** Like your preferred jobs.
- **Other Features:**
    - **Pull-to-Refresh:** Update the job list with a simple pull-to-refresh functionality.
    - **Network Handling:** Dynamically respond to network availability, ensuring a seamless experience.
    - **Toast Notifications:** Receive instant notifications for error messages, keeping you informed at all times.

📸 Sneak Peek
-----------

<p float="left">
<img src="https://raw.githubusercontent.com/chaitalilad27/JobBreezeApp/main/Screenshots/JobBreeze_1.png" width="20%"">
<img src="https://raw.githubusercontent.com/chaitalilad27/JobBreezeApp/main/Screenshots/JobBreeze_2.png" width="20%"">
<img src="https://raw.githubusercontent.com/chaitalilad27/JobBreezeApp/main/Screenshots/JobBreeze_3.png" width="20%"">
<img src="https://raw.githubusercontent.com/chaitalilad27/JobBreezeApp/main/Screenshots/JobBreeze_4.png" width="20%"">
<img src="https://raw.githubusercontent.com/chaitalilad27/JobBreezeApp/main/Screenshots/JobBreeze_5.png" width="20%"">
</p>

💻 Technologies Used
-----------
- SwiftUI
- Combine
- Network
- URLSession

🏗️ Project Structure
-----------
- **Models**: Data models such as `JobsDataModel`, `JobDetailsDataModel`, and `Images`.
- **Views**: Different views like `LaunchScreen`, `HomeView`, `JobListView`, `JobDetailsView`, etc.
- **ViewModels**: View models that handle the app's logic, such as `HomeViewModel` and `JobListViewModel`.
- **Helpers**: Utility classes and extensions used throughout the app.
    - **CommonViews**: Common views and reusable UI components, such as `EmptyStateView`, `ActivityIndicatorView`, `ImageView`, `CustomTextField`, `ToggleImageView`, and `ToastMessageView`.
    - **Fonts**: Custom font files used in the app.
    - **APIManager**: Responsible for handling API requests and responses.
    - **Extensions**: Different extensions to extend the functionality of existing classes and types, including extensions for `Color`, `Font`, and `View`.
- **Config**: App configuration file `AppConfig`
- **Assets**: Image and color asset files.

📚 Third Party Libraries
-----------
The following third-party libraries are used in this project:

- **[Kingfisher](https://github.com/onevcat/Kingfisher)**: A lightweight library for downloading and caching images from the web.
    
- **[SwiftUI Pull To Refresh](https://github.com/globulus/swiftui-pull-to-refresh)**: A library that provides a pull-to-refresh feature for SwiftUI views.

🌐 API Reference
-----------
The JobBreeze App interacts with the following [JSearch API](https://rapidapi.com/letscrape-6bRBa3QguO5/api/jsearch) for fetching jobs:

- **Fetch Jobs**: Fetches jobs from a specific endpoint.
    - Method: GET
    - Method name: `fetchJobs`
    - Response: Object of `JobsDataModel` with list of `JobDetailsDataModel`

💻 Getting Started
---------------
Ready to dive in? Follow these simple steps to set up and run the app on your local machine.

####  🛠️ Prerequisites️ 
- Xcode (version 14.0 or later)
- iOS device or simulator running iOS 16.0 or later

#### 🚀 Installation
1. Clone the repository:

    ```bash
    git clone https://github.com/chaitalilad27/JobBreezeApp.git
    ```

2. Open the project in Xcode:

    ```bash
    cd JobBreeze
    open JobBreeze.xcodeproj
    ```
    
3. Project uses external dependencies managed by a Swift Package Manager (SPM), ensure that the dependencies are installed. If not, follow the steps below:
   - Go to `File -> Swift Packages -> Update to Latest Package Versions` to fetch and install the required dependencies.
4. Open `JobBreeze/Config/AppConfig.swift`. Replace the placeholder for the API key with your actual API key in the `apiKey` constant.

   ```swift
    static let apiKey = "YOUR_API_KEY"
    ```
5. Build and run the app using the Xcode simulator or a connected iOS device.

🤝 Contributing
---------------

Contributions are welcome! Feel free to open issues or submit pull requests to enhance the app.

📜 License
-----------

This project is licensed under the MIT License - see the LICENSE file for details.

Feel free to remix this README to match the rhythm of your project, add more sparkle, or sprinkle in your unique flavor! ✨
