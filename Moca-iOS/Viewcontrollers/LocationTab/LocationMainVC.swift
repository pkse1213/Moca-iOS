//
//  LocationMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 30..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit
import CoreLocation

struct MyLocation {
    var longitute: Double
    var latitude: Double
}

class LocationMainVC: UIViewController{
    @IBOutlet var mapParentView: UIView!
    @IBOutlet var cafeCollectionView: UICollectionView!
    @IBOutlet var currentLocationButton: UIButton!
    
    var mapView: MTMapView!
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var selectedIndex = 0 {
        didSet{ cafeCollectionView.reloadData() }
    }
    var nearByCafes: [NearByCafe]? {
        didSet { } // collectionview , marker
    }
    var myLocation: MyLocation? {
        didSet { initData() } //통신
    }
    
    let myLat = [37.558553039064286,37.55724150280182,37.564685851074195,37.56260260091479,37.55850830654665,37.558553039064289]
    let myLong = [127.04255064005082,127.03836384152798,127.0427905587432,127.04483008120098,127.04660993475585,127.04255064005092]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        initMap()
        setNoti()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func isAuthorizedtoGetUserLocation() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func initData() {
        guard let location = myLocation else { return }
        NearByCafeService.shareInstance.getNearByCafe(isCafeDetail: 0, cafeId: 1, latitude: location.latitude , longitude: location.longitute, completion: { (res) in
            self.nearByCafes = res
            print("주변 카페 성공")
        }) { (err) in
            print("주변 카페 실패")
        }
    }
    
    private func setUpCollectionView() {
        cafeCollectionView.delegate = self
        cafeCollectionView.dataSource = self
    }
    
    private func setNoti() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(setAddress(noti:)), name: NSNotification.Name("setAddress") , object: nil)
    }
    
    @IBAction func currentLocationAction(_ sender: UIButton) {
        sender.setImage(#imageLiteral(resourceName: "locationLocationPink"), for: .normal)
        locationManager.startUpdatingLocation()
    }
    
    @objc func setAddress(noti:Notification) {
        currentLocationButton.setImage(#imageLiteral(resourceName: "locationLocationGray"), for: .normal)
        
        if let address = noti.object as? Address{
            if let lat = Double(address.y) , let long = Double(address.x) {
                let location = MyLocation(longitute: lat, latitude: long)
                myLocation = location
                updateSelectedAddress(latitude: lat, longitude: long)
            }
            showAddressInNavgationItem(address: address.roadAddressName)
        }
    }
    
    func showAddressInNavgationItem(address: String) {
        let navView = UIView()
        let label = UILabel()
        label.text = address
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
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        if let vc = UIStoryboard(name: "LocationTab", bundle: nil).instantiateViewController(withIdentifier: "LocationSearchVC") as? LocationSearchVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LocationMainVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[locations.count-1]
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        let location = MyLocation(longitute: lat, latitude: long)
        myLocation = location
        geoCoder.reverseGeocodeLocation(currentLocation) { (placemark, error) in
            if error != nil {
                print("Error")
            } else {
                if let place = placemark?.first { // 가장 최신의 정보 획득
                    var address = ""
                    if let administrativeArea = place.administrativeArea{
                        if administrativeArea == "서울특별시" {
                            address = "서울"
                        } else {
                            address = administrativeArea
                        }
                    }
                    if let locality = place.locality {
                        address = address + " " + locality
                    }
                    if let name = place.name {
                        address = address + " " +  name
                    }
                    self.showAddressInNavgationItem(address: address)
                }
            }
        }
        updateCurrentLocation(latitude: lat, longitude: long)
    }
    
}

extension LocationMainVC: MTMapViewDelegate {
    func initMap() {
        // 위치 사용 동의 알람창 최초
        isAuthorizedtoGetUserLocation()
        
        // 위치 동의 완료 위치 정보 사용
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation() // 위치 정보 받음
        }
        
        mapView = MTMapView(frame: self.mapParentView.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        
//        addMarkerInMap()
        
        mapParentView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let bottom = mapView.bottomAnchor.constraint(equalTo: mapParentView.bottomAnchor)
        let top = mapView.topAnchor.constraint(equalTo: mapParentView.topAnchor)
        let leading = mapView.leadingAnchor.constraint(equalTo: mapParentView.leadingAnchor)
        let trailing = mapView.trailingAnchor.constraint(equalTo: mapParentView.trailingAnchor)
        mapParentView.addConstraints([top, bottom, leading, trailing])
    }
    
    // 현재 위치 기반으로 업데이트
    func updateCurrentLocation(latitude: Double, longitude: Double) {
        // 지도 위 객체 모두 삭제
        removeAllObjectInMap()
        // 원 생성
        makeCircleInMap(latitude: latitude, longitude: longitude)
        
        // 현 위치 마커 생성
        let item = MTMapPOIItem()
        item.tag = -1
        item.markerType = .customImage
        item.customImage = #imageLiteral(resourceName: "locationNow")
        item.markerSelectedType = .none
        item.mapPoint = MTMapPoint(geoCoord: .init(latitude: latitude, longitude: longitude))
        item.showAnimationType = .noAnimation
        item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 30)    // 마커 위치 조정
        self.mapView?.add(item)
        // 추적 멈춤
        locationManager.stopUpdatingLocation()
    }
    
    // 주소 설정 기반으로 업데이트
    func updateSelectedAddress(latitude: Double, longitude: Double) {
        // 지도 위 객체 모두 삭제
        removeAllObjectInMap()
        // 원 생성
        makeCircleInMap(latitude: latitude, longitude: longitude)
        
    }
    
    // 지도 위 객체 모두 삭제
    func removeAllObjectInMap() {
        self.mapView.removeAllPOIItems()
        self.mapView.removeAllCircles()
    }
    
    // 원 생성 method
    func makeCircleInMap(latitude: Double, longitude: Double) {
        let circle = MTMapCircle()
        circle.circleLineColor = #colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 1)
        circle.circleFillColor = #colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 0.4)
        
        let mapPointGeo = MTMapPointGeo(latitude: latitude, longitude: longitude)
        let mapPoint = MTMapPoint(geoCoord: mapPointGeo)
        circle.circleCenterPoint = mapPoint
        circle.circleRadius = 1000
        mapView.addCircle(circle)
        self.mapView.setMapCenter(mapPoint, zoomLevel: 3, animated: true)
    }
    
    func addMarkerInMap() {
        for i in 0..<myLat.count {
            let item = MTMapPOIItem()
            item.tag = i
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
        guard let cafe = nearByCafes else { return 0 }
        return cafe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let cafe = nearByCafes?[indexPath.item] else { return cell }
        
        if let cafeCell = cafeCollectionView.dequeueReusableCell(withReuseIdentifier: "LocationMapCafeCell", for: indexPath) as? LocationMapCafeCell {
            cafeCell.cafeNameLabel.text = cafe.cafeName
            cafeCell.cafeLocationLabel.text = "\(cafe.distance) 이내"
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
