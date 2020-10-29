//
//  Created by Dmitry Sochnev.
//  Copyright © 2020 Applicatura. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL?, placeholder: UIImage? = nil, cache: URLCache? = nil, completion: ((UIImage) -> Void)? = nil) {
        guard let url = url else { return }
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
            completion?(image)
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data,
                   let response = response,
                   ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async() {
                        self.image = image
                        completion?(image)
                    }
                }
            }).resume()
        }
    }
}
