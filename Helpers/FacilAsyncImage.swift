//
//  FacilAsyncImage.swift
//  Quiz
//
//  Created by c035 DIT UPM on 17/11/23.
//

import SwiftUI

struct FacilAsyncImage: View {
    
    
    var url: URL?
    var body: some View{
        AsyncImage(url: url){phase in
            if url == nil {
                Color.gray
            }else if let image=phase.image{
                image.resizable()
            }else{
                ProgressView()
            }
            
        }
    }
}
