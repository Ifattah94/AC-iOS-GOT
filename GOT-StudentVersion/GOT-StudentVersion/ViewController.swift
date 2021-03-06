//
//  ViewController.swift
//  GOT-StudentVersion
//
//  Created by C4Q  on 11/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    
    @IBOutlet weak var gotTableView: UITableView!
    
    @IBOutlet weak var episodeSearchBar: UISearchBar!
    var episodes: [[GOTEpisode]] = [[]]
    let allEps = GOTEpisode.allEpisodes
    var searchTerm: String? {
        didSet {
            self.gotTableView.reloadData()
        }
    }
    var filteredEpisodes: [GOTEpisode] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return allEps
        }
        return allEps.filter({$0.name.lowercased().contains(searchTerm.lowercased())})
    }
    func loadData() {
        episodes[0] = GOTEpisode.allEpisodes.filter({$0.season == 1})
        episodes.append(GOTEpisode.allEpisodes.filter({$0.season == 2}))
        episodes.append(GOTEpisode.allEpisodes.filter({$0.season == 3}))
        episodes.append(GOTEpisode.allEpisodes.filter({$0.season == 4}))
        episodes.append(GOTEpisode.allEpisodes.filter({$0.season == 5}))
        episodes.append(GOTEpisode.allEpisodes.filter({$0.season == 6}))
        episodes.append(GOTEpisode.allEpisodes.filter({$0.season == 7}))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return "Season 1"
        case 1:
            return "Season 2"
        case 2:
            return "Season 3"
        case 3:
            return "Season 4"
        case 4:
            return "Season 5"
        case 5:
            return "Season 6"
        case 6:
            return "Season 7"
        default:
            return nil
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return filteredEpisodes.filter{$0.season == section + 1}.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = filteredEpisodes.filter{$0.season == indexPath.section + 1}[indexPath.row]
        
        
        let left = indexPath.section % 2 == 0
        if left {
            guard let leftCell = gotTableView.dequeueReusableCell(withIdentifier: "GoT Pic Left", for: indexPath) as? GoTTableViewCell else {
                return UITableViewCell()
            }
            leftCell.episodeTitle.text = episode.name
            leftCell.seasonEpisode.text = "S:\(episode.season)" + " " + "E:\(episode.number)"
            leftCell.episodeImage.image = UIImage(named:episode.originalImageID)
            return leftCell
        }
        else {
            guard let rightCell = gotTableView.dequeueReusableCell(withIdentifier: "GoT Pic Right", for: indexPath) as? GoTTableViewCell else {
                return UITableViewCell()
            }
            rightCell.episodeTitleRight.text = episode.name
            rightCell.seasonEpisodeRIght.text = "S:\(episode.season)" + " " + "E:\(episode.number)"
            rightCell.episodeImageRight.image = UIImage(named:episode.originalImageID)
            return rightCell
            
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationEpisode = segue.destination as? GoTEpisodeViewController {
            let selectedSection = gotTableView.indexPathForSelectedRow!.section
            let selectedRow = gotTableView.indexPathForSelectedRow!.row
            let selectedEpisode = filteredEpisodes.filter{$0.season == selectedSection + 1}[selectedRow]
            destinationEpisode.myEpisode = selectedEpisode
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        gotTableView.delegate = self
        gotTableView.dataSource = self
        self.episodeSearchBar.delegate = self 
        // Do any additional setup after loading the view, typically from a nib.
    }



}

