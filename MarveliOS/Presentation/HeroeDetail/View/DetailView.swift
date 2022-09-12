//
//  DetailRow.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 6/9/22.
//

import SwiftUI
import CachedAsyncImage
import UIKit

struct DetailView: View {
    @State var hero: Hero

    @StateObject var viewmodel = DetailViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0) {
                CachedAsyncImage(url: hero.imageURL, content: { image in
                    image.brandedDetail()
                }, placeholder: {
                    Image("placeholder").brandedDetail()
                })

                if hero.comics.isEmpty {
                    Spacer()
                    Header(title: "This hero has no comics")
                    Spacer()
                } else {
                    Header(title: "Comics")
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(hero.comics, id: \.self) { comic in
                                Cell(image: hero.imagePath, text: comic.name)
                            }
                        }
                    }
                    Spacer()
                }
                
                if hero.series.isEmpty {
                    Spacer()
                    Header(title: "This hero has no series")
                    Spacer()
                } else {
                    Header(title: "Series")
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(hero.series, id: \.self) { serie in
                                Cell(image: hero.imagePath, text: serie.name)
                            }
                        }
                    }
                    Spacer()
                }
                
                if hero.events.isEmpty {
                    Spacer()
                    Header(title: "This hero has no events")
                    Spacer()
                } else {
                    Header(title: "Events")
                    ScrollView (.horizontal, showsIndicators: false) {
                        
                        HStack {
                            ForEach(hero.events, id: \.self) { event in
                                Cell(image: hero.imagePath, text: event.name)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle(hero.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Header: View {
    var title: String
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
            .padding()
    }
}


struct Cell: View {
    let image: String
    let text: String
    var body: some View {
        VStack {}
        .frame(width: 200, height: 100)
        .background(
            CachedAsyncImage(url: URL(string: image), content: { image in
                image.brandedDetail()
            }, placeholder: {
                Image("placeholder").brandedDetail()
            })
        )
        .overlay(TextView(text: text), alignment: .bottomTrailing)
        .cornerRadius(4)
    }
}

struct TextView: View {
  let text: String
  var body: some View {
      ZStack {
          Text(text)
              .foregroundColor(.white)
              .padding(6)
              .frame(alignment: .center)
      }
      .frame(maxWidth: .infinity, alignment: .bottom)
      .background(Color.black)
      .opacity(0.8)
      .cornerRadius(4)
      .padding(6)
  }
}

extension Image {
    func brandedDetail() -> some View {
        self.resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: 400)
            .clipped()
    }
}

 struct DetailRow_Previews: PreviewProvider {
    @JSONFile(named: "response")
    static var response: HeroResponse?
    static var randomHero: Hero = response!.heroes.randomElement()!
    static var previews: some View {
        DetailView(hero: randomHero).edgesIgnoringSafeArea(.top)
    }
 }
