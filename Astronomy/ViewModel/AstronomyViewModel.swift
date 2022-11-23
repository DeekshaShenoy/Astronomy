//
//  AstronomyViewModel.swift
//  Astronomy
//
//  Created by Deeksha Shenoy on 23/11/22.
//

import Foundation

final class AstronomyViewModel {
    private(set) var astronomyDataProvider = AstronomyDataProvider()

    var primaryCareSuccessCallback: ((AstronomyResponse?) -> Void)?
    var primaryCareFailureCallback: (() -> Void)?

    init(astronomyDataProvider: AstronomyDataProvider = AstronomyDataProvider()) {
        self.astronomyDataProvider = astronomyDataProvider
    }
    
    // TODO: Use listner Pattern
    func fetchAstronomyInfo() {
        
        astronomyDataProvider.loadAstronomyInfo { astronomyData, error in
            guard error == nil else {
                self.primaryCareFailureCallback?()
                return
            }
            self.saveAstronomyInfo(astronomyResponse: astronomyData)
            self.primaryCareSuccessCallback?(astronomyData)
        }
    }
    
    func getAstronomyInfo() -> AstronomyResponse? {
        do {
            let astronomyResponse = try UserDefaults.standard.getObject(forKey: "AstronomyObject", castTo: AstronomyResponse.self)
            return astronomyResponse
        }
        catch {
            return nil
        }
    }
    
    func dateIsInToday(dateString: String?) -> Bool {
        guard let responsedate = getDate(from: dateString) else {
            return false
        }
        return Calendar.current.isDateInToday(responsedate)
    }

    // TODO: To create DateFormatter class for all date time handling
    private func getDate(from dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)
    }
    
    private func saveAstronomyInfo(astronomyResponse: AstronomyResponse?) {
        guard let astronomyObj = astronomyResponse else { return }
        do {
            // TODO: Save All Userdefaults key in single file
            try UserDefaults.standard.setObject(astronomyObj, forKey: "AstronomyObject")
        }
        catch {
            // DO nothing Log this info
        }
    }
}
