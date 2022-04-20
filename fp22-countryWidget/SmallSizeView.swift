//
//  SmallSizeView.swift
//  fp22-country
//
//  Created by Josh Myatt on 4/14/22.
//

import SwiftUI
import WidgetKit


struct SmallSizeView: View {
    var entry: SimpleEntry
    var vm = WidgetViewModel()
    var body: some View {
        let clothesEmojiMap = vm.findEmojis(entry: entry)
        ZStack{
            WeatherUtils.gradientMap[entry.sky.main] ?? WeatherUtils.clearGradient
            HStack{
                VStack{
                    Text("\(entry.location.city)")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .frame(alignment: .leading)
                    VStack{
                        Text("\(vm.hourDetermine(entry: entry))º")
                            .font(.system(size: 40))
                            .fontWeight(.light)
                            .foregroundColor(.white)
                        Text(WeatherUtils.emojiMap[entry.sky.main] ?? "")
                            .font(.system(size: 50))
                    }
                }
                VStack{
                    Text(clothesEmojiMap[0] ?? "")
                        .font(.system(size: 50))
                    Text(clothesEmojiMap[1] ?? "")
                        .font(.system(size: 50))
                    }
                }
            }
        }
    }

