//
//  CustomViews.swift
//  SwifTacToe
//
//  Created by Adam S on 2022-03-27.
//

import SwiftUI


extension Color {
    public static var gamePurple: Color {
        return Color(UIColor(red: 75/255, green: 0/255, blue: 226/255, alpha: 1.0))
    }
}

struct GameTextView: View {
    var title: String
    var size: CGFloat
    var color: Color
    
    var body: some View {
        Text(title)
            .font(.custom("Courier", size: size))
            .foregroundColor(color)
    }
}

struct DifficultyButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .frame(width: 40, height: 10)
            .foregroundColor(Color.gamePurple)
            .padding()
            .background(.white)
            .cornerRadius(8)
    }
}

struct GameCircleView: View {
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(Color.gamePurple)
            .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 15)
            .padding()
    }
}

struct PlayerMarkView: View {
    var imageName : String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
