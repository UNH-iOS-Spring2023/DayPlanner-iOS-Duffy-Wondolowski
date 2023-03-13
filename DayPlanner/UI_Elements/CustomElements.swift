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
    
    var placeHolder     : String
    var imageName       : String
    var bColor          : String
    var tOpacity        : Double
    var width           : CGFloat
    var height          : CGFloat
    var borderColor     : Color
    @Binding var value  : String
    
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
        }
        .frame(width: width, height: height)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(borderColor, lineWidth: 2)
        )        
    }
}




struct Card: View {
    @State private var isTap: Bool = false
    
    let cornerRadius    : CGFloat
    let elevation       : CGFloat
    let width           : CGFloat
    let height          : CGFloat
    let color           : Color
    let focusColor      : Color?
    let views           : ()-> AnyView
    let click           : ()-> Void
    let longClick       : ()-> Void
    
    init(
        cornerRadius    : CGFloat = 16,
        elevation       : CGFloat = 2,
        width           : CGFloat = CGFloat.infinity,
        height          : CGFloat = 140,
        color           : Color = Color(.white),
        focusColor      : Color? = nil,
        click           : @escaping () -> Void = {},
        longClick       : @escaping () -> Void = {},
        views           : @escaping () -> AnyView
    ){
        self.cornerRadius   = cornerRadius
        self.elevation      = elevation
        self.width          = width
        self.height         = height
        self.color          = color
        self.focusColor     = focusColor
        self.click          = click
        self.longClick      = longClick
        self.views          = views
    }
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(isTap ? focusColor ?? color : color)
                .shadow(radius: elevation)
                .frame(maxWidth: width, maxHeight: height)
            
            VStack{
                views()
            }
            .frame(maxWidth: width, maxHeight: height)
        }
        .padding(5)
        .onTapGesture {
            click()
        }
        .onLongPressGesture(minimumDuration: 0.3, pressing: {
                pressing in isTap = pressing
            },perform: {longClick()
        })
    }
}
