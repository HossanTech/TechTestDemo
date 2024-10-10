//
//  PeopleCellView.swift
//  TechTestDemo
//
//  Created by MohammadHossan on 10/10/2024.
//

import SwiftUI

struct PeopleCellView: View {
    
  let people: PeopleData
    var body: some View {
        HStack {
          if let url = URL(string: people.avatar ?? "Not Available") {
                PeopleAsyncImageView(url: url)
                    .frame(width: 150, height: 150)
                    .mask(RoundedRectangle(cornerRadius: 16))
            }
            
            VStack(alignment: .leading,spacing: 5) {
              Text("First Name: " + people.firstName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                
              Text("Last Name: " + (people.lastName ?? "Not Available"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)

              Text("ID: " + (people.id ?? "Not Available"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
            }
        }
    }
}

#Preview {
  PeopleCellView(people: Constants.previewPeopleObj)
}

