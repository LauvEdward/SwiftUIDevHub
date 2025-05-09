//
//  PhotoLibraryView.swift
//  SwiftLearnHub
//
//  Created by Lauv Edward on 5/6/25.
//

import SwiftUI
import Photos

struct PhotoLibraryView: View {
    var cancelText: String?
    var doneText: String?
    let viewmodel = PhotoLibraryViewModel()
    @State var listPhoto: [PHAsset] = []
    let collection: PHAssetCollection
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let gridWidth = geometry.size.width
                let spacing: CGFloat = 10
                let numberOfColumns = 3
                let totalSpacing = spacing * CGFloat(numberOfColumns - 1)
                let itemWidth = (gridWidth - totalSpacing) / CGFloat(numberOfColumns)
                let columns = Array(repeating: GridItem(.fixed(itemWidth), spacing: spacing), count: numberOfColumns)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(listPhoto, id: \.localIdentifier) { asset in
                            PhotoThumbnail(asset: asset, size: CGSize(width: itemWidth, height: itemWidth))
                        }
                    }
                }
            }.padding(10)
                .onAppear {
                    self.listPhoto = viewmodel.fetchAssets(in: collection)
                }
                .toolbar {
                    if let cancelText, cancelText.isEmpty == false {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(cancelText) {
                                
                            }
                        }
                    }
                    
                    if let doneText, doneText.isEmpty == false {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(doneText) {
                                
                            }
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text("Home"))
        }
    }
}
struct PhotoThumbnail: View {
    let asset: PHAsset
    @State private var image: UIImage?
    @State private var isSelected = false
    let size: CGSize
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .frame(width: size.width, height: size.height)
                .onAppear {
                    PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) { img, _ in
                        self.image = img
                    }
                }
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .background(Circle().fill(Color.white))
                    .padding(3)
            }
        }.onTapGesture {
            isSelected = !isSelected
        }
    }
}
