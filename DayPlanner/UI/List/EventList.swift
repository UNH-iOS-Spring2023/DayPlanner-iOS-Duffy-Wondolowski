//
//  List.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

struct EventList: View {
    @EnvironmentObject private var app: AppVariables
    @State var draggedEvent: Event?
    
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
            ForEach(app.eventList, id: \.self) {
                (event: Event) in VStack { ListItem(event: event) }
                    .onDrag {
                        draggedEvent = event
                        return NSItemProvider()
                    }
                    .onDrop(of: [.item], delegate: ScrollDropDelegate(droppedOnEvent: event, eventList: $app.eventList, draggedEvent: $draggedEvent))
            }
        }
        
        if (app.isEventEdit) {
            EventEdit()
        } else {
            ZStack {
                list
                    .padding(5)
                button
            }
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        app.eventList.move(fromOffsets: source, toOffset: destination)
    }
    
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
            .environmentObject(AppVariables())
    }
}
