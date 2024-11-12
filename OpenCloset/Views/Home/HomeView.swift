//
//  HomeView.swift
//  OpenCloset
//
//  Created by Mateus Mansuelli on 06/11/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var list: [Profile] = [Profile(name: "Paola", surname: "Campanile", email: "paula@campanile.com", about: "Second-hand enthusiast 🌱 ", profileImageURL: "https://png.pngtree.com/png-clipart/20230927/original/pngtree-man-in-shirt-smiles-and-gives-thumbs-up-to-show-approval-png-image_13146336.png")]
    
    var body: some View {
        VStack {
            HStack {
                Text("9:41")
                    .font(.system(size: 20))
                    .padding(.leading, 10)
                Spacer()
                Image(systemName: "battery.100")
                    .padding(.trailing, 10)
            }
            .padding(.top, 10)
            
            HStack {
                TextField("Search", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                Image(systemName: "magnifyingglass")
                    .padding(.trailing, 10)
            }
            .background(Color.yellow)
            
            Text("Sort by: Distance")
                .padding(.leading, 10)
                .padding(.top, 10)
            
            List(list, rowContent: { profile in
                HStack {
                            HStack {
                                VStack {
                                    HStack {
                                        
                                        Text("Name")
                                            .font(.headline)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.pink)
                                                .frame(width: 70, height: 25)
                                            
                                            Text("170 m")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("YellowSecondary"))
                                                .padding(.all, 10)
                                        }
                                        
                                        
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.pink)
                                                .frame(width: 100, height: 25)
                                            
                                            
                                            HStack {
                                                Image(systemName: "star.fill")
                                                    .font(.body)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color("YellowSecondary"))
                                                
                                                Image(systemName: "star.fill")
                                                    .font(.body)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color("YellowSecondary"))
                                                
                                                Image(systemName: "star.fill")
                                                    .font(.body)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color("YellowSecondary"))
                                                
                                            }
                                        }
                                        .padding(.trailing)
                                    }
                                    
                                    HStack {
                                        Text("Short description")
                                            .font(.callout)
                                            .foregroundStyle(.gray)
                                            .padding(.leading)
                                        
                                        
                                        Spacer()
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            
                            Image(systemName: "circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90 , height:  90)
                            
                            Text (">")
                                .font(.title)
                                .foregroundColor(Color("PinkStrong"))
                                .padding(.trailing)
                        }
            })
            .listStyle(.plain)
            List(list) { profile in
                VStack {
                    UserRow(name: profile.name, distance: "150 m", rating: 3, description: "Second-hand enthusiast 🌱")
                }
                
            }
//            ScrollView {
//                VStack(alignment: .leading) {
//                    UserRow(name: "Paola", distance: "150 m", rating: 3, description: "Second-hand enthusiast 🌱")
//                    UserRow(name: "Giorgia", distance: "70 m", rating: 2, description: "New to second hand.")
//                    UserRow(name: "Paola", distance: "150 m", rating: 3, description: "Second-hand enthusiast 🌱")
//                    UserRow(name: "Giorgio", distance: "70 m", rating: 2, description: "New to second hand.")
//                    UserRow(name: "Paola", distance: "150 m", rating: 3, description: "Second-hand enthusiast 🌱")
//                }
//                .padding(.horizontal, 10)
//            }
            
        }
    }
}

struct UserRow: View {
    var name: String
    var distance: String
    var rating: Int
    var description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                HStack {
                    Text(distance)
                        .padding(5)
                        .background(Color.pink)
                        .cornerRadius(5)
                    ForEach(0..<rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                Text(description)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    HomeView()
}
