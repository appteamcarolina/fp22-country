//
//  Utils.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/13/22.
//

import Foundation
import SwiftUI

//extension Color {
//    static var blue1: Color {
//        Color("blue1")
//    }
//    
//    static var blue2: Color {
//        Color("blue2")
//    }
//
//    static var blue3: Color {
//        Color("blue3")
//    }
//}


extension View {
    func fullscreenBackground<Content: View>(_ content: Content) -> some View {
        ZStack {
            content.ignoresSafeArea()

            self
        }
    }
    
    func fullscreenBackground<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ZStack {
            content().ignoresSafeArea()

            self
        }
    }
}
