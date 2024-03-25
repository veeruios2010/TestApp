//
//  UserListView.swift
//  TestApp
//
//  Created by Apple on 3/23/24.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = UserListViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack() {
                    List(viewModel.users ?? [], id: \.id) { user in
                        NavigationLink(destination: UserDetailView(userInfo: user)) {
                            HStack {
                                AsyncImage(url: URL(string: user.avatar )) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .foregroundColor(.teal)
                                }
                                .frame(width: 70, height: 70)
                                
                                HStack() {
                                    Text(user.firstName.capitalized )
                                        .font(.headline)
                                    Text(user.lastName )
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                    .listRowInsets(EdgeInsets())
                    .background(Color.white)
                    .navigationTitle("Users") //.navigationBarTitle("Users", displayMode: .inline)

                    if viewModel.isLoading {
                        LoaderView()
                    }
                    
                    HStack() {
                        Spacer()
                            .frame(width: 32)
                        Button("Previous") {
                            viewModel.pageDecrement()
                        }
                        Spacer()
                        Button("Next") {
                            viewModel.pageIncrement()
                        }
                        Spacer()
                            .frame(width: 32)
                    }
                }
            }
        }
        .task {
            await viewModel.getUsers(pageNo: 1)
        }
        .alert(isPresented: $viewModel.shouldShowAlert) {
            return Alert(
                title: Text("Error"),
                message: Text(viewModel.userError?.errorDescription ?? "")
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
