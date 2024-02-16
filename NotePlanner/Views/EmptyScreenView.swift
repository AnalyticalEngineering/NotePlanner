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
                    Text("")
                        .padding(.top, 15)
                    Text("Press '+' button to create new Objective.")
                        .font(.headline)
                        .fontDesign(.serif)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 15)
                        .padding(.top, 25)
                    Spacer()
                }
            }
    }
}

#Preview {
    EmptyScreenView()
}
