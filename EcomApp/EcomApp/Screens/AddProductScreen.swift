//
//  AddProductScreen.swift
//  EcomApp
//
//  Created by Md.Sourav on 20/3/25.

import SwiftUI
import PhotosUI


struct AddProductScreen: View {
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: Float?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(ProductStore.self) private var productStore
    @Environment(\.uploader) private var uploader
    @AppStorage("userId") private var userId: Int?
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var isCameraSelected: Bool = false
    @State private var uiImage: UIImage?
    
    
    
    private var isFormValid: Bool {
        !name.isEmptyOrWhitespace && !description.isEmptyOrWhitespace
               && (price ?? 0) > 0
    }
    
    private func saveProduct() async {
       
        do {
            guard let uiImage = uiImage, let imageData = uiImage.pngData() else {
                throw ProductError.missingImage
            }
            let uploadDataResponse = try await uploader.upload(data: imageData)
            
            guard let downloadURL = uploadDataResponse.downloadUrl, uploadDataResponse.success else{
                throw ProductError.uploadFailed(uploadDataResponse.message ?? "")
            }
            
            guard let userId = self.userId else {
                throw ProductError.missingUserId
            }
            
            guard let price = price else {
                throw ProductError.invalidPrice
            }
            
            let product = Product(name: name, description: description, price: price, photoUrl: downloadURL, userId: userId)
            
            try await productStore.saveProduct(product)
            print(userId)
            dismiss()
            
        } catch {

            print(error.localizedDescription)
        }
    }
    

    var body: some View {
        Form {
            TextField("Enter name", text: $name)
            TextEditor(text: $description)
                .frame(height: 100)
            TextField("Enter price", value: $price, format: .number)
            HStack{

//                Button {
//                    print("\(isCameraSelected)")
//                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                        print("Hello")
//                        isCameraSelected = true
//                    }
//                    else {
//                        print("Camera is not supported in this device!")
//                    }
//                } label: {
//                    Image(systemName: "camera.fill")
//                }
                
                
                PhotosPicker(selection: $selectedPhotoItem,
                             matching: .images,
                             photoLibrary: .shared()) {
                    
                    Image(systemName: "photo.on.rectangle")
                }

            }
            .font(.title)
            
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .task(id: selectedPhotoItem, {
            if let selectedPhotoItem {
                do {
                    if let data = try await selectedPhotoItem.loadTransferable(type: Data.self){
                        uiImage = UIImage(data: data)
                    }
                        
                } catch{
                    print(error.localizedDescription)
                }
                
            }
        })
        .sheet(isPresented: $isCameraSelected, content: {
            
            ImagePicker(image: $uiImage, sourceType: .camera)
        })
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    Task {
                        await saveProduct()
                    }
                }.disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddProductScreen()
    }
    .environment(ProductStore(httpClient: .development))
    .environment(\.uploader, Uploader(httpClient: .development))
}
