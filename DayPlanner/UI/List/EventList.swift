//
//  List.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

struct EventList: View {
    @EnvironmentObject private var app: AppVariables
    @State var draggedEvent: Event? = nil
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        //Once again the button is largely copied from the professor
        //But with some changes
        let button = VStack{
            Spacer()
            HStack{
                Spacer()
                Button(action: {app.isEventEdit = true},
                       label: {
                    Text("+")
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color(.systemBlue))
                                .frame(width:50, height:50)
                        )
                        .font(.system(.largeTitle))
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                    
                })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 25, trailing: 25))
            }
        }
        
        let list = ScrollView {
            VStack (spacing: 10) {
                ForEach(app.eventList, id: \.self) {
                    (event: Event) in VStack { ListItem(event: event) }
                        .opacity(event == draggedEvent ? 0.1 : 1)
                        .onDrag {
                            draggedEvent = event
                            return CustomProvider(ended: {draggedEvent = nil})
                        }
                        .onDrop(of: [.item], delegate: ScrollDropDelegate(droppedOnEvent: event, eventList: $app.eventList, draggedEvent: $draggedEvent))
                }
            }
            .animation(.default, value: app.eventList)
        }
        
        if (app.isEventEdit) {
            EventEdit()
        } else {
            ZStack {
                list
                button
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {
                    Persistence.save(events: app.eventList) { result in
                        if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                        }
                    }
                }
            }
//            .onDrop(of: [.item], delegate: DropOutsideDelegate(draggedEvent: $draggedEvent))
        }
    }
    
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
            .environmentObject(AppVariables())
    }
}
