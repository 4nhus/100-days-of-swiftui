//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Anh Nguyen on 5/2/2024.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    
    let filter: FilterType
    
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @State var editProspect: Prospect!
    @State private var isShowingSortContacts = false
    @State private var sort = [SortDescriptor(\Prospect.name)]
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack {
            ProspectsListView(filter: filter, sort: sort, editProspect: $editProspect)
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Scan", systemImage: "qrcode.viewfinder") {
                            isShowingScanner = true
                        }
                    }
                    
                    ToolbarItemGroup(placement: .topBarLeading) {
                        EditButton()
                        
                        Button("Sort contacts") {
                            isShowingSortContacts = true
                        }
                    }
                    
                    if selectedProspects.isEmpty == false {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Delete Selected", action: delete)
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
                }
                .sheet(item: $editProspect) { prospect in
                    EditView(prospect: prospect)
                }
                .confirmationDialog("Sort contacts by", isPresented: $isShowingSortContacts) {
                    Button("Name") {
                        sort = [SortDescriptor(\Prospect.name)]
                    }
                    Button("Most recent") {
                        sort = [SortDescriptor(\Prospect.dateAdded)]
                    }
                }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false, dateAdded: Date.now)
            person.name = details[0]
            person.emailAddress = details[1]
            
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
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

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
