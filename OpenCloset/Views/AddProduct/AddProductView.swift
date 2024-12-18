//
//  AddProductView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//
import SwiftUI

struct AddProductView: View {
    @ObservedObject var viewModel: AddProductViewModel = AddProductViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var onAddProductCompletion: ((_ product: Product) -> Void)?
    let conditions = ["Excellent condition", "Gently used", "Still in good condition"]
    
    init(onAddProductCompletion: ((_ product: Product) -> Void)?) {
        self.onAddProductCompletion = onAddProductCompletion
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Good photos and descriptions make all the difference!📸")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                ImageGridView(viewModel: viewModel)
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
                
                VStack(alignment: .leading) {
                    Text("Item name")
                        .font(.headline)
                    
                    TextField("Stylish Sweater", text: $viewModel.name)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    
                    if let errorMessage = viewModel.itemNameError, !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 8)
                            .padding(.bottom, 4)
                    }
                }
                
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
                    
                    if let errorMessage = viewModel.itemDescriptionError, !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.leading, 8)
                            .padding(.bottom, 4)
                    }
                }
                
                // Size and Condition Pickers
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Size")
                            .font(.headline)
                        
                        TextField("Medium", text: $viewModel.size)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        
                        if let errorMessage = viewModel.sizeError, !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.leading, 8)
                                .padding(.bottom, 4)
                        }
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
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                        
                        if let errorMessage = viewModel.sizeError, !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.clear)
                                .font(.caption)
                                .padding(.leading, 8)
                                .padding(.bottom, 4)
                        }
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
                
                Button("Add to your OpenCloset") {
                    viewModel.addProduct()
                }
                .padding(.horizontal, -16)
                .buttonStyle(PrimaryButtonStyle())
                
                Spacer()
            }.padding(16)
                .fullScreenCover(isPresented: $viewModel.isLoading) {
                    ProgressView("Loading...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .presentationBackground(.black.opacity(0.4))
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
                .onAppear {
                    viewModel.onAddProductCompletion = { product in
                        onAddProductCompletion?(product)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        }.scrollDismissesKeyboard(.immediately)
    }
}


#Preview {
    AddProductView(onAddProductCompletion: { product in })
}
