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

/**
Colors used throughout the Calendar View.

   - Parameters:
      - nonWeekendBackground: background color used for entire week day
      - weekendBackground: background color used for entire weekend day
      - nonWeekendLabel: the label text color for week days
      - notTodayLabel: the label text color for days that are not today
      - todayLabel: the label text color for the current day
      - monthDivider: The divider color used between each month
      - titleDivider: There's a line between day of the month and milestones. This is the color
*/
@available(iOS 15.0, *)
public struct LinearColors {
    public let nonWeekendBackground: Color
    public let weekendBackground: Color
    public let nonWeekendLabel: Color
    public let weekendLabel: Color
    public let todayLabel: Color
    public let todayBackground: Color
    public let divider: Color
    public let monthDivider: Color
    public let titleDivider: Color
    
    public init(nonWeekendBackground: Color?, weekendBackground: Color?, nonWeekendLabel: Color?, weekendLabel: Color?, todayLabel: Color?, todayBackground: Color?, divider: Color?, monthDivider: Color?, titleSeparator: Color?) {
        self.nonWeekendBackground = nonWeekendBackground ?? .white
        self.weekendBackground = weekendBackground ?? .white
        self.nonWeekendLabel = nonWeekendLabel ?? .white
        self.weekendLabel = weekendLabel ?? .white
        self.todayLabel = todayLabel ?? .white
        self.todayBackground = todayBackground ?? .white
        self.divider = divider ?? .white
        self.monthDivider = monthDivider ?? .white
        self.titleDivider = titleSeparator ?? .white
    }
}

@available(iOS 15.0, *)
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
@available(iOS 15.0, *)
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
        let sameDay: Bool = Calendar.current.compare(lhs.date, to: rhs.date, toGranularity: .day) == .orderedSame
        return sameDay && lhs.milestones == rhs.milestones
    }
    
    public static func < (lhs: MilestoneDay, rhs: MilestoneDay) -> Bool {
        return lhs.date < rhs.date
    }
}

/**
 Milestone items are used to display in the calendar view. Must be equatable.
 
 - Parameters:
 - title: Title of the milestone.
 - subTitle: Optional separated by "-" from title ex: "title - subtitle"
 - color: used for milestone background color. Does not have a default value
 - date: used to put the milestone in the right day
 - id: NSManagedObjectID (used on MilestoneDelegate)
 - image: Optional image. Must be 10x10. Added at end of titles. ex. "title - second title (image)"
 */
@available(iOS 15.0, *)
public struct MilestoneItem: Equatable, Identifiable {
    public let title: String
    public let subTitle: String?
    public let color: Color
    public let date: Date
    public let id: NSManagedObjectID
    public let image: UIImage?
    
    public init(title: String, subTitle: String? = nil, color: Color, date: Date, objectId: NSManagedObjectID, image: UIImage? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.color = color
        self.date = date
        self.id = objectId
        self.image = image
    }
    
    public static func ==(lhs: MilestoneItem, rhs: MilestoneItem) -> Bool {
        return lhs.id == rhs.id
    }
}

#endif
