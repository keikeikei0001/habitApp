//
//  DeviceModel.swift
//  habitApp
//
//  Created by 松田圭右 on 2024/04/08.
//

import SwiftUI

class DeviceModel {
    private static var window: UIWindowScene? {
        return UIApplication.shared.connectedScenes.first as? UIWindowScene
    }
    
    static var screenSize: CGRect {
        return window?.screen.bounds ?? CGRect.zero
    }
    
    static var width: CGFloat {
        return screenSize.width
    }
    
    static var height: CGFloat {
        return screenSize.height
    }
}
