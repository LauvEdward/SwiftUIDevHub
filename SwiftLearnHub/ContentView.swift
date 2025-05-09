//
//  ContentView.swift
//  SwiftLearnHub
//
//  Created by Lauv Edward on 5/6/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            AlbumView(viewModel: PhotoLibraryViewModel())
        }
    }
}

#Preview {
    ContentView()
}
