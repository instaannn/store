//
//  Storage.swift
//  Store
//
//  Created by Анна Сычева on 12.10.2022.
//

import UIKit

// MARK: - Storage
/// Хранение и проверка аватарки
final class Storage {

    // MARK: - Public properties
    
    static let shared = Storage()

    let defaults = UserDefaults.standard
    
    // MARK: - Initializers
    
    private init() { }

    // MARK: - Public methods
    
    func saveAvatar(image: Data, forKey: String) {
        defaults.set(image, forKey: forKey)
    }
    
    func saveOnboarding(forKey: String) {
        defaults.setValue(true, forKey: forKey)
    }
    
    func checkAvatar(forKey: String) -> UIImage? {
        guard let dataImage = defaults.object(forKey: forKey) as? Data,
              let image = UIImage(data: dataImage) else {
            return UIImage(named: forKey)
        }
        return image
    }
    
    func checkOnboarding(forKey: String) -> Bool {
        let onboarding = defaults.bool(forKey: forKey)
        return onboarding
    }
}
