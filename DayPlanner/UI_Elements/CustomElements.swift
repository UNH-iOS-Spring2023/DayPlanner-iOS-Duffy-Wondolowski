//
//  CustomElements.swift
//  DayPlanner
//
//  Created by Spencer Wondolowski on 3/5/23.
//

import SwiftUI

struct CustomElements: View {
        
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
}

struct CustomElements_Previews: PreviewProvider {
    static var previews: some View {
        CustomElements()
    }
}

struct CustomTextField: View{
    
    var placeHolder: String
    var imageName: String
    var bColor: String
    var tOpacity: Double
    @Binding var value: String
    
    var body: some View{
        HStack{
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(.leading, 20)
                .foregroundColor(Color(bColor).opacity(tOpacity))
            
            if placeHolder == "Password" || placeHolder == "Confirm Password" {
                ZStack(alignment: .leading){
                    if value.isEmpty {
                        Text(placeHolder)
                            .foregroundColor(Color(bColor).opacity(tOpacity))
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }
                    
                    SecureField("", text: $value)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .frame(height: 45)
                }
            }
            
            else {
                ZStack(alignment: .leading) {
                    if value.isEmpty{
                        Text(placeHolder)
                            .foregroundColor(Color(bColor).opacity(tOpacity))
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }
                    
                    TextField("", text: $value)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .frame(height: 45)
                        .foregroundColor(Color(bColor))
                    
                }
            }
        }.overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.blue, lineWidth: 2)
        )        
    }
}

