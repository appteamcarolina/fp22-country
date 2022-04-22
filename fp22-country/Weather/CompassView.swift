//
//  CompassView.swift
//  fp22-country
//
//  Created by Vincent Zhou on 4/21/22.
//

import SwiftUI

struct CompassView: View {
    @StateObject var vm = CompassViewModel()
    var windHeading = 90.0
    
    var body: some View {
        VStack {
            Capsule()
                .frame(width: 5,
                        height: 25)
                .foregroundColor(Color.gray)
                .padding(.bottom)
            ZStack {
                VStack {
                    Text("Wind").rotationEffect(windTextAngle())
                    Capsule()
                        .frame(width: 5,
                                height: 25)
                        .foregroundColor(Color.blue)
                        .padding(.bottom)
                        .padding(.bottom, 200)
                }.rotationEffect(Angle(degrees: windHeading))
                ForEach(Marker.markers(), id: \.self) { marker in
                    CompassMarkerView(marker: marker,
                                      compassDegress: vm.compassHeading)
                }
            }
            .frame(width: 300,
                   height: 300)
            .rotationEffect(Angle(degrees: vm.compassHeading))
            .statusBar(hidden: true)
            Button {
                vm.startTracking()
            } label: {
                Label("Start tracking", systemImage: "play").frame(maxWidth:.infinity).padding([.top, .bottom]).background(.thinMaterial).cornerRadius(10)
            }
            Button {
                vm.stopTracking()
            } label: {
                Label("Stop tracking", systemImage: "stop").frame(maxWidth:.infinity).padding([.top, .bottom]).background(.thinMaterial).cornerRadius(10)
            }
        }.padding()
    }
    
    private func windTextAngle() -> Angle {
        return Angle(degrees: -vm.compassHeading - windHeading)
//        return Angle(degrees: 0)
    }
}

struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView().preferredColorScheme(.dark)
    }
}

struct CompassMarkerView: View {
    let marker: Marker
    let compassDegress: Double

    var body: some View {
        VStack {
            Text(marker.degreeText())
                .fontWeight(.light)
                .rotationEffect(textAngle())
            Capsule()
                .frame(width: capsuleWidth(),
                        height: capsuleHeight())
                .foregroundColor(capsuleColor())
                .padding(.bottom)
            Text(marker.label)
                .fontWeight(.bold)
                .rotationEffect(textAngle())
                .frame(height: 5)
                .padding(.bottom, 200)
//            Spacer()
        }
        .rotationEffect(Angle(degrees: marker.degrees)) // 4
    }
    
    // 1
    private func capsuleWidth() -> CGFloat {
        return self.marker.degrees == 0 ? 7 : 3
    }

    // 2
    private func capsuleHeight() -> CGFloat {
        return self.marker.degrees == 0 ? 45 : 30
    }

    // 3
    private func capsuleColor() -> Color {
        return self.marker.degrees == 0 ? .red : .gray
    }

    // 4
    private func textAngle() -> Angle {
        return Angle(degrees: -self.compassDegress - self.marker.degrees)
//        return Angle(degrees: 0)
    }
}

struct Marker: Hashable {
    let degrees: Double
    let label: String

    init(degrees: Double, label: String = "") {
        self.degrees = degrees
        self.label = label
    }
    func degreeText() -> String {
        return String(format: "%.0f", self.degrees)
    }
    

    static func markers() -> [Marker] {
        return [
            Marker(degrees: 0, label: "N"),
            Marker(degrees: 30),
            Marker(degrees: 60),
            Marker(degrees: 90, label: "E"),
            Marker(degrees: 120),
            Marker(degrees: 150),
            Marker(degrees: 180, label: "S"),
            Marker(degrees: 210),
            Marker(degrees: 240),
            Marker(degrees: 270, label: "W"),
            Marker(degrees: 300),
            Marker(degrees: 330)
        ]
    }
}
