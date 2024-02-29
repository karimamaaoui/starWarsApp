//
//  ViewController.swift
//  secondproject
//
//  Created by karimamaaoui on 2/25/24.
//  Copyright © 2024 karimamaaoui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct Movie: Codable {
        let title: String
        let director: String
        let producer: String
        let release_date: String
        let opening_crawl: String
    }
    
    let endpoint = "https://swapi.dev/api/films/1"
    var movies: [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        //
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedData = movies[indexPath.row]
        print("you select cell ", selectedData)

        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailsView") as? DetailsMovieViewController {
            vc.labtitle = selectedData.title
            vc.labrelease = selectedData.release_date
            vc.labdirector = selectedData.director
            vc.labproducer = selectedData.producer
            vc.labopening = selectedData.opening_crawl
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Failed to instantiate DetailsMovieViewController from storyboard.")
        }
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
                
                print("movie from decoded" ,self.movies[0].title)
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
        guard let cellule = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }

        let movie = movies[0]
        print("movie ligne 73" ,movie.director)
        cellule.titleLabel.text = movie.title
        cellule.directorLabel.text = movie.director
        cellule.producerLAbel.text = movie.producer
       // cellule.dateLabel = movie.release_date
        cellule.openingCrawlLabel.text = movie.opening_crawl
        return cellule
    }
}
