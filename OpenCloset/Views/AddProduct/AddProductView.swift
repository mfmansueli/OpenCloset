//
//  AddProductView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//
import SwiftUI

struct AddProductView: View {
    @ObservedObject var viewModel: AddProductViewModel = AddProductViewModel()
    
    let sizes = ["S", "M", "L", "XL", "XXL", "XXXL"]
    let conditions = ["Like New", "Good", "Used"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Good photos and descriptions make all the difference!📸")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Image Upload Grid
                VStack(alignment: .leading){
                    HStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(minWidth: 150, maxWidth: 200, minHeight: 150, maxHeight: 200)
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
                    }.onTapGesture {
                        viewModel.showPhotoOptions = true
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .confirmationDialog("", isPresented: $viewModel.showPhotoOptions, titleVisibility: .hidden, actions: {
                    Button("Take a photo") {
                        viewModel.showCamera = true
                    }
                    Button("Choose from library") {
                        viewModel.showPhotoLibrary = true
                    }
                })
                .fullScreenCover(isPresented: $viewModel.showCamera, content: {
                    ZStack {
                        Color.black.edgesIgnoringSafeArea(.all)
                        ImageCaptureView(image: $viewModel.productImage)
                    }
                })
                .fullScreenCover(isPresented: $viewModel.showPhotoLibrary, content: {
                    ImagePickerView(images: $viewModel.productImageList, image: .constant(nil), allowMultipleSelection: true)
                })
                
                // Text Field for Description
                VStack(alignment: .leading) {
                    Text("Item description")
                        .font(.headline)
                    
                    TextEditor(text: $viewModel.itemDescription)
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
                        Picker("Size", selection: $viewModel.selectedSize) {
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
                        Picker("Condition", selection: $viewModel.selectedCondition) {
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
                HStack(spacing: 16) {
                    HStack {
                        Toggle("Donate", isOn: $viewModel.isDonate)
                            .frame(maxWidth: 120)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding(.leading, 2)
                    
                    HStack {
                        Toggle("Swap", isOn: $viewModel.isSwap)
                            .frame(maxWidth: 105)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding(.leading, 2)
                }
                .padding(.top, 8)
                
                Button("Upload") {
                    
                }
                .padding(.horizontal, -16)
                .buttonStyle(PrimaryButtonStyle())
                
                Spacer()
            }.padding(.horizontal, 16)
        }
    }
}

#Preview {
    AddProductView()
}
