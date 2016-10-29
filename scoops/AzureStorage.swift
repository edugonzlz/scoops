//
//  AzureStorage.swift
//  scoops
//
//  Created by Edu González on 29/10/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

var storageClient: AZSCloudBlobClient?
var scoopsContainer: AZSCloudBlobContainer?

func setupAzureClient()  {

    do {
        let credentials = AZSStorageCredentials(accountName: accountNameAzureStorage,
                                                accountKey: accountKeyAzureStorage)
        let account = try AZSCloudStorageAccount(credentials: credentials, useHttps: true)

        storageClient = account.getBlobClient()
    } catch{
        print("💥⛈💔Error creando Storage en Azure\(error)")
    }
}

func newContainer(withName name: String) {

    let blobContainer = storageClient?.containerReference(fromName: name.lowercased())

    blobContainer?.createContainerIfNotExists(with: AZSContainerPublicAccessType.container,
                                              requestOptions: nil,
                                              operationContext: nil,
                                              completionHandler: { (error, result) in

                                                if error != nil {
                                                    return print("💥⛈💔Error creando container\(error)")
                                                }
                                                if result {
                                                    print("💥⛈💔Container Creado: \(result)")
                                                } else {
                                                    print("💥⛈💔Ya existe el container")
                                                }
    })
}

func accessContainer(withName name: String) -> AZSCloudBlobContainer? {

    return storageClient?.containerReference(fromName: name.lowercased())
}

func uploadBlob(toContainer container: AZSCloudBlobContainer?, withImage image: UIImage, withName name: String){

    // crear el blob local
    let blob = container?.blockBlobReference(fromName: name)

    // subir

    blob?.upload(from: UIImageJPEGRepresentation(image, 0.5)!, completionHandler: { (error) in

        if error != nil {
            print("💥⛈💔Error subiendo blob: \(error)")
        }

    })

}




