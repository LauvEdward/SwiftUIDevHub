//
//  AlbumView.swift
//  SwiftLearnHub
//
//  Created by Lauv Edward on 5/6/25.
//

import SwiftUI
import Photos

struct AlbumView: View {
    @ObservedObject var viewModel: PhotoLibraryViewModel
    var body: some View {
        List(viewModel.albums, id: \.localIdentifier) { album in
            NavigationLink(destination: PhotoLibraryView(collection: album)) {
                VStack {
                    HStack {
                        AlbumThumbnail(collection: album, size: CGSize(width: 100, height: 100))
                        Text(album.localizedTitle ?? "Unknown")
                        Spacer()
                    }
                    Divider()
                }
            }.listRowSeparator(.hidden)
        }
        .onAppear {
            viewModel.checkAuthorization()
        }
    }
}

struct AlbumThumbnail: View {
    let collection: PHAssetCollection
    @State private var image: UIImage?
    let size: CGSize
    
    var body: some View {
        VStack {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .frame(width: size.width, height: size.height)
        }.onAppear {
            if let asset = PHAsset.fetchAssets(in: collection, options: nil).lastObject {
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: size.width, height: size.height), contentMode: .aspectFill, options: nil) { img, _ in
                    self.image = img
                }
            }
        }
    }
}


#Preview {
    let mockViewModel = PhotoLibraryViewModel()
    mockViewModel.albums = [
        PHAssetCollection(),
    ]
    
    return AlbumView(viewModel: mockViewModel)
}
