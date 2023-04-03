//
//  PlannerModel.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/19/23.
//

import Foundation
import FirebaseFirestoreSwift

struct PlannerModel: Equatable, Identifiable, Codable {
    @DocumentID var id: String?
    var startTime: String = ""
//    var endTime: String = ""
    var eventName: String = ""
}


//class PlannerModel: ObservableObject{
//    let id: String
//
//    @Published var name: String = ""
//    @Published var time: String = ""
//
//    required init(id: String, data: [String: Any]) {
//        let name = data["name"] as? String != nil ? data["name"] as! String: ""
//        let time = data["time"] as? String != nil ? data["time"] as! String: ""
//
//        self.id = id
//        self.name = name
//        self.time = time
//    }
//}

//class PlannerModel : ObservableObject {
//    @Published var events = [Event]()
//
//    init(){
//        let eventsRef = Database.database().reference().child("Events")
//        eventsRef.observe(.value) {snapshot in
//            guard let data = snapshot.value as? [String: Any] else {return}
//            var events = [Event]()
//            for (key, value) in data {
//                if let eventData = value as? [String: Any],
//                   let eventName = eventData["name"] as? String,
//                   let eventDate = eventData["date"] as? TimeInterval {
//                    events.append(event)
//                }
//            }
//            self.events = events.sorted {$0.date < $1.date}
//        }
//    }
//}

//let db = Firestore.firestore()
//
//private func GetEventDate(){
//    let userUID = Auth.auth().currentUser?.uid
//    
//    db.collection("Users").document(userUID!).collection("Events").getDocument { (snapshot, error) in
//        if error != nil {
//            print("Error getting Events")
//        } else {
//            
//        }
//    }
//}


//@ObservableObject var viewModel = PlannerModel()
//var body: Some View {
//    List(viewModel.events) { event in
//        VStack(alignment: .leading) {
//            Text(event.name)
//            Text(event.date, style: .date)
//        }
//    }
//}
