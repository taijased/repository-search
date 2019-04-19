# Search repository

## API Github GET https://api.github.com/users/:user/repos

```
class APIProvider {
    func getRepositories(_ gitHubID: String) -> Observable<[Repository]> {
        guard !gitHubID.isEmpty,
            let url = URL(string: "https://api.github.com/users/\(gitHubID)/repos")
            else { return Observable.just([]) }
        
        return URLSession.shared
            .rx.json(request: URLRequest(url: url))
            .retry(3)
            .map {
                var repositories = [Repository]()
                if let items = $0 as? [[String : AnyObject]] {
                    items.forEach {
                        guard
                            let name = $0["name"] as? String,
                            let url = $0["html_url"] as? String
                        else { return }
                        repositories.append(Repository(name: name, url: url))
                        
                    }
                }
                return repositories
            }
    }
}

```

## Links

* [GitHub API](https://developer.github.com/v3/repos/)
* [Реализация MVVM в iOS с помощью RxSwift](https://habrahabr.ru/post/273455/)
