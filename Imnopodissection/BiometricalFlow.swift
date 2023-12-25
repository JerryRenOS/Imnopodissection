//
//  BiometricalFlow.swift
//  Imnopodissection
//
//  Created by Yan Ren on 12/22/23.
//

import OmniDataManager
import OmniNavigation
import Login
import OmniMobileAppCommonModule

private protocol BiometricalFlowProtocol {
    associatedtype UserBioAuthStatus
    associatedtype PotentialActions
    
    @discardableResult
    static func biometricalPath(bioAuthenticationCallback: @escaping (() -> Void)) -> UserBioAuthStatus
    static func conditionallyNavigatingIntoBranchCheckinFeature(bioAuthedInCurrentSession: Bool, bioEnrolledInUsbApp: Bool)
}

/// This structure serves as a checkpoint to coordinate the user flow to different directions based on the user's bio-authentication and bio-enrollment status.
/// In addition, it presents alerts popups with selectable actions, and handles navigation for each possible scenario.

public struct BranchCheckinBiometricalFlow: BiometricalFlowProtocol {
    typealias BiometricalFlow = ConstantsForBranchCheckinModule.BiometricalFlow
    
    public enum UserBioAuthStatus {
        case usedInSession
        case enabledInAppNotUsedInSession
        case enrolledOnDeviceNotEnabledInApp
        case notEnrolledOnDevice
    }
    
    @discardableResult
    static public func biometricalPath(bioAuthenticationCallback: @escaping (() -> Void)) -> UserBioAuthStatus {
        let bioEnrolledInUsbApp = AuthenticationStateManager.shared.isBiometricEnrolled ?? false
        
        if (TransmitSDKController.sharedInstance.currentAuthenticationMethod == AuthenticationMethod.fingerprint || TransmitSDKController.sharedInstance.currentAuthenticationMethod == AuthenticationMethod.faceid) && bioEnrolledInUsbApp {
            LogUtil.logInfo("Fingerprint or FaceID authenticated in current session")
            return .usedInSession
        } else {
            let bioEnrolledOnDevice = BiometricWorker.retrieveInfo().deviceEnrolled
            LogUtil.logInfo(TransmitSDKController.sharedInstance.currentAuthenticationMethod?.rawValue ?? "non-biometrical")
            
            if bioEnrolledInUsbApp && bioEnrolledOnDevice {
                bioAuthenticationCallback()
                LogUtil.logInfo("User is enrolled in bio-authentication inside the application.")
                return .enabledInAppNotUsedInSession
            } else if bioEnrolledOnDevice && !bioEnrolledInUsbApp {
                AlertHandlerView.showAlertWithActions(title: BiometricalFlow.InstructionalTexts.biometricsRequired, message: BiometricalFlow.InstructionalTexts.mustLoginWithFaceOrTouch, actions: potentialAlertActionsCreation(actionNeeded: .enableInsideApp))
                LogUtil.logInfo("User is not enrolled in bio-authentication inside the application, but enrolled on the ios device.")
                return .enrolledOnDeviceNotEnabledInApp
            } else {
                AlertHandlerView.showAlertWithActions(title: BiometricalFlow.InstructionalTexts.biometricsRequired, message: BiometricalFlow.InstructionalTexts.mustLoginWithFaceOrTouch, actions: potentialAlertActionsCreation(actionNeeded: .goToPhoneSettings))
                LogUtil.logInfo("User is not enrolled in bio-authentication on the ios device.")
                return .notEnrolledOnDevice
            }
        }
    }
    
    enum PotentialActions {
        case enableInsideApp
        case goToPhoneSettings
    }

    private static func potentialAlertActionsCreation(actionNeeded: PotentialActions) -> [AlertAction] {
        let enableAction = AlertAction(title: BiometricalFlow.ActionPrompts.enable, style: .default) {
            USBNavigator.shared.resetNavigationStack(withModule: .loginPreferences)
        }
        let gobackAction = AlertAction(title: BiometricalFlow.ActionPrompts.goback, style: .cancel) {
            USBNavigator.shared.resetNavigationStack(withModule: .dashboard)
        }
        let goToSettingsAction = AlertAction(title: BiometricalFlow.ActionPrompts.setup, style: .default) {
            if let iPhoneSettingsUrl = URL(string: UIApplication.openSettingsURLString) {
                USBNavigator.shared.resetNavigationStack(withModule: .dashboard)
                UIApplication.shared.open(iPhoneSettingsUrl)
            }
        }
        switch actionNeeded {
        case .enableInsideApp:
            return [enableAction, gobackAction]
        case .goToPhoneSettings:
            return [goToSettingsAction, gobackAction]
        }
    }
}

extension BranchCheckinBiometricalFlow {
    public static func conditionallyNavigatingIntoBranchCheckinFeature(bioAuthedInCurrentSession: Bool, bioEnrolledInUsbApp: Bool) {
        
        guard !BranchCheckinViewModel.checkinSuccess.value else {
            USBNavigator.shared.navigate(screen: ConstantsForBranchCheckinModule.ViewRelated.successIndicator,
                                         module: ConstantsForBranchCheckinModule.ViewRelated.storyboardName,
                                         bundleName: BundleIDs.branchCheckinBundleName)
            return
        }
        guard let dontShowAgain = MobileIDUserPreferenceDataManager.getFeatureValueForUser(featureKey: .dontShowGetStartedScreenAgain) as? Bool, dontShowAgain else {
            USBNavigator.shared.navigate(screen: ConstantsForBranchCheckinModule.ViewRelated.mobileIdFeatureOverview, module: ConstantsForBranchCheckinModule.ViewRelated.storyboardName, bundleName: BundleIDs.branchCheckinBundleName)
            return
        }
        
        guard let iAgree = MobileIDUserPreferenceDataManager.getFeatureValueForUser(featureKey: .iAgreeWithTermsAndConditionsClicked) as? Bool, iAgree else {
            USBNavigator.shared.navigate(screen: ConstantsForBranchCheckinModule.ViewRelated.termsAndConditionsWelcome, module: ConstantsForBranchCheckinModule.ViewRelated.storyboardName, bundleName: BundleIDs.branchCheckinBundleName)
            return
        }

        switch bioEnrolledInUsbApp && bioAuthedInCurrentSession {
        case true:
            MobileIdBranchCheckInStatusFlow().branchCheckinStatusCheck()
        default:
            /// nav into popups-overlay
            USBNavigator.shared.navigate(screen: ConstantsForBranchCheckinModule.ViewRelated.popupsOverlay,
                                         module: ConstantsForBranchCheckinModule.ViewRelated.storyboardName,
                                         bundleName: BundleIDs.branchCheckinBundleName)
        }
    }
}

final class StepUpAuthentication: BranchCheckinJourneyWorker {
    public func inSessionStepup(navigationalCallback: @escaping (() -> Void)) {
        let preStepUpOriginalAuthenticationMethod = TransmitSDKController.sharedInstance.currentAuthenticationMethod
        invokingTransmitJourney(with: .biometric_stepup, injectableData: [:]) { (_, erro) in
            switch erro == nil {
            case false:
                TransmitSDKController.sharedInstance.currentAuthenticationMethod = preStepUpOriginalAuthenticationMethod
                USBNavigator.shared.resetNavigationStack(withModule: .dashboard)
            default:
                navigationalCallback()
            }
        }
    }
}
