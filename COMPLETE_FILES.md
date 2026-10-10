# Complete LoginKit files for Xcode 16.4

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


## MDI1-117-Ch-9-LoginKit/Assets.xcassets/AccentColor.colorset/Contents.json

```json
{
  "colors" : [
    {
      "idiom" : "universal"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
```


## MDI1-117-Ch-9-LoginKit/Assets.xcassets/AppIcon.appiconset/Contents.json

```json
{
  "images" : [
    {
      "idiom" : "universal",
      "platform" : "ios",
      "size" : "1024x1024"
    },
    {
      "appearances" : [
        {
          "appearance" : "luminosity",
          "value" : "dark"
        }
      ],
      "idiom" : "universal",
      "platform" : "ios",
      "size" : "1024x1024"
    },
    {
      "appearances" : [
        {
          "appearance" : "luminosity",
          "value" : "tinted"
        }
      ],
      "idiom" : "universal",
      "platform" : "ios",
      "size" : "1024x1024"
    },
    {
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "16x16"
    },
    {
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "16x16"
    },
    {
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "32x32"
    },
    {
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "32x32"
    },
    {
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "128x128"
    },
    {
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "128x128"
    },
    {
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "256x256"
    },
    {
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "256x256"
    },
    {
      "idiom" : "mac",
      "scale" : "1x",
      "size" : "512x512"
    },
    {
      "idiom" : "mac",
      "scale" : "2x",
      "size" : "512x512"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
```


## MDI1-117-Ch-9-LoginKit/Assets.xcassets/Contents.json

```json
{
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
```


## MDI1-117-Ch-9-LoginKit/MDI1_117_Ch_9_LoginKitApp.swift

```swift
//
//  MDI1_117_Ch_9_LoginKitApp.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import SwiftUI

@main
struct MDI1_117_Ch_9_LoginKitApp: App {
    
    init() {
        if ProcessInfo.processInfo.arguments.contains("-UITesting-Reset") {
            SessionStore().clear()
        }
    }
 
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
```


## MDI1-117-Ch-9-LoginKit/Model/User.swift

```swift
//
//  User.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import Foundation
 
struct User: Hashable {
    let email: String
    let name: String
}
```


## MDI1-117-Ch-9-LoginKit/Services/AuthService.swift

```swift
//
//  AuthService.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import Foundation
 
final class AuthService: AuthServiceProtocol {
    private let validEmail = "test@mail.com"
    private let validPassword = "test1234"
 
    func login(email: String, password: String) async throws -> User {
        try await Task.sleep(nanoseconds: 400_000_000)
 
        guard email == validEmail, password == validPassword else {
            throw AuthError.invalidCredentials
        }
        return User(email: email, name: "Example")
    }
}
```


## MDI1-117-Ch-9-LoginKit/Services/AuthServiceProtocol.swift

```swift
//
//  AuthServiceProtocol.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import Foundation
 
protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> User
}
 
enum AuthError: Error, LocalizedError {
    case invalidCredentials
 
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password"
        }
    }
}
```


## MDI1-117-Ch-9-LoginKit/Services/SessionStorage.swift

```swift
//
//  SessionStorage.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import Foundation
 
protocol SessionStoring {
    var rememberedEmail: String? { get set }
    func clear()
}
 
final class SessionStore: SessionStoring {
    private let defaults: UserDefaults
    private let key = "rememberedEmail"
 
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
 
    var rememberedEmail: String? {
        get { defaults.string(forKey: key) }
        set {
            defaults.set(newValue, forKey: key)
        }
    }
 
    func clear() {
        defaults.removeObject(forKey: key)
    }
}
```


## MDI1-117-Ch-9-LoginKit/ViewModel/LoginViewModel.swift

```swift
//
//  LoginViewModel.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import Foundation
import Combine
 
@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var rememberMe: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var loggedInUser: User?
 
    private let authService: AuthServiceProtocol
    private var sessionStore: SessionStoring
 
    init(authService: AuthServiceProtocol, sessionStore: SessionStoring = SessionStore()) {
        self.authService = authService
        self.sessionStore = sessionStore
 
        if let rememberedEmail = sessionStore.rememberedEmail {
            self.email = rememberedEmail
            self.rememberMe = true
        }
    }
 
    func login() async {
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }
 
        do {
            let user = try await authService.login(email: email, password: password)
            loggedInUser = user
 
            if rememberMe {
                sessionStore.rememberedEmail = email
            } else {
                sessionStore.clear()
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
 
    func logout() {
        loggedInUser = nil
        password = ""
        if !rememberMe {
            email = ""
        }
    }
}
```


## MDI1-117-Ch-9-LoginKit/Views/DashboardView.swift

```swift
//
//  DashboardView.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import SwiftUI
 
struct DashboardView: View {
    let user: User
    let onLogout: () -> Void
 
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 48))
                .foregroundColor(.green)
 
            Text("Welcome, \(user.name)")
                .font(.title2.bold())
                .accessibilityIdentifier("welcome_label")
 
            Button("Log Out", role: .destructive) {
                onLogout()
            }
            .buttonStyle(.bordered)
            .accessibilityIdentifier("logout_button")
            .padding(.top, 8)
        }
        .padding()
        .navigationTitle("Dashboard")
        .navigationBarBackButtonHidden(true)
    }
}
```


## MDI1-117-Ch-9-LoginKit/Views/LoginView.swift

```swift
//
//  LoginView.swift
//  MDI1-117-Ch-9-LoginKit
//
//  Created by Andres de la Cruz on 10/7/26.
//

import SwiftUI

@MainActor
struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel

    init(authService: AuthServiceProtocol = AuthService()) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(authService: authService))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("LoginKit")
                    .font(.largeTitle.bold())

                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .accessibilityIdentifier("email_field")

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityIdentifier("password_field")

                Toggle("Remember Me", isOn: $viewModel.rememberMe)
                    .accessibilityIdentifier("remember_me_toggle")

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("error_label")
                }

                Button {
                    Task { await viewModel.login() }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .accessibilityIdentifier("loading_indicator")
                    } else {
                        Text("Log In")
                    }
                }
                .accessibilityIdentifier("login_button")
                .disabled(viewModel.isLoading)
            }
            .padding()
            .navigationDestination(item: $viewModel.loggedInUser) { user in
                DashboardView(user: user, onLogout: { viewModel.logout() })
            }
        }
    }
}
```


## MDI1-117-Ch-9-LoginKit.xcodeproj/project.pbxproj

```text
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 77;
	objects = {

/* Begin PBXContainerItemProxy section */
		A191104030770791008EFF48 /* PBXContainerItemProxy */ = {
			isa = PBXContainerItemProxy;
			containerPortal = A191102A3077078F008EFF48 /* Project object */;
			proxyType = 1;
			remoteGlobalIDString = A19110313077078F008EFF48;
			remoteInfo = "MDI1-117-Ch-9-LoginKit";
		};
		A191104A30770791008EFF48 /* PBXContainerItemProxy */ = {
			isa = PBXContainerItemProxy;
			containerPortal = A191102A3077078F008EFF48 /* Project object */;
			proxyType = 1;
			remoteGlobalIDString = A19110313077078F008EFF48;
			remoteInfo = "MDI1-117-Ch-9-LoginKit";
		};
/* End PBXContainerItemProxy section */

/* Begin PBXFileReference section */
		A19110323077078F008EFF48 /* MDI1-117-Ch-9-LoginKit.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "MDI1-117-Ch-9-LoginKit.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		A191103F30770791008EFF48 /* MDI1-117-Ch-9-LoginKitTests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "MDI1-117-Ch-9-LoginKitTests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
		A191104930770791008EFF48 /* MDI1-117-Ch-9-LoginKitUITests.xctest */ = {isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = "MDI1-117-Ch-9-LoginKitUITests.xctest"; sourceTree = BUILT_PRODUCTS_DIR; };
/* End PBXFileReference section */

/* Begin PBXFileSystemSynchronizedRootGroup section */
		A19110343077078F008EFF48 /* MDI1-117-Ch-9-LoginKit */ = {
			isa = PBXFileSystemSynchronizedRootGroup;
			path = "MDI1-117-Ch-9-LoginKit";
			sourceTree = "<group>";
		};
		A191104230770791008EFF48 /* MDI1-117-Ch-9-LoginKitTests */ = {
			isa = PBXFileSystemSynchronizedRootGroup;
			path = "MDI1-117-Ch-9-LoginKitTests";
			sourceTree = "<group>";
		};
		A191104C30770791008EFF48 /* MDI1-117-Ch-9-LoginKitUITests */ = {
			isa = PBXFileSystemSynchronizedRootGroup;
			path = "MDI1-117-Ch-9-LoginKitUITests";
			sourceTree = "<group>";
		};
/* End PBXFileSystemSynchronizedRootGroup section */

/* Begin PBXFrameworksBuildPhase section */
		A191102F3077078F008EFF48 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			files = (
			);
		};
		A191103C30770791008EFF48 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			files = (
			);
		};
		A191104630770791008EFF48 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			files = (
			);
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		A19110293077078F008EFF48 = {
			isa = PBXGroup;
			children = (
				A19110343077078F008EFF48 /* MDI1-117-Ch-9-LoginKit */,
				A191104230770791008EFF48 /* MDI1-117-Ch-9-LoginKitTests */,
				A191104C30770791008EFF48 /* MDI1-117-Ch-9-LoginKitUITests */,
				A19110333077078F008EFF48 /* Products */,
			);
			sourceTree = "<group>";
		};
		A19110333077078F008EFF48 /* Products */ = {
			isa = PBXGroup;
			children = (
				A19110323077078F008EFF48 /* MDI1-117-Ch-9-LoginKit.app */,
				A191103F30770791008EFF48 /* MDI1-117-Ch-9-LoginKitTests.xctest */,
				A191104930770791008EFF48 /* MDI1-117-Ch-9-LoginKitUITests.xctest */,
			);
			name = Products;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		A19110313077078F008EFF48 /* MDI1-117-Ch-9-LoginKit */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = A191105130770791008EFF48 /* Build configuration list for PBXNativeTarget "MDI1-117-Ch-9-LoginKit" */;
			buildPhases = (
				A191102E3077078F008EFF48 /* Sources */,
				A191102F3077078F008EFF48 /* Frameworks */,
				A19110303077078F008EFF48 /* Resources */,
			);
			buildRules = (
			);
			fileSystemSynchronizedGroups = (
				A19110343077078F008EFF48 /* MDI1-117-Ch-9-LoginKit */,
			);
			name = "MDI1-117-Ch-9-LoginKit";
			productName = "MDI1-117-Ch-9-LoginKit";
			productReference = A19110323077078F008EFF48 /* MDI1-117-Ch-9-LoginKit.app */;
			productType = "com.apple.product-type.application";
		};
		A191103E30770791008EFF48 /* MDI1-117-Ch-9-LoginKitTests */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = A191105430770791008EFF48 /* Build configuration list for PBXNativeTarget "MDI1-117-Ch-9-LoginKitTests" */;
			buildPhases = (
				A191103B30770791008EFF48 /* Sources */,
				A191103C30770791008EFF48 /* Frameworks */,
				A191103D30770791008EFF48 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
				A191104130770791008EFF48 /* PBXTargetDependency */,
			);
			fileSystemSynchronizedGroups = (
				A191104230770791008EFF48 /* MDI1-117-Ch-9-LoginKitTests */,
			);
			name = "MDI1-117-Ch-9-LoginKitTests";
			productName = "MDI1-117-Ch-9-LoginKitTests";
			productReference = A191103F30770791008EFF48 /* MDI1-117-Ch-9-LoginKitTests.xctest */;
			productType = "com.apple.product-type.bundle.unit-test";
		};
		A191104830770791008EFF48 /* MDI1-117-Ch-9-LoginKitUITests */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = A191105730770791008EFF48 /* Build configuration list for PBXNativeTarget "MDI1-117-Ch-9-LoginKitUITests" */;
			buildPhases = (
				A191104530770791008EFF48 /* Sources */,
				A191104630770791008EFF48 /* Frameworks */,
				A191104730770791008EFF48 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
				A191104B30770791008EFF48 /* PBXTargetDependency */,
			);
			fileSystemSynchronizedGroups = (
				A191104C30770791008EFF48 /* MDI1-117-Ch-9-LoginKitUITests */,
			);
			name = "MDI1-117-Ch-9-LoginKitUITests";
			productName = "MDI1-117-Ch-9-LoginKitUITests";
			productReference = A191104930770791008EFF48 /* MDI1-117-Ch-9-LoginKitUITests.xctest */;
			productType = "com.apple.product-type.bundle.ui-testing";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		A191102A3077078F008EFF48 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1640;
				LastUpgradeCheck = 1640;
				TargetAttributes = {
					A19110313077078F008EFF48 = {
						CreatedOnToolsVersion = 16.4;
					};
					A191103E30770791008EFF48 = {
						CreatedOnToolsVersion = 16.4;
						TestTargetID = A19110313077078F008EFF48;
					};
					A191104830770791008EFF48 = {
						CreatedOnToolsVersion = 16.4;
						TestTargetID = A19110313077078F008EFF48;
					};
				};
			};
			buildConfigurationList = A191102D3077078F008EFF48 /* Build configuration list for PBXProject "MDI1-117-Ch-9-LoginKit" */;
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = A19110293077078F008EFF48;
			minimizedProjectReferenceProxies = 1;
			preferredProjectObjectVersion = 77;
			productRefGroup = A19110333077078F008EFF48 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				A19110313077078F008EFF48 /* MDI1-117-Ch-9-LoginKit */,
				A191103E30770791008EFF48 /* MDI1-117-Ch-9-LoginKitTests */,
				A191104830770791008EFF48 /* MDI1-117-Ch-9-LoginKitUITests */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		A19110303077078F008EFF48 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			files = (
			);
		};
		A191103D30770791008EFF48 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			files = (
			);
		};
		A191104730770791008EFF48 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			files = (
			);
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		A191102E3077078F008EFF48 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			files = (
			);
		};
		A191103B30770791008EFF48 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			files = (
			);
		};
		A191104530770791008EFF48 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			files = (
			);
		};
/* End PBXSourcesBuildPhase section */

/* Begin PBXTargetDependency section */
		A191104130770791008EFF48 /* PBXTargetDependency */ = {
			isa = PBXTargetDependency;
			target = A19110313077078F008EFF48 /* MDI1-117-Ch-9-LoginKit */;
			targetProxy = A191104030770791008EFF48 /* PBXContainerItemProxy */;
		};
		A191104B30770791008EFF48 /* PBXTargetDependency */ = {
			isa = PBXTargetDependency;
			target = A19110313077078F008EFF48 /* MDI1-117-Ch-9-LoginKit */;
			targetProxy = A191104A30770791008EFF48 /* PBXContainerItemProxy */;
		};
/* End PBXTargetDependency section */

/* Begin XCBuildConfiguration section */
		A191104F30770791008EFF48 /* Debug configuration for PBXProject "MDI1-117-Ch-9-LoginKit" */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		A191105030770791008EFF48 /* Release configuration for PBXProject "MDI1-117-Ch-9-LoginKit" */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SWIFT_COMPILATION_MODE = wholemodule;
			};
			name = Release;
		};
		A191105230770791008EFF48 /* Debug configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKit" */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;

				ENABLE_PREVIEWS = YES;

				GENERATE_INFOPLIST_FILE = YES;
				"INFOPLIST_KEY_UIApplicationSceneManifest_Generation[sdk=iphoneos*]" = YES;
				"INFOPLIST_KEY_UIApplicationSceneManifest_Generation[sdk=iphonesimulator*]" = YES;
				"INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents[sdk=iphoneos*]" = YES;
				"INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents[sdk=iphonesimulator*]" = YES;
				"INFOPLIST_KEY_UILaunchScreen_Generation[sdk=iphoneos*]" = YES;
				"INFOPLIST_KEY_UILaunchScreen_Generation[sdk=iphonesimulator*]" = YES;
				"INFOPLIST_KEY_UIStatusBarStyle[sdk=iphoneos*]" = UIStatusBarStyleDefault;
				"INFOPLIST_KEY_UIStatusBarStyle[sdk=iphonesimulator*]" = UIStatusBarStyleDefault;
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LD_RUNPATH_SEARCH_PATHS = "@executable_path/Frameworks";


				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "com.andrewreyna.LoginKit16";
				PRODUCT_NAME = "$(TARGET_NAME)";

				SDKROOT = iphoneos;

				SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";

				SWIFT_EMIT_LOC_STRINGS = YES;

				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";

			};
			name = Debug;
		};
		A191105330770791008EFF48 /* Release configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKit" */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;

				ENABLE_PREVIEWS = YES;

				GENERATE_INFOPLIST_FILE = YES;
				"INFOPLIST_KEY_UIApplicationSceneManifest_Generation[sdk=iphoneos*]" = YES;
				"INFOPLIST_KEY_UIApplicationSceneManifest_Generation[sdk=iphonesimulator*]" = YES;
				"INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents[sdk=iphoneos*]" = YES;
				"INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents[sdk=iphonesimulator*]" = YES;
				"INFOPLIST_KEY_UILaunchScreen_Generation[sdk=iphoneos*]" = YES;
				"INFOPLIST_KEY_UILaunchScreen_Generation[sdk=iphonesimulator*]" = YES;
				"INFOPLIST_KEY_UIStatusBarStyle[sdk=iphoneos*]" = UIStatusBarStyleDefault;
				"INFOPLIST_KEY_UIStatusBarStyle[sdk=iphonesimulator*]" = UIStatusBarStyleDefault;
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone = "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight";
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;
				LD_RUNPATH_SEARCH_PATHS = "@executable_path/Frameworks";


				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "com.andrewreyna.LoginKit16";
				PRODUCT_NAME = "$(TARGET_NAME)";

				SDKROOT = iphoneos;

				SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";

				SWIFT_EMIT_LOC_STRINGS = YES;

				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";

			};
			name = Release;
		};
		A191105530770791008EFF48 /* Debug configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKitTests" */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				BUNDLE_LOADER = "$(TEST_HOST)";
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;

				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "com.andrewreyna.LoginKit16Tests";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;

				SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";

				SWIFT_EMIT_LOC_STRINGS = NO;

				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/MDI1-117-Ch-9-LoginKit.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/MDI1-117-Ch-9-LoginKit";

			};
			name = Debug;
		};
		A191105630770791008EFF48 /* Release configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKitTests" */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				BUNDLE_LOADER = "$(TEST_HOST)";
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;

				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "com.andrewreyna.LoginKit16Tests";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;

				SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";

				SWIFT_EMIT_LOC_STRINGS = NO;

				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				TEST_HOST = "$(BUILT_PRODUCTS_DIR)/MDI1-117-Ch-9-LoginKit.app/$(BUNDLE_EXECUTABLE_FOLDER_PATH)/MDI1-117-Ch-9-LoginKit";

			};
			name = Release;
		};
		A191105830770791008EFF48 /* Debug configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKitUITests" */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;

				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "com.andrewreyna.LoginKit16UITests";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;

				SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";

				SWIFT_EMIT_LOC_STRINGS = NO;

				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				TEST_TARGET_NAME = "MDI1-117-Ch-9-LoginKit";

			};
			name = Debug;
		};
		A191105930770791008EFF48 /* Release configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKitUITests" */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				GENERATE_INFOPLIST_FILE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 17.0;

				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "com.andrewreyna.LoginKit16UITests";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SDKROOT = iphoneos;

				SUPPORTED_PLATFORMS = "iphoneos iphonesimulator";

				SWIFT_EMIT_LOC_STRINGS = NO;

				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
				TEST_TARGET_NAME = "MDI1-117-Ch-9-LoginKit";

			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		A191102D3077078F008EFF48 /* Build configuration list for PBXProject "MDI1-117-Ch-9-LoginKit" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				A191104F30770791008EFF48 /* Debug configuration for PBXProject "MDI1-117-Ch-9-LoginKit" */,
				A191105030770791008EFF48 /* Release configuration for PBXProject "MDI1-117-Ch-9-LoginKit" */,
			);
			defaultConfigurationName = Release;
		};
		A191105130770791008EFF48 /* Build configuration list for PBXNativeTarget "MDI1-117-Ch-9-LoginKit" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				A191105230770791008EFF48 /* Debug configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKit" */,
				A191105330770791008EFF48 /* Release configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKit" */,
			);
			defaultConfigurationName = Release;
		};
		A191105430770791008EFF48 /* Build configuration list for PBXNativeTarget "MDI1-117-Ch-9-LoginKitTests" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				A191105530770791008EFF48 /* Debug configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKitTests" */,
				A191105630770791008EFF48 /* Release configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKitTests" */,
			);
			defaultConfigurationName = Release;
		};
		A191105730770791008EFF48 /* Build configuration list for PBXNativeTarget "MDI1-117-Ch-9-LoginKitUITests" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				A191105830770791008EFF48 /* Debug configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKitUITests" */,
				A191105930770791008EFF48 /* Release configuration for PBXNativeTarget "MDI1-117-Ch-9-LoginKitUITests" */,
			);
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = A191102A3077078F008EFF48 /* Project object */;

}
```


## MDI1-117-Ch-9-LoginKit.xcodeproj/project.xcworkspace/contents.xcworkspacedata

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Workspace
   version = "1.0">
   <FileRef
      location = "self:">
   </FileRef>
</Workspace>
```


## MDI1-117-Ch-9-LoginKit.xcodeproj/xcshareddata/xcschemes/MDI1-117-Ch-9-LoginKit.xcscheme

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
   LastUpgradeVersion = "1640"
   version = "1.7">
   <BuildAction
      parallelizeBuildables = "YES"
      buildImplicitDependencies = "YES">
      <BuildActionEntries>
         <BuildActionEntry
            buildForTesting = "YES"
            buildForRunning = "YES"
            buildForProfiling = "YES"
            buildForArchiving = "YES"
            buildForAnalyzing = "YES">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "A19110313077078F008EFF48"
               BuildableName = "MDI1-117-Ch-9-LoginKit.app"
               ReferencedContainer = "container:MDI1-117-Ch-9-LoginKit.xcodeproj">
            </BuildableReference>
         </BuildActionEntry>
      </BuildActionEntries>
   </BuildAction>
   <TestAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      shouldUseLaunchSchemeArgsEnv = "YES"
      shouldAutocreateTestPlan = "YES">
      <Testables>
         <TestableReference
            skipped = "NO"
            parallelizable = "NO">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "A191103E30770791008EFF48"
               BuildableName = "MDI1-117-Ch-9-LoginKitTests.xctest"
               ReferencedContainer = "container:MDI1-117-Ch-9-LoginKit.xcodeproj">
            </BuildableReference>
         </TestableReference>
         <TestableReference
            skipped = "NO"
            parallelizable = "NO">
            <BuildableReference
               BuildableIdentifier = "primary"
               BlueprintIdentifier = "A191104830770791008EFF48"
               BuildableName = "MDI1-117-Ch-9-LoginKitUITests.xctest"
               ReferencedContainer = "container:MDI1-117-Ch-9-LoginKit.xcodeproj">
            </BuildableReference>
         </TestableReference>
      </Testables>
   </TestAction>
   <LaunchAction
      buildConfiguration = "Debug"
      selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
      selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
      launchStyle = "0"
      useCustomWorkingDirectory = "NO"
      ignoresPersistentStateOnLaunch = "NO"
      debugDocumentVersioning = "YES"
      debugServiceExtension = "internal"
      allowLocationSimulation = "YES"
      queueDebuggingEnabled = "No">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "A19110313077078F008EFF48"
            BuildableName = "MDI1-117-Ch-9-LoginKit.app"
            ReferencedContainer = "container:MDI1-117-Ch-9-LoginKit.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </LaunchAction>
   <ProfileAction
      buildConfiguration = "Release"
      shouldUseLaunchSchemeArgsEnv = "YES"
      savedToolIdentifier = ""
      useCustomWorkingDirectory = "NO"
      debugDocumentVersioning = "YES">
      <BuildableProductRunnable
         runnableDebuggingMode = "0">
         <BuildableReference
            BuildableIdentifier = "primary"
            BlueprintIdentifier = "A19110313077078F008EFF48"
            BuildableName = "MDI1-117-Ch-9-LoginKit.app"
            ReferencedContainer = "container:MDI1-117-Ch-9-LoginKit.xcodeproj">
         </BuildableReference>
      </BuildableProductRunnable>
   </ProfileAction>
   <AnalyzeAction
      buildConfiguration = "Debug">
   </AnalyzeAction>
   <ArchiveAction
      buildConfiguration = "Release"
      revealArchiveInOrganizer = "YES">
   </ArchiveAction>
</Scheme>
```


## MDI1-117-Ch-9-LoginKitTests/MDI1_117_Ch_9_LoginKitTests.swift

```swift
import XCTest
@testable import MDI1_117_Ch_9_LoginKit

final class MDI1_117_Ch_9_LoginKitTests: XCTestCase {
    @MainActor
    func test_validLogin_setsLoggedInUser() async {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        let store = SessionStore(defaults: defaults)
        defer { store.clear() }
        let viewModel = LoginViewModel(authService: AuthService(), sessionStore: store)
        viewModel.email = "test@mail.com"
        viewModel.password = "test1234"

        await viewModel.login()

        XCTAssertEqual(viewModel.loggedInUser?.email, "test@mail.com")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    @MainActor
    func test_invalidLogin_setsErrorAndDoesNotLogIn() async {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        let store = SessionStore(defaults: defaults)
        defer { store.clear() }
        let viewModel = LoginViewModel(authService: AuthService(), sessionStore: store)
        viewModel.email = "test@mail.com"
        viewModel.password = "wrong-password"

        await viewModel.login()

        XCTAssertNil(viewModel.loggedInUser)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email or password")
        XCTAssertFalse(viewModel.isLoading)
    }
}
```


## MDI1-117-Ch-9-LoginKitUITests/MDI1_117_Ch_9_LoginKitUITests.swift

```swift
import XCTest

final class MDI1_117_Ch_9_LoginKitUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func test_successfulLogin_navigatesToDashboard() {
        let app = XCUIApplication()
        app.launchArguments = ["-UITesting-Reset"]
        app.launch()

        let emailField = app.textFields["email_field"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("test@mail.com")

        let passwordField = app.secureTextFields["password_field"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 5))
        passwordField.tap()
        passwordField.typeText("test1234")

        app.buttons["login_button"].tap()
        XCTAssertTrue(app.staticTexts["welcome_label"].waitForExistence(timeout: 5))
    }

    @MainActor
    func test_invalidLogin_showsError() {
        let app = XCUIApplication()
        app.launchArguments = ["-UITesting-Reset"]
        app.launch()

        let emailField = app.textFields["email_field"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("test@mail.com")
        let passwordField = app.secureTextFields["password_field"]
        passwordField.tap()
        passwordField.typeText("wrong-password")
        app.buttons["login_button"].tap()

        let errorLabel = app.staticTexts["error_label"]
        XCTAssertTrue(errorLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(errorLabel.label, "Invalid email or password")
        XCTAssertFalse(app.staticTexts["welcome_label"].exists)
    }

    @MainActor
    func test_rememberMe_preservesEmailAfterRelaunch() {
        let app = XCUIApplication()
        app.launchArguments = ["-UITesting-Reset"]
        app.launch()

        let emailField = app.textFields["email_field"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("test@mail.com")
        let passwordField = app.secureTextFields["password_field"]
        passwordField.tap()
        passwordField.typeText("test1234")
        app.switches["remember_me_toggle"].tap()
        app.buttons["login_button"].tap()
        XCTAssertTrue(app.staticTexts["welcome_label"].waitForExistence(timeout: 5))

        app.terminate()
        app.launchArguments = []
        app.launch()
        let rememberedEmailField = app.textFields["email_field"]
        XCTAssertTrue(rememberedEmailField.waitForExistence(timeout: 5))
        XCTAssertEqual(rememberedEmailField.value as? String, "test@mail.com")
    }
}
```
