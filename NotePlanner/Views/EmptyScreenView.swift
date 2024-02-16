//
//  EmptyScreenView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/16/24.
//

import SwiftUI

struct EmptyScreenView: View {
    var body: some View {
       Image("cowork")
            .resizable()
            .scaledToFill()
            .overlay {
                VStack{
                   
                    Text("Press '+' button to create.")
                        .font(.title2)
                        .fontDesign(.serif)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 15)
                        .padding(.top, 25)
                        .foregroundStyle(.cyan)
                        .shadow(color: .gray ,radius: 10)
                        .frame(maxWidth: 350, alignment: .center)
                    Spacer()
                }
            }
    }
}

#Preview {
    EmptyScreenView()
}
