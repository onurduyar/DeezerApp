
<p align="center">
  <a href="https://github.com/onurduyar/DeezerApp">
    <img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/logo.png" alt="Logo" width="100" height="100">
  </a>
  <h1 align="center">Deezer App</h1>
  </p>
</p>

The application has been developed using the MVVM architectural pattern, aiming to offer users the capability to explore music genres and artists, as well as access comprehensive details about them. Employing a RESTful API, the app retrieves data regarding categories, artists, and albums. This app enables users to explore a vast music collection, discover their preferred songs, navigate through albums and playlists, and save their favorites for future reference.

## GitFlow Strategy
<img src="https://raw.githubusercontent.com/onurduyar/DeezerApp/main/Assets/gitflow.png?token=GHSAT0AAAAAABY3BBFE7AE54SIJRRXGUYYEZDCHNTQ" alt="">

## Features

- Programmatic UI
- Generic Network Layer
- Only URLSession
- CoreData
- NSCache
- NotificationCenter
- CustomCells
- Custom Hex. UIColor
- Generic BaseVC and BaseViewModel

| Category     | ArtistList    | Artist             |
| ------------ | ------------- | ------------------ |
| <img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/category.png" width="270" height = "300%" alt=""> | <img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/artistList.png" width="270" height = "300%" alt="">    | <img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/artist.png" width="270" height = "300%" alt=""> |


| Tracks       | Favorites     |
| ------------ | ------------- |
| -<img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/tracks.png" width="270" height = "300%" alt=""> | <img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/favorites.png" width="270" height = "300%" alt="">    |


## Gantt Schema
<img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/gantt.png" width="700" alt="">

## Requirements
<img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/req.png" width="900" alt="">

## Project Architecture - MVVM
<img src="https://github.com/onurduyar/DeezerApp/blob/main/Assets/mvvm.png" width="700" alt="">

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
### BaseViewModel

```swift

protocol BaseViewModel {
    associatedtype Model
    var data: Model? { get set }
    func fetchData(by id: Int?,completion: @escaping ((Result<Model?, Error>) -> Void ))
}

extension BaseViewModel {
    func fetchData(by id: Int?,completion: @escaping ((Result<Model?, Error>) -> Void )) {}
}
```
### Generic BaseVC

```swift

class BaseViewController<T: UIView>: UIViewController {
    // Properties
    let baseViewModel: any BaseViewModel
    
    var contentView: T {
        return view as! T
    }
    
    // Init
    init(viewModel: any BaseViewModel) {
        self.baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle
    override func loadView() {
        view = T()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //baseViewModel.delegate = self
    }
    
    // Methods
    func fetchData(id :Int? = nil) {
        fatalError("fetchData must be overridden")
    }
}

// MARK: - BaseViewModelDelegate
extension BaseViewController: BaseViewModelDelegate {
    func onDataUpdated() {
        fatalError("onDataUpdated must be overridden")
    }
}
protocol BaseViewModelDelegate: AnyObject {
    func onDataUpdated()
}

protocol CollectionViewDelegate: AnyObject,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
protocol TableViewDelegate: AnyObject,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
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

https://github.com/onurduyar/DeezerApp/assets/61862393/867659fa-cdd4-4961-889f-c095298e1638
