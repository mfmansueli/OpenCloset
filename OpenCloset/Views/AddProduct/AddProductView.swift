//
//  AddProductView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//
import SwiftUI

struct ProductUploadView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var itemDescription: String = ""
    @State private var selectedSize: String = "P"
    @State private var selectedCondition: String = "Like New"
    @State private var isDonate: Bool = false
    @State private var isSwap: Bool = true
    
    let sizes = ["S", "M", "L", "XL", "XXL", "XXXL"]
    let conditions = ["Like New", "Good", "Used"]
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack{
                Button(action: {
                    // Add Logic to go back
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                }
                Text("Paola’s Closet")
                    .font(.title3)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding(.bottom, 8)
            
            Text("Good photos and descriptions make all the difference!📸")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // Image Upload Grid
            VStack(alignment: .leading){
                HStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 200, height: 200)
                        .overlay(
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.largeTitle)
                                .foregroundColor(.accent)
                        )
                        .onTapGesture {
                            // Add Logic to add image
                        }
                    VStack {
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Image(systemName: "plus")
                                        .foregroundColor(.accent)
                                )
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Image(systemName: "plus")
                                        .foregroundColor(.accent)
                                )
                        }
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Image(systemName: "plus")
                                        .foregroundColor(.accent)
                                )
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Image(systemName: "plus")
                                        .foregroundColor(.accent)
                                )
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Text Field for Description
            VStack(alignment: .leading) {
            Text("Item description")
                .font(.headline)
                
                TextEditor(text: $itemDescription)
                    .frame(height: 100)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                    .padding(3)
                    .scrollContentBackground(.hidden)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.gray.opacity(0.2))
                    }
        }
            
            // Size and Condition Pickers
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Size")
                        .font(.headline)
                    Picker("Size", selection: $selectedSize) {
                        ForEach(sizes, id: \.self) { size in
                            Text(size)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                }
                
                VStack(alignment: .leading) {
                    Text("Condition")
                        .font(.headline)
                    Picker("Condition", selection: $selectedCondition) {
                        ForEach(conditions, id: \.self) { condition in
                            Text(condition)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(20)
                }
            }
            
            // Toggles for Donate and Swap
            HStack {
                Toggle("Donate", isOn: $isDonate)
                    .fontWeight(.bold)
                    .padding(.trailing, 60)
                
                Toggle("Swap", isOn: $isSwap)
                    .fontWeight(.bold)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    .padding(.trailing, 70)
            }
            .padding(.top, 8)
            
            // Upload Button
            Button {
                // action goes here
            } label: {
                Text("Upload")
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
           
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct ProductUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ProductUploadView()
            .previewDevice("iPhone 12")
    }
}
