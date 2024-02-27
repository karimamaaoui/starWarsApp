//
//  ViewController.swift
//  secondproject
//
//  Created by karimamaaoui on 2/25/24.
//  Copyright © 2024 karimamaaoui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct Movie: Decodable {
        let title: String
        let director: String
        let producer: String
        let release_date: String
        let opening_crawl: String
    }
    
    struct MovieResponse: Decodable {
        let title: String
        let director: String
        let producer: String
        let release_date: String
        let opening_crawl: String
    }
    
    let endpoint = "https://swapi.dev/api/films/1/"
    var movies: [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    func fetchMovies() {
        guard let url = URL(string: endpoint) else {
            // Handle invalid URL
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching movies: \(error.localizedDescription)")
                return
            }
            guard let jsonData = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(Movie.self, from: jsonData)
                self.movies = [decoded]
                
              //  print("movie from decoded" ,self.movies)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON : \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }

        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.directorLabel.text = movie.director
        cell.producerLabel.text = movie.producer

        return cell
    }
}
