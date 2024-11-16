//
//  ImageGridView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 14/11/24.
//
import SwiftUI
import SwiftUI

struct ImageGridView: View {
    @ObservedObject var viewModel: AddProductViewModel
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        HStack(spacing: 8) {
            ImageThumbnail(
                image: viewModel.getProductImage(with: 0),
                systemImageName: "photo.on.rectangle.angled",
                systemImageSize: 44,
                isEditable: !viewModel.productImageList.isEmpty,
                onRemove: {
                    viewModel.removeImage()
                }
            )
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(1...4, id: \.self) { index in
                    ImageThumbnail(
                        image: viewModel.getProductImage(with: index),
                        systemImageName: "plus",
                        systemImageSize: 24,
                        isEditable: false,
                        onRemove: nil
                    )
                }
            }
        }
        .onTapGesture {
            if viewModel.productImageList.count < 5 {
                viewModel.showPhotoOptions = true
            }
        }
    }
}

struct ImageThumbnail: View {
    let image: UIImage?
    let systemImageName: String
    let systemImageSize: CGFloat
    let isEditable: Bool
    let onRemove: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .overlay(
                    VStack {
                        if let image = image {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                if isEditable, let onRemove = onRemove {
                                    Button(action: onRemove) {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                    }
                                    .frame(width: 30, height: 30)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .padding(.top, -10)
                                    .padding(.trailing, -10)
                                }
                            }
                        } else {
                            Image(systemName: systemImageName)
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: geometry.size.width / 2, height: systemImageSize)
                                .foregroundColor(.accent)
                        }
                    }
                )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    ImageGridView(viewModel: AddProductViewModel())
}
