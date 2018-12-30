//
//  LocationMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 30..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class LocationMainVC: UIViewController, MTMapViewDelegate {
    @IBOutlet var mapParentView: UIView!
    @IBOutlet var cafeCollectionView: UICollectionView!
    
    var mapView: MTMapView!
    let myLat = [37.558553039064286,37.55724150280182,37.564685851074195,37.56260260091479,37.55850830654665,37.558553039064289]
    
    let myLong = [127.04255064005082,127.03836384152798,127.0427905587432,127.04483008120098,127.04660993475585,127.04255064005092]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cafeCollectionView.delegate = self
        cafeCollectionView.dataSource = self
        
        
        mapView = MTMapView(frame: mapParentView.frame)
        
        mapView.delegate = self
        mapView.baseMapType = .standard
        
        for i in 0..<myLat.count {
            let item = MTMapPOIItem()
            item.tag = i
            //        item.itemName = "현 위치"
            item.markerType = .customImage
            item.customImage = #imageLiteral(resourceName: "locationPoint")
            item.markerSelectedType = .customImage
            item.customSelectedImage = #imageLiteral(resourceName: "locationPointBig")
            item.mapPoint = MTMapPoint(geoCoord: .init(latitude: myLat[i], longitude: myLong[i]))
            item.showAnimationType = .springFromGround
            item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)    // 마커 위치 조정
            //            self.mapView.remove(self.mapView.findPOIItem(byTag: -1))
            self.mapView.addPOIItems([item])
        }
        
        self.mapView.fitAreaToShowAllPOIItems()
        let mapPoint = MTMapPoint.init(geoCoord: MTMapPointGeo.init(latitude: myLat[0], longitude: myLong[0]))
        
        self.mapView.setMapCenter(mapPoint, animated: true)
        self.mapView.setZoomLevel(2, animated: true)
        
        let item = self.mapView.findPOIItem(byTag: 0)
        self.mapView.select(item, animated: true)
        
        mapParentView.addSubview(mapView)
    }
}


extension LocationMainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myLat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cafeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.mapView.findPOIItem(byTag: indexPath.item)
        self.mapView.setMapCenter(item?.mapPoint, animated: true)
        self.mapView.select(item, animated: true)
    }
    

}
