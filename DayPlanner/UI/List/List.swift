//
//  List.swift
//  DayPlanner
//
//  Created by Orion Duffy on 3/5/23.
//

import SwiftUI

struct List: View {
    @EnvironmentObject private var app: AppVariables
    
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
        
        ZStack {
            Text("List Page")
                .padding(5)
            button
        }
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        List()
            .environmentObject(AppVariables())
    }
}
