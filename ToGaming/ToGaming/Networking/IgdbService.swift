//
//  GameSearchService.swift
//  ToGaming
//
//  Created by felipe azevedo on 15/04/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class IgdbService {
    
    private let baseURL = "https://api.igdb.com/v4/"
    private var clientId: String = ""
    private var token: String = ""
    
    func config() {
        let userConfig = PersistenceController().getUserConfig()
        
        clientId = userConfig?.clientId ?? ""
        token = userConfig?.secretKey ?? ""
    }
 
    func searchGame(name: String, result: @escaping([GameSearchViewModel]?) -> ()) {
        
        let uri = "games"
        let url = "\(baseURL)\(uri)"
        
        let body = """
        search "\(name)"; fields name, first_release_date, aggregated_rating, platforms.name, cover.url, involved_companies.developer, involved_companies.company.name; where parent_game = null;
        """
        
        let headers: HTTPHeaders = ["client-id": "\(clientId)", "authorization": "Bearer \(token)"]
        
        do {
            var request = try URLRequest(url: URL(string: url)!, method: .post, headers: headers)
            request.httpBody = body.data(using: .utf8)
            
            AF.request(request).responseData { response in
                switch response.result {
                case .success(let jsonData):
                    do {
                        let json = try JSON(data: jsonData).array
                        if let json = json {
                            let results = json.compactMap{ GameSearchViewModel(
                                id: $0["id"].intValue,
                                aggregatedRating: $0["aggregated_rating"].double,
                                cover: $0["cover"]["id"].exists() ? CoverGameSearchViewModel(
                                    id: $0["cover"]["id"].intValue,
                                    url: $0["cover"]["url"].stringValue) : nil,
                                firstReleaseDate: $0["first_release_date"].int,
                                name: $0["name"].stringValue,
                                platforms: $0["platforms"].arrayValue.compactMap({ platform in
                                    PlatformGameSearchViewModel(
                                        id: platform["id"].intValue,
                                        name: platform["name"].stringValue) }),
                                involvedCompanies: $0["involved_companies"].arrayValue.compactMap({ companies in
                                    InvolvedCompanyGameSearchViewModel(
                                        id: companies["id"].intValue,
                                        company: CompanyGameSearchViewModel(
                                            id: companies["company"]["id"].intValue,
                                            name: companies["company"]["name"].stringValue),
                                        developer: companies["developer"].boolValue)
                                })) }
                            result(results)
                        } else {
                            result([])
                        }
                    } catch {
                        result(nil)
                    }
                    break
                case .failure(let error):
                    print(error)
                    result(nil)
                    break
                }
            }
        } catch {
            result(nil)
        }
    }
    
    func getGameById(id: Int, result: @escaping(GameSearchDataViewModel?) -> ()) {
        
        let uri = "games"
        let url = "\(baseURL)\(uri)"
        
        let body = """
            fields name, url, first_release_date, genres.name, themes.name, summary, storyline, screenshots.url, aggregated_rating, aggregated_rating_count, platforms.name, cover.url, involved_companies.publisher, involved_companies.developer, involved_companies.company.name; where id = \(id);
        """
        
        let headers: HTTPHeaders = ["client-id": "\(clientId)", "authorization": "Bearer \(token)"]
        
        do {
            var request = try URLRequest(url: URL(string: url)!, method: .post, headers: headers)
            request.httpBody = body.data(using: .utf8)
            
            AF.request(request).responseData { response in
                switch response.result {
                case .success(let jsonData):
                    do {
                        let json = try JSON(data: jsonData).array?.first
                        if let json = json {
                            let results = GameSearchDataViewModel(
                                id: json["id"].intValue,
                                aggregatedRating: json["aggregated_rating"].double,
                                aggregatedRatingCount: json["aggregated_rating_count"].int,
                                cover: json["cover"]["id"].exists() ? CoverGameSearchDataViewModel(
                                    id: json["cover"]["id"].intValue,
                                    url: json["cover"]["url"].stringValue) : nil,
                                firstReleaseDate: json["first_release_date"].int,
                                genres: json["genres"].arrayValue.compactMap({ genre in
                                    GenreGameSearchDataViewModel(
                                        id: genre["id"].intValue,
                                        name: genre["name"].stringValue)
                                }),
                                involvedCompanies: json["involved_companies"].arrayValue.compactMap({ companies in
                                    InvolvedCompanyGameSearchDataViewModel(
                                        id: companies["id"].intValue,
                                        company: CompanyGameSearchDataViewModel(
                                            id: companies["company"]["id"].intValue,
                                            name: companies["company"]["name"].stringValue),
                                        developer: companies["developer"].boolValue,
                                        publisher: companies["publisher"].boolValue)
                                }), name: json["name"].stringValue,
                                platforms: json["platforms"].arrayValue.compactMap({ platform in
                                    PlatformGameSearchDataViewModel(
                                        id: platform["id"].intValue,
                                        name: platform["name"].stringValue) }),
                                screenshots: json["screenshots"].array?.count ?? 0 > 0 ? json["screenshots"].arrayValue.compactMap({ screenshot in
                                    CoverGameSearchDataViewModel(
                                        id: screenshot["id"].intValue,
                                        url: screenshot["url"].stringValue)
                                }) : [],
                                storyline: json["storyline"].string,
                                summary: json["summary"].string,
                                themes: json["themes"].arrayValue.compactMap({ theme in
                                    GenreGameSearchDataViewModel(
                                        id: theme["id"].intValue,
                                        name: theme["name"].stringValue)
                                }),
                                url: json["url"].stringValue)
                            result(results)
                        }
                    } catch {
                        result(nil)
                    }
                    break
                case .failure(let error):
                    print(error)
                    result(nil)
                    break
                }
            }
        } catch {
            result(nil)
        }
    }
}
