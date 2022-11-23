//
//  AstronomyViewModel.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import Foundation

final class AstronomyViewModel {
    private(set) var astronomyDataProvider = AstronomyDataProvider()
    
    init(astronomyDataProvider: AstronomyDataProvider = AstronomyDataProvider()) {
        self.astronomyDataProvider = astronomyDataProvider
    }
    
    func fetchAstronomyInfo() {
        astronomyDataProvider.loadAstronomyInfo { astronomyData, error in
            print("astronomyData", astronomyData)
            // SAVE TO COREDATA
        }
    }
}
