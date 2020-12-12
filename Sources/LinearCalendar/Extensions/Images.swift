//
//  Images.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/9/20.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
struct CalendarImages {
    static var blueMilestone: Image = {
        Image("BackArrow", bundle: Bundle.module)
    }()
    
    static var redMilestone: Image = {
        Image("ForwardArrow", bundle: Bundle.module)
    }()
}
