# LoginKit for Xcode 16.4

Adapted from Andres de la Cruz's SDGKU course repository:
https://github.com/Andres-SDGKU/MDI1-117-Ch-9-LoginKit
Original source author comments retained. Compatibility changes and completed tests added with Codex assistance.

## Open and run
1. Extract this ZIP into a new folder on your Desktop.
2. Open MDI1-117-Ch-9-LoginKit.xcodeproj in this folder.
3. Choose the MDI1-117-Ch-9-LoginKit scheme and an installed iPhone simulator (for example iPhone 16 Pro, iOS 18).
4. Press Command-R to build and run.
5. Log in with test@mail.com and test1234.
6. Press Command-U to build and run the two unit tests and three UI tests.

No paid Apple Developer membership is needed to run on the simulator.
For a physical device, select your own development team under Signing & Capabilities.

## Manual Remember Me check
Turn Remember Me on, log in, stop the app, then run again. The email should remain; the password is not stored.

## Compatibility changes
- Project object version 110 changed to 77, supported by the Xcode 16 project format.
- iOS deployment target changed to 17.0; supported platforms limited to iPhone/iPad.
- Removed newer default actor isolation/concurrency build settings and type-level nonisolated protocol syntax.
- LoginView explicitly marked @MainActor for LoginViewModel initialization.
- UI tests use secureTextFields for the password and accessibility identifiers from the app.
- Each UI test clears saved email before its initial launch; the Remember Me relaunch deliberately skips that reset.

## Files
The app has eight Swift files: app entry point, User, AuthServiceProtocol, AuthService, SessionStorage, LoginViewModel, LoginView, DashboardView.
The two test files contain five tests total. The included Xcode project links the app and test targets.
COMPLETE_FILES.md contains every complete Swift file and the complete project.pbxproj, shared scheme, workspace XML and asset catalog JSON.

## Verification limits
JSON, XML, project references and archive contents were checked in the generation environment. Xcode and Apple simulators are unavailable here, so no successful Xcode build or test run is claimed. Run Command-R and Command-U on your Mac to confirm.

This is a class demonstration using hard-coded credentials and local email storage, not a production authentication service.
