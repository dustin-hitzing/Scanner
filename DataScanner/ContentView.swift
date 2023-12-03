//
//  ContentView.swift
//  DataScanner
//
//  Created by Dustin Hitzing on 12/2/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScanner = false
    @State private var scannedPages: [UIImage] = []

       var body: some View {
           VStack {
               Button("Scan Document") {
                   showingScanner = true
               }

               // Display scanned images or handle them as needed
               ForEach(scannedPages, id: \.self) { image in
                   Image(uiImage: image)
                       .resizable()
                       .aspectRatio(contentMode: .fit)
               }
           }
           .sheet(isPresented: $showingScanner) {
               DocumentCamera { result in
                   switch result {
                   case .success(let scan):
                       for pageIndex in 0..<scan.pageCount {
                           let image = scan.imageOfPage(at: pageIndex)
                           scannedPages.append(image)
                       }
                   case .failure(let error):
                       // Handle errors
                       print(error.localizedDescription)
                   } 
                   showingScanner = false
               }
           }
       }
}

#Preview {
    ContentView()
}
