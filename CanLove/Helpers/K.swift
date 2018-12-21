//
//  K.swift
//  CanLove
//
//  Created by Alex on 23/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit

struct K {
    
    //Google maps
    static let gmsServices = "AIzaSyBvFwS-M4C0oI7O9gSPPFNZbUZRFm8Tbec"
    static let policiesCanLoveSite = "https://www.mycanlove.com/politicas/"
    static let stripePublishableKey = "pk_test_WvCJd02AYvoyXFfvXvJ947FA"
    
    // MARK:- Segues from storyboards
    struct segues {
        struct auth {
            static let signupToDogProfileController = "SignupToDogProfileController"
            static let selectProfileControllerToAboutPetController = "SelectProfileToAboutPetController"
            static let meetYourPetToQuizController = "MeetYourPetToQuizController"
            static let quizToResultQuizController = "QuizToResultQuizController"
            static let canPersonalityToMainTabBar = "CanPersonalityToMainTabBar"
            static let aboutToMeetYourPetController = "AboutToMeetYourPetController"
            
        }
        struct startWalkthrough {
            static let startWalkthroughToScheduleWalkThrough = "StartWalkthroughToScheduleWalkThrough"
        }
        
        struct mypets {
            static let myPetToMyPetDetailController = "MyPetToMyPetDetailController"
            static let detailMyPetsToEditPetController = "DetailMyPetsToEditPetController"
        }
        
        struct profile {
            static let profileToAuthController = "ProfileToAuthController"
        }
        
    }
    
    // MARK:- Cells for TableView and collectionview
    struct cellsIdentifiers {
        
        struct table {
            static let quizTableCell = "QuizTableCell"
            static let myPetsTableCell = "MyPetsTableCell"
            static let userCommentsTableCell = "UserCommentsTableCell"
            static let cardsTableCell = "CardsTableCell"
            static let addressesTableCell = "AddressesTableCell"
            static let scheduledWalk = "SheduledWalkTableCell"
            
            
        }
        
        struct collection {
            static let canSizeCollectionCell = "CanSizeCollectionCell"
            static let canTypeCollectionCell = "CanTypeCollectionCell"
            static let lodgingCollectionCell = "LodgingCollectionCell"
            static let choosePetCollectionCell = "ChoosePetCollectionCell"
        }
    }
    
    
    // MARK:- DefaultKeys
    struct defaultKeys {
        struct auth {
            static let signIn = "signInset"
            static let accessToken = "setAccessToken"
            static let refreshToken = "setrRefreshToken"
            static let expiresIn = "setExpiresIn"
        }
        
        struct others {
            static let dateTemp = "setDateTemp"
            static let isNewPet = "isNewPet"
        }
    }
    
    
     // MARK:- Storyboards
    struct storyboards {
        static let menu = "Menu"
        static let auth = "Auth"
        static let walkthrough = "Walkthrough"
        static let lodging = "Lodging"
        static let myPets = "MyPets"
        static let profile = "Profile"
    }
    
    // MARK:- Instances
    struct instances {
        static let selectProfileImageController = "SelectProfileImageController"
        static let mainTabBarController = "MainTabBarController"
        static let setNewWalkThroughController = "SetNewWalkThroughController"
        static let lodgingController = "LodgingController"
        static let myPetsTableController = "MyPetsTableController"
        static let profileController = "ProfileController"
    }
    
    
    // MARK:- Titles, subtitles, rawtext
    struct titles {
        static let textConfirmAlert = "Entendido"
        static let alertWrongTitle = "Sucedio algo:"
        static let maximumAssets = "El numero máximo de fotografías ya fue seleccionado"
        static let albumError = "No brindaste permiso para hacer uso de tus fotografías"
        static let cameraError = "No brindaste permiso para hacer uso de la cámara"
        static let deleteRowTitle = "Eliminar"
        static let cardIssueStripe = "Los datos de su tarjeta son incorrectos."
        
        struct actionSheet {
            static let cancel = "Cancelar"
            static let quick = "Rápido"
            static let programmed = "Programado"
        }
        
        struct tabbar {
            static let item1 = "Paseos"
            static let item2 = "Hospedaje"
            static let item3 = "Mis perros"
            static let item4 = "Perfil"
        }
        
        
        
    }
    
    // MARK:- Colors
    struct colors {
        static let selectedImageCanType = "#879CA5"
    }
    
    struct NIB {
            static let datePopup = "DatePopup"
    }
    
    struct others {
        static let dateFormat =  "dd MMMM yyyy"
        static let yearFormat = "yyyy"
        static let month = "MMMM"
    }
    
    
}


/// Enum: You can get images by each size for a Dog.
///*Example: DogSizeIcon.toy.image
enum DogSizeIcon {
   
    case toy
    case small
    case medium
    case big
    case huge
    
    var image: UIImage {
        switch self {
        case .toy: return #imageLiteral(resourceName: "size1")
        case .small: return #imageLiteral(resourceName: "size2")
        case .medium: return #imageLiteral(resourceName: "size3")
        case .big: return #imageLiteral(resourceName: "size4")
        case .huge: return #imageLiteral(resourceName: "size5")
        }
    }
}
