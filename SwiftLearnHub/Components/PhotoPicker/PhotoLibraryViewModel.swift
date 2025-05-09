//
//  PhotoLibraryViewModel.swift
//  SwiftLearnHub
//
//  Created by Lauv Edward on 5/6/25.
//

import SwiftUI
import Photos

class PhotoLibraryViewModel: ObservableObject {
//    @Published var assets: [PHAsset] = []
    @Published var albums: [PHAssetCollection] = []
    @Published var selectedAssets: [PHAsset] = []
    
    init() {
        checkAuthorization()
    }
    
    func checkAuthorization() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized || status == .limited {
            fetchAlnums()
        } else {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized || newStatus == .limited {
                        self.fetchAlnums()
                    }
                }
            }
        }
    }
    
    func fetchAlnums() {
        albums = []
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        smartAlbums.enumerateObjects { (collection, _, _) in
            self.albums.append(collection)
        }
        
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil )
        userAlbums.enumerateObjects { (collection, _, _) in
            self.albums.append(collection)
        }
    }
    
    func fetchAssets(in album: PHAssetCollection) -> [PHAsset] {
        var listAssets: [PHAsset] = []
        let options: PHFetchOptions = .init()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchResult = PHAsset.fetchAssets(in: album, options: options)
        fetchResult.enumerateObjects { (asset, _, _) in
            listAssets.append(asset)
        }
        return listAssets
    }
}
