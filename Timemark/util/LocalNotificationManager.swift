//
//  LocalNotificationManager.swift
//  Timemark
//
//  Created by Julian Wright on 8/12/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import Foundation
import UserNotifications

struct LocalNotification {
    var id: String
    var title: String
    var delay: Int
}

class LocalNotificationManager {
    var notifications = [LocalNotification]()
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert, .sound]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
        }
    }
    
    func addNotification(title: String) -> Void {
        notifications.append(LocalNotification(id: UUID().uuidString, title: title, delay: 0))
    }
    
    func addNotification(title: String, delay: Int) -> Void {
        notifications.append(LocalNotification(id: UUID().uuidString, title: title, delay: delay))
    }
    
    func clearNotifications() -> Void {
        notifications = [LocalNotification]()
    }
    
    func scheduleNotifications() -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            if let soundName = UserDefaults.standard.string(forKey: "alarm_name") {
                guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundName + ".mp3" ))
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(notification.delay), repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
        }
        clearNotifications()
    }
    
    func schedule() -> Void {
        print(notifications)
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }
}
