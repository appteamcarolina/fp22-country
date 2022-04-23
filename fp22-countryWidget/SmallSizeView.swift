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
        let clothesEmoji = vm.findEmojis(entry: entry)
        ZStack{
            WeatherUtils.gradientMap[entry.sky.main] ?? WeatherUtils.clearGradient
            HStack{
                VStack{
                    Text("\(entry.location.city)")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(vm.textDeterminer(entry: entry))
                        .multilineTextAlignment(.center)
                    VStack{
                        Text("\(vm.hourDetermine(entry: entry))º")
                            .font(.system(size: 40))
                            .fontWeight(.light)
                            .foregroundColor(vm.textDeterminer(entry: entry))
                        Text(WeatherUtils.emojiMap[entry.sky.main] ?? "")
                            .font(.system(size: 50))
                    }
                }
                VStack{
                    Text(clothesEmoji ?? "")
                        .font(.system(size: 50))
                    }
                }
            }
        }
    }

