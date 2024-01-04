# FaceLibrary: Your Personal Photo Collection

## Overview
<table>
  <tr>
    <td>
      <img src="https://github.com/penguin-waddle/FaceLibrary/assets/123434744/94edfdc8-6144-4488-b4be-af54a9be2b26" alt="Face Library App Demo" width="300" />
    </td>
    <td>
      FaceLibrary is an innovative iOS app that offers a personalized way to store and manage photos. Users can import pictures from their photo library, assign a unique name to each, and view them in a curated list. Selecting a photo from the list displays a detailed view with an enlarged version of the image. This app effectively combines photo management with custom labeling and secure storage.
    </td>
  </tr>
</table>

## Features
- **Photo Import**: Use `PHPickerViewController` to select photos from the user's photo library.
- **Custom Naming**: Prompt users to name each photo upon import.
- **Photo Storage**: Securely save photos and their associated names.
- **Sorted Photo List**: Display all saved photos and names in a sorted list.
- **Detail View**: Show an enlarged version of the photo with details in a separate screen.
- **Data Persistence**: Efficiently save and retrieve photo data.

## Technical Details
- **SwiftUI and UIKit Integration**: Bridging SwiftUI with UIKit components for photo picking.
- **Core Image and Core Location**: Utilizing Core Image for photo processing and Core Location for geotagging.
- **Custom Components**: Building SwiftUI views for displaying photo collections.
- **FileManager**: Handling local file storage for saving and retrieving photos.

## Code Snippets
- **AddPhotoView**: Handles the addition of new photos, including name assignment and image picker integration.
- **ContentView**: Manages the main app view, displaying the list of photos.
- **ImagePicker**: Wraps `PHPickerViewController` for SwiftUI compatibility.
- **ImageSaver**: Manages saving images to disk with optional location data.
- **LocationFetcher**: Fetches and provides geolocation data for new photos.
- **PhotoDetailView**: Presents an enlarged view of selected photos with additional details.

## Challenges and Skills
- Integrating UIKit components within SwiftUI for photo selection.
- Managing and persisting complex data, including images and metadata.
- Implementing geolocation tagging for added context to photos.
- Creating a smooth and intuitive user experience in photo management.

---

*FaceLibrary was developed as part of the "100 Days of SwiftUI" course, focusing on integrating SwiftUI with UIKit, managing photo data, and utilizing Core Location for geotagging.*

---

[Back to Main Repository](https://github.com/penguin-waddle/100-Days-of-SwiftUI)
