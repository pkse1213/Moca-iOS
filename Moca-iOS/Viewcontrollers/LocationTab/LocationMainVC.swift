//
//  LocationMainVC.swift
//  Moca-iOS
//
//  Created by 박세은 on 2018. 12. 30..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit
import CoreLocation

class LocationMainVC: UIViewController{
    @IBOutlet var mapParentView: UIView!
    @IBOutlet var cafeCollectionView: UICollectionView!
    @IBOutlet var currentLocationButton: UIButton!
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic2VldW5pIiwiaXNzIjoiRG9JVFNPUFQifQ.56TYkh--ZSO7duJvdVLf-BOgFBPCG9fdDRGUGTmtC68"
    var selectedByMarker = false
    var mapView: MTMapView!
    let locationManager: CLLocationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var first = true
    var selectedIndex = 0 {
        didSet{  }
    }
    var nearByCafes: [NearByCafe]? {
        didSet {
            cafeCollectionView.reloadData()
            addMarkerInMap()
        } // collectionview , marker
    }
    var myLocation: Location? {
        didSet { initData() } //통신
    }

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
        print(location.latitude)
        print(location.longitute)
        NearByCafeService.shareInstance.getNearByCafe(isCafeDetail: 0, token: token, cafeId: 1, latitude: location.latitude , longitude: location.longitute, completion: { (res) in
            self.nearByCafes = res
            print("주변 카페 성공")
        }) { (err) in
            self.nearByCafes = []
            self.simpleAlert(title: "알림", message: "1km 반경에 카페가 없습니다")
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
        // 위치 사용 동의 알람창 최초
        isAuthorizedtoGetUserLocation()
        
        // 위치 동의 완료 위치 정보 사용
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation() // 위치 정보 받음
        }
    }
    
    @objc func setAddress(noti:Notification) {
        currentLocationButton.setImage(#imageLiteral(resourceName: "locationLocationGray"), for: .normal)
        
        if let address = noti.object as? Address{
            if let lat = Double(address.y) , let long = Double(address.x) {
                let location = Location(longitute: long, latitude: lat)
                myLocation = location
                updateSelectedAddress(latitude: lat, longitude: long)
            }
            if address.roadAddressName == ""  {
                showAddressInNavgationItem(address: address.placeName)
            } else {
                showAddressInNavgationItem(address: address.roadAddressName)
            }
        }
    }
    
    func showAddressInNavgationItem(address: String) {
        let navView = UIView()
        let label = UILabel()
        label.font = UIFont(name: "NanumGothicBold", size: 16)!
        
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
        manager.stopUpdatingLocation()
        let currentLocation = locations[locations.count-1]
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        let location = Location(longitute: long, latitude: lat)
        myLocation = location
       
        // 주소로 보여주기
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
    // 마커 눌렀을 때
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
        print("select:")
        if selectedByMarker {
            selectedByMarker = false
            selectedIndex = poiItem.tag
            mapView.select(poiItem, animated: true)
            cafeCollectionView.reloadData()
            cafeCollectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
        } else {
            selectedByMarker = true
        }
        return false
    }
    
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
        circle.circleFillColor = #colorLiteral(red: 0.8823529412, green: 0.6980392157, blue: 0.6392156863, alpha: 0.2625684307)
        
        let mapPointGeo = MTMapPointGeo(latitude: latitude, longitude: longitude)
        let mapPoint = MTMapPoint(geoCoord: mapPointGeo)
        circle.circleCenterPoint = mapPoint
        circle.circleRadius = 2000
        mapView.addCircle(circle)
        self.mapView.setMapCenter(mapPoint, zoomLevel: 4, animated: true)
    }
    
    // 주변 카페들 마커 추가
    func addMarkerInMap() {
        guard let nearByCafes = nearByCafes else { return }
        if nearByCafes.count != 0 {
            selectedByMarker = false
            for i in 0...nearByCafes.count-1 {
                let cafe = nearByCafes[i]
                let item = MTMapPOIItem()
                item.tag = i
                item.markerType = .customImage
                item.customImage = #imageLiteral(resourceName: "locationPoint")
                item.markerSelectedType = .customImage
                item.customSelectedImage = #imageLiteral(resourceName: "locationPointBig")
                item.mapPoint = MTMapPoint(geoCoord: .init(latitude: cafe.cafeLatitude, longitude: cafe.cafeLongitude))
                item.showAnimationType = .springFromGround
                item.customImageAnchorPointOffset = .init(offsetX: 30, offsetY: 0)
                self.mapView.addPOIItems([item])
            }
            let item = self.mapView.findPOIItem(byTag: 0)
            self.mapView.setMapCenter(item?.mapPoint, animated: true)
            self.mapView.setZoomLevel(2, animated: true)
            self.mapView.select(item, animated: true)
            self.mapView.fitAreaToShowAllPOIItems()
        }
        
        
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
            cafeCell.cafeImageView.imageFromUrl(cafe.cafeImgURL, defaultImgPath: "")
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
                    
                    guard let cafe = nearByCafes?[indexPath.item] else { return }
                    
                    dialogVC.startLocation = myLocation
                    dialogVC.cafe = cafe
                    self.addChild(dialogVC)
                    dialogVC.view.frame = self.view.frame
                    self.view.addSubview(dialogVC.view)
                    dialogVC.didMove(toParent: self )
                }
            } else {
                selectedByMarker = false
                let item = self.mapView.findPOIItem(byTag: indexPath.item)
                self.mapView.setMapCenter(item?.mapPoint, animated: true)
                self.mapView.select(item, animated: true)
                selectedIndex = indexPath.item
                cafeCollectionView.reloadData()
            }
        }
    }
}
