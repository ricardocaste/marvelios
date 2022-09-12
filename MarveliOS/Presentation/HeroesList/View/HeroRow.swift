//
//  HeroeRow.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 6/9/22.
//

import SwiftUI
import CachedAsyncImage

struct HeroRow: View {
    var hero: Hero
    var body: some View {

        HStack {
            CachedAsyncImage(url: hero.imageURL, content: { image in
                image.brandedThumbnail()
            }, placeholder: {
                Image("placeholder").brandedThumbnail()
            })

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(hero.name)
                        .lineLimit(1)

                    Spacer()
                }

                if hero.description != "" {
                    Text(hero.description)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .font(.footnote)
                } else {
                    Spacer()
                }
            }.padding()
        }
    }
}

extension Image {
    func brandedThumbnail() -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 70, height: 100)
            .cornerRadius(8)
    }
}

 struct HeroeRow_Previews: PreviewProvider {
    @JSONFile(named: "response")
    static var response: HeroResponse?
    static var previews: some View {
        List(response!.heroes) { hero in
             HeroRow(hero: hero)
        }

    }
 }
