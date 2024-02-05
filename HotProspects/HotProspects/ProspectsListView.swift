//
//  ProspectsListView.swift
//  HotProspects
//
//  Created by Anh Nguyen on 5/2/2024.
//

import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsListView: View {
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    
    let filter: ProspectsView.FilterType
    
    @Binding var editProspect: Prospect!
    
    init(filter: ProspectsView.FilterType, sort: [SortDescriptor<Prospect>] , editProspect: Binding<Prospect?>) {
        self.filter = filter
        self._editProspect = editProspect
        let showContactedOnly = filter == .contacted
        
        if filter != .none {
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: sort)
        } else {
            _prospects = Query(sort: sort)
        }
    }
    
    var body: some View {
        List(prospects) { prospect in
            HStack {
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                if filter == .none && prospect.isContacted {
                    Image(systemName: "person.crop.circle.fill.badge.checkmark")
                        .foregroundStyle(.green)
                }
            }
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
                
                Button("Edit", systemImage: "pencil") {
                    self.editProspect = prospect
                }
                
                if prospect.isContacted {
                    Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)
                    
                    Button("Remind Me", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            /* Sets notification to be sent at 9am, instead of after 5 seconds
             var dateComponents = DateComponents()
             dateComponents.hour = 9
             let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
             */
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}
