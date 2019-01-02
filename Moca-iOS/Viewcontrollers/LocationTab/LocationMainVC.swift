//
//  LocationMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 30..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class LocationMainVC: UIViewController{
    @IBOutlet var mapParentView: UIView!
    @IBOutlet var cafeCollectionView: UICollectionView!
    var selectedIndex = 0 {
        didSet{
            cafeCollectionView.reloadData()
        }
    }
    
    var mapView: MTMapView!
    let myLat = [37.558553039064286,37.55724150280182,37.564685851074195,37.56260260091479,37.55850830654665,37.558553039064289]
    
    let myLong = [127.04255064005082,127.03836384152798,127.0427905587432,127.04483008120098,127.04660993475585,127.04255064005092]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        mapInit()
        setNoti()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setNoti() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(setAddress(noti:)), name: NSNotification.Name("setAddress") , object: nil)
    }
    
    @objc func setAddress(noti:Notification) {
        if let address = noti.object as? Address{
            let navView = UIView()
            let label = UILabel()
            label.text = address.roadAddressName
            label.sizeToFit()
            label.center = navView.center
            label.textAlignment = NSTextAlignment.center
            
            let image = UIImageView()
            image.image = #imageLiteral(resourceName: "locationSearch")
            
            let imageAspect = image.image!.size.width/image.image!.size.height
            image.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
            image.contentMode = UIView.ContentMode.scaleAspectFit
            
            navView.addSubview(label)
            navView.addSubview(image)
            
            self.navigationItem.titleView = navView
            navView.sizeToFit()
        }
    }
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationSearchVC") as? LocationSearchVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setUpCollectionView() {
        cafeCollectionView.delegate = self
        cafeCollectionView.dataSource = self
    }
    
    private func mapInit() {
        mapView = MTMapView(frame: self.mapParentView.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        
        addMarkerInMap()
        
        mapParentView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let bottom = mapView.bottomAnchor.constraint(equalTo: mapParentView.bottomAnchor)
        let top = mapView.topAnchor.constraint(equalTo: mapParentView.topAnchor)
        let leading = mapView.leadingAnchor.constraint(equalTo: mapParentView.leadingAnchor)
        let trailing = mapView.trailingAnchor.constraint(equalTo: mapParentView.trailingAnchor)
        mapParentView.addConstraints([top, bottom, leading, trailing])
    }
    
    private func addMarkerInMap() {
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
    }
}


extension LocationMainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myLat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let cafeCell = cafeCollectionView.dequeueReusableCell(withReuseIdentifier: "LocationMapCafeCell", for: indexPath) as? LocationMapCafeCell {
            cafeCell.cafeImageView.image = UIImage(named: "sample\(indexPath.item+1)")
            if indexPath.item == selectedIndex {
                cafeCell.selectedFlag = true
            } else {
                cafeCell.selectedFlag = false
            }
            cell = cafeCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = cafeCollectionView.cellForItem(at: indexPath) as? LocationMapCafeCell {
            if cell.selectedFlag == true {
                if let dialogVC = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationMapDialogVC") as? LocationMapDialogVC {
                    self.addChild(dialogVC)
                    dialogVC.view.frame = self.view.frame
                    self.view.addSubview(dialogVC.view)
                    dialogVC.didMove(toParent: self )
                }
                
            } else {
                let item = self.mapView.findPOIItem(byTag: indexPath.item)
                self.mapView.setMapCenter(item?.mapPoint, animated: true)
                self.mapView.select(item, animated: true)
                
                selectedIndex = indexPath.item
            }
        }
        
        
    }
    
    
}

extension LocationMainVC: MTMapViewDelegate {
    
}
