//
//  ContentView.swift
//  Example
//
//  Created by 松下和也 on 2025/07/20.
//

import SwiftUI
import DestinationSwipeControl

struct ParentView: View {
    @State var shouldShowChild: Bool = false
    let enabled = true

    var body: some View {
        NavigationStack {
            VStack{
                Text("Parent")
                Button("Next"){
                    shouldShowChild = true
                }
            }
            .navigationDestination(isPresented: $shouldShowChild) {
                ChildView(count: 1, enabled: enabled, isPresented: $shouldShowChild)
                    .dismissible(backButton: false, edgeSwipe: enabled)
            }
        }
    }
}

struct ChildView: View {
    let count: Int
    let enabled: Bool
    @Binding var isPresented: Bool
    @State var shouldShowChild: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 16){
                Text("Child \(count)")
                if enabled {
                    Text("Swipe Enable")
                }else{
                    Text("Swipe Disable")
                }
                Button("Next"){
                    shouldShowChild = true
                }
                ForEach(0..<10){
                    Text("Item \($0)")
                        .padding()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back"){
                    isPresented = false
                }
            }
        }
        .navigationDestination(isPresented: $shouldShowChild) {
            ChildView(count: count+1, enabled: !enabled, isPresented: $shouldShowChild)
                .dismissible(backButton: false, edgeSwipe: !enabled)
        }
    }
}


#Preview {
    ParentView()
}
