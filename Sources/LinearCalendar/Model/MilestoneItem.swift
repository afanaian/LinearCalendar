//
//  MilestoneItem.swift
//  LinearCalendar
//
//  Created by Alexander Fanaian on 11/7/20.
//

#if os(iOS)

import UIKit
import SwiftUI
import CoreData //TODO: SIR

/** Colors used throughout the Calendar View */
@available(iOS 13.0, *)
public struct LinearColors {
    public let nonWeekendBackground: Color
    public let weekendBackground: Color
    public let nonWeekendLabel: Color
    public let weekendLabel: Color
    public let notTodayLabel: Color
    public let todayLabel: Color
    public let monthDivider: Color
    public let titleDivider: Color
    
    public init(nonWeekendBackground: Color?, weekendBackground: Color?, nonWeekendLabel: Color?, weekendLabel: Color?, notTodayLabel: Color?, todayLabel: Color?, monthDivider: Color?, titleSeparator: Color?) {
        self.nonWeekendBackground = nonWeekendBackground ?? .white
        self.weekendBackground = weekendBackground ?? .white
        self.nonWeekendLabel = nonWeekendLabel ?? .white
        self.weekendLabel = weekendLabel ?? .white
        self.notTodayLabel = notTodayLabel ?? .white
        self.todayLabel = todayLabel ?? .white
        self.monthDivider = monthDivider ?? .white
        self.titleDivider = titleSeparator ?? .white
    }
}

/***
 Colors used for the background of each milestone
 */
@available(iOS 13.0, *)
public enum MilestoneColor: Int {
    case red = 0, green, purple, orange, blue, darkBlue, lightBlue, yellow
    
    var currentColor: Color {
        switch self {
        case .red: return Color("MilestoneRed")
        case .green: return Color("MilestoneGreen")
        case .purple: return Color("MilestonePurple")
        case .orange: return Color("MilestoneOrange")
        case .blue: return Color("MilestoneBlue")
        case .darkBlue: return Color("MilestoneDarkBlue")
        case .lightBlue: return Color("MilestoneLightBlue")
        case .yellow: return Color("MilestoneYellow")
        }
    }
    
    var image: Image {
        switch self {
        case .red:
            return CalendarImages.redMilestone
        case .green:
            return CalendarImages.greenMilestone
        case .purple:
            return CalendarImages.purpleMilestone
        case .orange:
            return CalendarImages.orangeMilestone
        case .blue:
            return CalendarImages.blueMilestone
        case .darkBlue:
            return CalendarImages.darkBlueMilestone
        case .lightBlue:
            return CalendarImages.lightBlueMilestone
        case .yellow:
            return CalendarImages.yellowMilestone
        }
    }
}

@available(iOS 13.0, *)
public class MilestoneMonth: Comparable {
    public var date: Date
    public var milestoneDays: [MilestoneDay]
    
    public init(date: Date, milestoneDays: [MilestoneDay]) {
        self.date = date
        self.milestoneDays = milestoneDays
    }
    
    public static func == (lhs: MilestoneMonth, rhs: MilestoneMonth) -> Bool {
        return lhs.date == rhs.date && lhs.milestoneDays == rhs.milestoneDays
    }
    
    public static func > (lhs: MilestoneMonth, rhs: MilestoneMonth) -> Bool {
        return lhs.date > rhs.date
    }
    
    public static func < (lhs: MilestoneMonth, rhs: MilestoneMonth) -> Bool {
        return lhs.date < rhs.date
    }
}

/**
 MilestoneData - Use a two dimentional array separated by date && milestones
 */
@available(iOS 13.0, *)
public class MilestoneDay: Comparable, Hashable {
    public var date: Date
    public var milestones: [MilestoneItem]?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(date.hashValue)
    }
    
    public init(date: Date, milestones: [MilestoneItem]?) {
        self.date = date
        self.milestones = milestones
    }
    
    public static func == (lhs: MilestoneDay, rhs: MilestoneDay) -> Bool {
        return lhs.date == rhs.date && lhs.milestones == rhs.milestones
    }
    
    public static func < (lhs: MilestoneDay, rhs: MilestoneDay) -> Bool {
        return lhs.date < rhs.date
    }
}

/**
 Milestone items are used to display in the calendar view. Must be equatable.
 - Parameters:
 - Title
 - Second title - separated by - from title ex: "title - second title"
 - Color - used for milestone background color. Does not have a default value. Supported colors: red, green, purple, orange, blue, dark blue, light blue, yellow
 - Date - Used to put the milestone in the right day
 - object ID
 - Image - Optional image. Must be 10x10. Added at end of titles. ex. "title - second title (image)"
 */
@available(iOS 13.0, *)
public struct MilestoneItem: Equatable, Identifiable {
    public let title: String
    public let subTitle: String?
    public let color: MilestoneColor
    public let date: Date
    public let id: NSManagedObjectID
    public let image: UIImage?
    
    public init(title: String, subTitle: String? = nil, color: MilestoneColor, date: Date, objectId: NSManagedObjectID, image: UIImage? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.color = color
        self.date = date
        self.id = objectId
        self.image = image
    }
    
    public static func ==(lhs: MilestoneItem, rhs: MilestoneItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.subTitle == rhs.subTitle
    }
}

#endif
