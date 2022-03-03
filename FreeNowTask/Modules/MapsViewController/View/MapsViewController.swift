//
//  MapsViewController.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 02/03/2022.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    @IBOutlet weak var mapsView: MKMapView!
    @IBOutlet weak var taxisCollectionView: UICollectionView!
    var viewModel: MapsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        loadMarkers()
    }
    
    private func setupCollection() {
        taxisCollectionView.delegate = self
        taxisCollectionView.dataSource = self
        taxisCollectionView.register(UINib(nibName: "TaxiCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "TaxiCollectionViewCell")
    }
    
    private func loadMarkers() {
        guard let viewModel = viewModel else { return }
        for location in viewModel.taxiMarkers {
            let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            mapsView.addAnnotation(annotation)
            mapsView.setRegion(region, animated: true)
        }
    }
}

extension MapsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.taxiMarkers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaxiCollectionViewCell", for: indexPath) as? TaxiCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = viewModel?.taxiMarkers[indexPath.row].title ?? ""
        cell.configure(with: title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let location = viewModel?.taxiMarkers[indexPath.row] {
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0002, longitudeDelta: 0.0002))
            mapsView.setRegion(region, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.4 , height: collectionView.frame.height)
    }
}
