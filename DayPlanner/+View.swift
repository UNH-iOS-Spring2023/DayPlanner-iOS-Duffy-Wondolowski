//
//  +View.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/15/23.
//

import SwiftUI
import UIKit

extension View{
    func getRootViewController() -> UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return.init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return.init()
        }
        
        return root 
    }
}

final class Application_utility {
    static var rootViewController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return.init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return.init()
        }
        
        return root
    }
}
