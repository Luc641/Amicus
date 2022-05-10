////
////  ContentView.swift
////  Amicus_Frontend
////
////  Created by Carl Rix on 19.04.22.
////
//
//import SwiftUI
//
//struct RegisterButton : ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .background(Color(red: 0.346, green: 0.505, blue: 0.342))
//            .foregroundColor(Color(red: 0.857, green: 0.843, blue: 0.804))
//            .clipShape(Capsule())
//            .scaleEffect(configuration.isPressed ? 1.2 : 1)
//            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Button("Register here") {
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
//            }.buttonStyle(RegisterButton())
//            Button("Sign in with Google") {
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
//            }.buttonStyle(RegisterButton())
//            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
//            }.buttonStyle(RegisterButton())
//            Text("Already have an account?")
//                .foregroundColor(Color.orange)
//                .padding()
//            Button("Log in") {
//                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
//            }.buttonStyle(RegisterButton())
//
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
