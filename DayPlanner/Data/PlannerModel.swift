//
//  PlannerModel.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/19/23.
//

import Foundation

class PlannerModel: ObservableObject{
    let id: String
    
    @Published var name: String = ""
    @Published var time: String = ""
    
    required init(id: String, data: [String: Any]) {
        let name = data["name"] as? String != nil ? data["name"] as! String: ""
        let time = data["time"] as? String != nil ? data["time"] as! String: ""
        
        self.id = id
        self.name = name
        self.time = time
    }
}
