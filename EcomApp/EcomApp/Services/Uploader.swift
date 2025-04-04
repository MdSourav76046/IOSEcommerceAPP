//
//  Uploader.swift
//  EcomApp
//
//  Created by Md.Sourav on 21/3/25.
//

import Foundation


enum MimeType: String {
    case jpg = "image/jpg"
    case png = "image/png"
    case jpeg = "image/jpeg"
    
    var value: String {
        return self.rawValue
    }
}

struct Uploader {
    let httpClient : HTTPClient
    
    func upload(data: Data, mimeType: MimeType = .png) async throws -> UploadDataResponse {
        let boundary = UUID().uuidString
        let headers = ["Content-type": "multipart/form-data; boundary=\(boundary)"]
        
        // create multy part form data body
        let body = createMultipartFormDataBody(data: data, mimetype: mimeType, boundary: boundary)
        let resource  = Resource(url: Constants.Urls.uploadProductImage, method: .post(body), headers: headers, modelType: UploadDataResponse.self)
        let response = try await httpClient.load(resource)
        return response
    }
    
    private func createMultipartFormDataBody(data: Data, mimetype: MimeType = .png, boundary: String) -> Data {
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"upload.png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype.value)\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        
        // Add the final boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
}
