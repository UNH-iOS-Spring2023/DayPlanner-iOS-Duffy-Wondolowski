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

/// This is the UI element for the CustomColor
///   This lists the custom colors in the assests and makes them callable

struct CustomColor {
    static let background = Color("backgroundColor")
    static let backgroundCard = Color("backgroundCard")
    static let darkGreen = Color("darkGreen")
    static let lightGreen = Color("lightGreen")
}




/// This is the UI element for the CustomeTextField
/// - Parameters:
///     - placeHolder: the text that is displayed
///     - imageName: the icon image name
///     - bColor: the text color
///     - tOpacity: the opacity of the text
///     - width: the width of the entire view
///     - height: the height of the entire view
///     - borderColor: the color of the border

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
                        .autocapitalization(.none)
                    
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




/// This is the UI element for the Card View
/// - Parameters:
///     - cornerRadius: how rounded the corner will be
///     - elevation: how high the card will be above the view (shadow)
///     - width: how wide the card will be
///     - height: how tall the card will be
///     - color: what the background color of the card is
///     - focusColor: what the color of the card will be when active
///     - views: the content that is added to the card
///     - click: the function that will be called when the card is pressed
///     - longclick: the fucntion called when the card is pressed long

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
        .onTapGesture {
            click()
        }
        .onLongPressGesture(minimumDuration: 0.3, pressing: {
                pressing in isTap = pressing
            },perform: {longClick()
        })
    }
}
