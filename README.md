# DeezerApp


## Features

- Programmatic UI
- Generic Network Layer
- Only URLSession
- CoreData
- NSCache
- NotificationCenter
- CustomCells
- Custom Hex. UIColor
- MVVM


## Gantt Schema
<img src="https://raw.githubusercontent.com/onurduyar/DeezerApp/main/Assets/gantt.png?token=GHSAT0AAAAAABY3BBFFFIPBPQTT72HUBC52ZDCGOYQ" width="700" alt="">

## Requirements
<img src="https://raw.githubusercontent.com/onurduyar/DeezerApp/main/Assets/req.png?token=GHSAT0AAAAAABY3BBFE5IDIJFBXDPPVZZCWZDCGPXQ" width="900" alt="">

## Project Architecture
<img src="https://raw.githubusercontent.com/onurduyar/DeezerApp/main/Assets/mvvm.png?token=GHSAT0AAAAAABY3BBFE2YOGYGIBNLF5GYUIZDCGRQA" width="700" alt="">

## Code Samples

### UIImage+Extension -- NSCache

```swift

let cache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func downloadImage(from url: URL?){
        guard let url else {
            return
        }
        if let image = cache.object(forKey: url.absoluteString as NSString) as? UIImage{
            self.image = image
            return
        }
        
        let session = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                fatalError(error.localizedDescription)
            }
            guard let data,let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
            cache.setObject(image, forKey: url.absoluteString as NSString)
        }
        task.resume()
    }
}
```
### UIColor+Extension -- HexColor

```swift

extension UIColor {
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            self.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
}
```
