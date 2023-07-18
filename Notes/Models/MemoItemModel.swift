//
//  MemoItemModel.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 29.06.2023.
//

import Foundation
import UserNotifications

public class MemoItemModel {
    
    public var dueDate: Date?
    public var addDate: Date?
    public var id: UUID?
    public var label: String?
    public var text: String?
    
    public init(dueDate: Date?, addDate: Date?, id: UUID?, text: String?, label: String?) {
        self.dueDate = dueDate
        self.addDate = addDate
        self.id = id
        self.text = text
        self.label = label
    }
    
    public func updateNotifications() {
        guard let dueDate = dueDate else {
                  let notificationId = id?.uuidString ?? ""
                  UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
                  return
              }

        let content = UNMutableNotificationContent()
        content.title = label ?? ""
        content.body = text ?? ""
        content.sound = .default

        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let uuidString = id?.uuidString ?? ""
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            if setting.authorizationStatus == .notDetermined {
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
                    
                }
            }
        }

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

extension MemoItemModel: Hashable {
    public static func == (lhs: MemoItemModel, rhs: MemoItemModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension MemoItemModel: Identifiable { }
