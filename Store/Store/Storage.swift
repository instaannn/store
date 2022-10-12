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
    
    static var shared = Storage()

    lazy var defaults = UserDefaults.standard

    // MARK: - Public methods
    
    func saveAvatar(image: Data, forKey: String) {
        defaults.set(image, forKey: forKey)
    }
    
    func checkAvatar(forKey: String) -> UIImage? {
        guard let dataImage = defaults.object(forKey: forKey) as? Data,
              let image = UIImage(data: dataImage) else {
            return UIImage(named: forKey)
        }
        return image
    }
}
