//
//  RequestView.swift
//  Amicus
//
//  Created by Luc Lehmkuhl on 19.05.22.
//

import SwiftUI
import SwiftUIFormValidator
import MapKit
import CoreLocationUI


struct RequestView: View {
    
    struct Location: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
    
    @StateObject var locationManager = LocationManager()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var tabSelection: Tabs
    @State private var description = ""
    @State private var topic = ""
    @State private var address: CLPlacemark?
    @StateObject private var requestModel = RequestViewModel()
    @StateObject private var categoryModel = CategoryViewModel()
    @EnvironmentObject var userState: UserStateViewModel
    
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var showCamera = false
    
    var body: some View {
        Form {
            Section( header: Text("Define your Problem")){
                Picker("Category", selection: $categoryModel.selection) {
                    ForEach(categoryModel.categories, id: \.self) { category in
                        Text(category.categoryName.capitalized)
                    }
                }.onAppear {
                    categoryModel.populateCategories()
                }
                TextField("Topic", text: $topic)
            }
            
            Section(header: Text("Describe your Problem here:")) {
                ZStack(){
                    TextEditor(text: $description)
                }
                
            }
            
            Section(header: Text("Image")) {
                HStack {
                    Image(uiImage: self.image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(20)
                    Menu("Add Picture") {
                        Button(action: {showCamera = true}) {
                            HStack{
                                Image(systemName: "camera")
                                Text("Take picture")
                            }
                        }
                        Button(action: {showSheet = true}) {
                            HStack{
                                Image(systemName: "photo")
                                Text("Add from library")
                            }
                        }
                    }
                    .sheet(isPresented: $showCamera) {
                        ImagePicker(sourceType: .camera, selectedImage: self.$image)
                    }
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                    .onTapGesture(perform: simpleSuccess)
                }
            }
            
            Section(header: Text("Coordinates")){
                ZStack(alignment: .bottom) {
                    Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        if let location = locationManager.location {
                            let country = address?.country ?? "unknown country"
                            let city = address?.locality ?? "unknown city"
                            Text("**Current location:** \(city), \(country)")
                                .font(.callout)
                                .foregroundColor(.white)
                                .padding()
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 10)).task {
                                    self.address = await retrieveLocation(location: location)
                                }
                        }
                        
                        Spacer()
                        LocationButton {
                            locationManager.requestLocation()
                        }
                        .frame(width: 180, height: 40)
                        .cornerRadius(30)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                    }
                    .padding()
                }
                .frame(width: 300, height: 200)
            }
            
            
            Button(action: {
                requestModel.create(topic: topic, description: description, category: categoryModel.selection, image: self.image, coords: locationManager.location, userId: userState.info.info.id)
                tabSelection = Tabs.home
            }, label: {
                HStack {
                    Text("Post Request")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                }
            }
            )
            
        }
        //        .foregroundColor(Color.amicusGreen)
    }
}




struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView(tabSelection: .constant(Tabs.home))
    }
}
