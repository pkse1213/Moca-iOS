//
//  LocationCafeDetailView.swift
//  Moca-iOS
//
//  Created by 박세은 on 2019. 1. 2..
//  Copyright © 2019년 박세은. All rights reserved.
//

import UIKit
import CoreLocation

class LocationCafeDetailVC: UIViewController {
    @IBOutlet weak var cafeDetailTableView: UITableView!
    let locationManager = CLLocationManager()
    var cafeId = 1
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    
    var cafeInfo: CafeDetailInfo?
    var cafeImages: [CafeDetailImage]?
    var cafeSignitures: [CafeDetailSigniture]?
    var cafeReviews: [CafeDetailReview]?
    var nearByCafes: [NearByCafe]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func initData() {
        CafeDetailInfoService.shareInstance.getCafeDetailInfo(cafeId: cafeId, token: token, completion: { (res) in
            print("카페 디테일 info 성공")
            self.cafeInfo = res
        }) { (err) in
            print("카페 디테일 info 실패")
        }
        CafeDetailImageService.shareInstance.getCafeDetailImage(cafeId: cafeId, token: token, completion: { (res) in
            print("카페 디테일 imaeg 성공")
            self.cafeImages = res
        }) { (err) in
            print("카페 디테일 imgae 실패")
        }
        CafeDetailSignitureService.shareInstance.getCafeDetailSigniture(cafeId: cafeId, token: token, completion: { (res) in
            print("카페 디테일 signiture 성공")
            self.cafeSignitures = res
        }) { (err) in
            print("카페 디테일 signiture 실패")
        }
        CafeDetailReviewService.shareInstance.getCafeDetailReview(cafeId: cafeId, token: token, completion: { (res) in
            print("카페 디테일 review 성공")
            self.cafeReviews = res
        }) { (err) in
            print("카페 디테일 review 실패")
        }
        NearByCafeService.shareInstance.getNearByCafe(isCafeDetail: 1, cafeId: cafeId, latitude: 0.0, longitude: 0.0, completion: { (res) in
            self.nearByCafes = res
            print("주변 카페 성공")
        }) { (err) in
            print("주변 카페 실패")
        }
    }
    
    private func setUpTableView() {
        cafeDetailTableView.delegate = self
        cafeDetailTableView.dataSource = self
    }
    
    func isAuthorizedtoGetUserLocation() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        
    }
    
    @IBAction func scrapAction(_ sender: UIButton) {
        guard let cafe = cafeInfo else { return }
    }
    
    @IBAction func locationActon(_ sender: UIButton) {
        // 위치 사용 동의 알람창 최초
        isAuthorizedtoGetUserLocation()
        
        // 위치 동의 완료 위치 정보 사용
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation() // 위치 정보 받음
        }
    }
    
    @objc func reviewLookActin(_:UIButton) {
        cafeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
}

extension LocationCafeDetailVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let currentLocation = locations[locations.count-1]
        let lat = currentLocation.coordinate.latitude
        let long = currentLocation.coordinate.longitude
        let location = Location(longitute: lat, latitude: long)
        
        guard let cafe = cafeInfo else { return }
        let cafeLocation = Location(longitute: cafe.cafeLongitude, latitude: cafe.cafeLatitude)
        goToKaKaoMapApp(start: location, end: cafeLocation)
    }
}

extension LocationCafeDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = cafeInfo, let _ = cafeImages, let reviews = cafeReviews, let _ = nearByCafes else { return 0 }
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return reviews.count == 0 ? 0 : reviews.count + 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let info = cafeInfo, let images = cafeImages, let reviews = cafeReviews, let nearCafes = nearByCafes else { return cell }
        
        switch indexPath.section {
        case 0:
            if let imageCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailImageListCell") as? CafeDetailImageListCell {
                imageCell.images = images
                cell = imageCell
            }
        case 1:
            if let infoCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailInfoCell") as? CafeDetailInfoCell {
                infoCell.reviewLookButton.addTarget(self, action: #selector(reviewLookActin(_:)), for: .touchUpInside)
                infoCell.nameLabel.text = info.cafeName
                infoCell.addressLabel.text = info.addressDistrictName
                infoCell.detailAddressLabel.text = info.cafeAddressDetail
                infoCell.dayLabel.text = info.cafeDays
                infoCell.timeLabel.text = info.cafeTimes
                infoCell.phoneNumLabel.text = info.cafePhone
                infoCell.etcFlag = [info.cafeOptionParking, info.cafeOptionWifi, info.cafeOptionSmokingarea, info.cafeOptionAllnight, info.cafeOptionReservation]
                cell = infoCell
            }
        case 2:
            switch indexPath.row {
            case 0:
                if let headerCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailReviewHeaderCell") as? CafeDetailReviewHeaderCell {
                    cell = headerCell
                }
            case reviews.count+1:
                if let footerCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailReviewFooterCell") as? CafeDetailReviewFooterCell {
                    footerCell.parentVC = self
                    
                    cell = footerCell
                }
            default:
                if let reviewCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CommunityFeedCell") as? CommunityFeedCell {
                    reviewCell.navigationController = self.navigationController
                    let review = reviews[indexPath.row-1]
                    
                    reviewCell.nameLabel.text = review.userID
                    reviewCell.cafeNameLabel.text = review.cafeName
                    reviewCell.cafeAddressLabel.text = review.cafeAddress
                    reviewCell.likeCntLabel.text = "\(review.likeCount)"
                    reviewCell.commentCntLabel.text = "\(review.commentCount)"
                    reviewCell.reviewContentLabel.text = review.reviewTitle
                    reviewCell.timeLabel.text = review.time
                    cell = reviewCell
                }
            }
        case 3:
            if let cafeCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailNearCafeCell") as? CafeDetailNearCafeCell {
                cafeCell.nearByCafes = nearCafes
                cell = cafeCell
            }
        default:
            return cell
        }
        
        return cell
        
    }
}
