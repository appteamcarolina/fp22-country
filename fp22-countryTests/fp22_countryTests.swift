//
//  fp22_countryTests.swift
//  fp22-countryTests
//
//  Created by Vincent Zhou on 4/5/22.
//

import XCTest
@testable import fp22_country
@testable import fp22_countryWidgetExtension

class fp22_countryTests: XCTestCase {
    var sut: WidgetViewModel!
    var entry: SimpleEntry!


    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WidgetViewModel()
        entry = .placeholder()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func testEmojiMap() {
        let guess = "👕"
        
        let feedback = sut.findEmojis(entry: entry)
        
        XCTAssertEqual(guess, feedback, "Fallback emoji function works")
        
    }
    
    func testHourDetermine() {
        let guess = "\(Int(entry.weather.day))"
        
        let feedback = sut.hourDetermine(entry: entry)
        
        XCTAssertEqual(guess, feedback, "Hour determine function works")

        
    }
    
    func testAiStore() {
        AIStore.save(choices: "Jacket")
        
        
        let feedback = AIStore.fetchChoices()
        
        XCTAssertEqual("Jacket", feedback, "AI Save works")
    }
    
    
    func testWeatherStoreCity() {
        WeatherStore.save(city: "Chapel Hill", country: "USA", weekForecast: .example, tempForecasts: .placeholder(), sky: .placeholder())
        
        let feedback = WeatherStore.fetchCity()
        
        XCTAssertEqual("Chapel Hill", feedback, "AI Save works")

    }

   

}
