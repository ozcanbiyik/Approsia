//
//  ViewController.swift
//  FinalProjesi
//
//  Created by Ozcan Biyik on 11.01.2022.
//

import UIKit
import Alamofire
import Kingfisher
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var yemeklerTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!

    
    var lm = CLLocationManager()
    
   
    
    var yemek : Yemekler?
    
    var yemeklerListe = [Yemekler]()
    var viewControllerPresenterNesnesi : ViewToPresenterViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
   
        
        
        
        //41.0370004,28.9675821
        

        
        let sourceLocation = CLLocationCoordinate2D(latitude: 41.0370004, longitude: 28.9675821)
        let destinationLocation = CLLocationCoordinate2D(latitude: 41.033459, longitude: 28.977733)
        
        createPath(sourceLocation: sourceLocation, destinationLocation: destinationLocation)
        
        self.mapView.delegate = self
        
        yemeklerTableView.delegate = self
        yemeklerTableView.dataSource = self
        searchBar.delegate = self
        
        ViewControllerRouter.createModule(ref: self)
        
        
        
        
        
        
        
    }
    
    func createPath(sourceLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D){
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        let sourceAnotation = MKPointAnnotation()
        sourceAnotation.title = "Approsia"
        sourceAnotation.subtitle = "Best Food Place"
        if let location = sourcePlaceMark.location{
            sourceAnotation.coordinate = location.coordinate
        }
        
        let destinationAnotation = MKPointAnnotation()
        destinationAnotation.title = "Home"
        destinationAnotation.subtitle = "Something"
        if let location = destinationPlaceMark.location{
            sourceAnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnotation,destinationAnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate{(response, error) in
            guard let response = response else {
                if let error = error{
                    
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level : MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        viewControllerPresenterNesnesi?.yemekleriListele()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetayVC"{
            let yemek = sender as? Yemekler
            let gidilecekVC  = segue.destination as! YemekDetayVC
            gidilecekVC.yemek = yemek
        }
    }
    
}

extension ViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            viewControllerPresenterNesnesi?.yemekleriListele()
        }else{
            viewControllerPresenterNesnesi?.ara(aramaKelimesi: searchText)
        }
    }
}

extension ViewController : PresenterToViewViewControllerProtocol{
    func vieweVeriGonder(yemeklerListesi: Array<Yemekler>) {
        self.yemeklerListe = yemeklerListesi
        DispatchQueue.main.async {
            self.yemeklerTableView.reloadData()
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemeklerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yemek = yemeklerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "yemeklerHucre", for: indexPath) as! TableViewCell
        cell.yemekAdLabel.text = "\(yemek.yemek_adi!)"
        cell.yemekFiyatLabel.text = "\(yemek.yemek_fiyat!)₺"
        cell.yemekGorselAdi(gorselAdi : yemek.yemek_resim_adi!)
        
        
        cell.backgroundColor = UIColor(white : 0.95, alpha: 1)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let yemek = yemeklerListe[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetayVC", sender: yemek)
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let silAction = UIContextualAction(style: .destructive, title: "Hemen Ekle"){
            (UIContextualAction,view,bool) in
            
            let sepet = self.yemeklerListe[indexPath.row]
            let alert = UIAlertController(title: "Ekleme İşlemi", message: "\(sepet.yemek_adi!) eklensin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){action in}
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){action in
                self.viewControllerPresenterNesnesi?.ekle(yemek_adi: sepet.yemek_adi!, yemek_resim_adi: sepet.yemek_resim_adi!, yemek_fiyat: Int(sepet.yemek_fiyat!)!, yemek_siparis_adet: 1, kullanici_adi: "ozcan_biyik")}
                alert.addAction(evetAction)
                self.present(alert,animated: true)
            
            }
    
        return UISwipeActionsConfiguration(actions: [silAction])
        
    }
    
    
    
}

extension ViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay : MKOverlay) -> MKOverlayRenderer {
        let rendere = MKPolylineRenderer(overlay: overlay)
        rendere.lineWidth = 5
        rendere.strokeColor = .systemGreen
        
        return rendere
    }
}
