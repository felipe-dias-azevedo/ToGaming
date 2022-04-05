//
//  SearchFilter.swift
//  ToGaming
//
//  Created by felipe azevedo on 01/04/22.
//

import SwiftUI

struct SearchFilter: View {
    
    @Binding var filtering: Bool
    
    @Binding var dateAfter: Date
    @Binding var dateBefore: Date
    @State private var filterReleaseDate = false
    
    @State private var filterPlatform = false
    private let platforms = ["Playstation 4", "Xbox One", "PC"]
    @Binding var selectedPlatform: String?
    
    @State private var filterGenre = false
    private let genres = ["Action", "Adventure", "Racing"]
    @Binding var selectedGenre: String?
    
    @State private var filterPublisher = false
    private let publishers = ["Naughty Dog", "Poliphony Digital", "Black Box"]
    @Binding var selectedPublishers: String?
    
    @State private var filterDeveloper = false
    private let developers = ["SIE", "Xbox Studios", "Activision"]
    @Binding var selectedDevelopers: String?
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle(isOn: $filterReleaseDate) {
                        Text("Release Date")
                            .fontWeight(.light)
                            .font(.body)
                    }
                    
                    if filterReleaseDate {
                        DatePicker(selection: $dateBefore, displayedComponents: .date) {
                            Text("Date Before")
                                .font(.body)
                                .fontWeight(.medium)
                        }
                        
                        DatePicker(selection: $dateAfter, displayedComponents: .date) {
                            Text("Date After")
                                .font(.body)
                                .fontWeight(.medium)
                        }
                    }
                }
                
                FilterSection(title: "Platform", selectedItem: $selectedPlatform, toggle: $filterPlatform)
                
                FilterSection(title: "Genre", selectedItem: $selectedGenre, toggle: $filterGenre)
                
                FilterSection(title: "Publisher Company", selectedItem: $selectedPublishers, toggle: $filterPublisher)
                
                FilterSection(title: "Developer Studio", selectedItem: $selectedDevelopers, toggle: $filterDeveloper)
            }
            .navigationTitle("Search Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        selectedGenre = nil
                        selectedPlatform = nil
                        selectedDevelopers = nil
                        selectedPublishers = nil
                        dateAfter = Date()
                        dateBefore = Date()
                        filtering.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        if !filterReleaseDate {
                            dateAfter = Date()
                            dateBefore = Date()
                        }
                        filtering.toggle()
                    } label: {
                        Text("Done")
                    }
                }
            }
            .sheet(isPresented: $filterPlatform) {
                ListSelect(title: "Platforms", items: platforms, itemSelection: $selectedPlatform)
            }
            .sheet(isPresented: $filterGenre) {
                ListSelect(title: "Genres", items: genres, itemSelection: $selectedGenre)
            }
            .sheet(isPresented: $filterPublisher) {
                ListSelect(title: "Publisher Companies", items: publishers, itemSelection: $selectedPublishers)
            }
            .sheet(isPresented: $filterDeveloper) {
                ListSelect(title: "Developer Studios", items: developers, itemSelection: $selectedDevelopers)
            }
        }
    }
}

struct SearchFilter_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilter(filtering: .constant(true), dateAfter: .constant(Date()), dateBefore: .constant(Date()), selectedPlatform: .constant(nil), selectedGenre: .constant(nil), selectedPublishers: .constant(nil), selectedDevelopers: .constant(nil))
    }
}
