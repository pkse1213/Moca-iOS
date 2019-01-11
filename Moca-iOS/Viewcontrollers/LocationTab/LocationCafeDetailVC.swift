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
    @IBOutlet weak var scrapButton: UIButton!
    let locationManager = CLLocationManager()
    var cafeId = 3
    var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiZmlyc3QiLCJpc3MiOiJEb0lUU09QVCJ9.0wvtXq58-W8xkndwb_3GYiJJEbq8zNEXzm6fnHA6xRM"
    
    var cafeInfo: CafeDetailInfo? {
        didSet {
            initNearbyCafe()
            setScrapButtonImage()
        }
    }
    var cafeImages: [CafeDetailImage]? {
        didSet { cafeDetailTableView.reloadData() }
    }
    var cafeSignitures: [CafeDetailSigniture]? {
        didSet { cafeDetailTableView.reloadData() }
    }
    var cafeReviews: [CommunityReview]? {
        didSet { cafeDetailTableView.reloadData() }
    }
    var nearByCafes: [NearByCafe]? {
        didSet { cafeDetailTableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInfoData()
        initData()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    private func initInfoData() {
        CafeDetailInfoService.shareInstance.getCafeDetailInfo(cafeId: cafeId, token: token, completion: { (res) in
            self.cafeInfo = res
        }) { (err) in
            print("카페 디테일 info 실패")
        }
    }
    
    private func initData() {
        CafeDetailImageService.shareInstance.getCafeDetailImage(cafeId: cafeId, token: token, completion: { (res) in
            self.cafeImages = res
        }) { (err) in
             self.cafeImages = []
            print("카페 디테일 imgae 실패 \(err)")
        }
        CafeDetailSignitureService.shareInstance.getCafeDetailSigniture(cafeId: cafeId, token: token, completion: { (res) in
            self.cafeSignitures = res
        }) { (err) in
            self.cafeSignitures = []
            print("카페 디테일 signiture 실패 \(err)")
        }
        CafeDetailReviewService.shareInstance.getCafeDetailReview(cafeId: cafeId, token: token, completion: { (res) in
            self.cafeReviews = res
        }) { (err) in
            self.cafeReviews = []
            print("카페 디테일 review 실패 \(err)")
        }
        
    }
    
    private func initNearbyCafe() {
        guard let cafeInfo = cafeInfo else { return }
        NearByCafeService.shareInstance.getNearByCafe(isCafeDetail: 1, token: token, cafeId: cafeId, latitude: cafeInfo.cafeLatitude, longitude: cafeInfo.cafeLongitude, completion: { (res) in
            self.nearByCafes = res
        }) { (err) in
            self.nearByCafes = []
            print("주변 카페 실패 \(err)")
        }
    }
    
    private func setScrapButtonImage() {
        guard let cafe = cafeInfo else { return }
        
        switch cafe.cafeScrabIs {
        case true:
            self.scrapButton.setImage(#imageLiteral(resourceName: "detailviewScrapRed"), for: .normal)
        case false:
            self.scrapButton.setImage(#imageLiteral(resourceName: "detailviewScrap"), for: .normal)
        default:
            return
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
        
        switch cafe.cafeScrabIs {
        case true:
            CafeScrapService.shareInstance.deleteCafeScrap(cafeId: cafeId, token: token, completion: { (message) in
                self.initInfoData()
            }) { (err) in
                print("스크랩 취소 실패")
            }
        case false:
            CafeScrapService.shareInstance.postCafeScrap(cafeId: cafeId, token: token, completion: { (message) in
                self.initInfoData()
            }) { (err) in
                print("스크랩 실패")
            }
        default:
            return
        }
        
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
        cafeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .top, animated: true)
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
        return 4
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
        guard let info = cafeInfo, let images = cafeImages, let reviews = cafeReviews, let nearCafes = nearByCafes , let cafeSignitures = cafeSignitures else { return cell }
        
        switch indexPath.section {
        case 0:
            if let imageCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailImageListCell") as? CafeDetailImageListCell {
                imageCell.images = images
                cell = imageCell
            }
        case 1:
            if let infoCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailInfoCell") as? CafeDetailInfoCell {
                if reviews.count == 0 {
                    infoCell.reviewLookButton.isHidden = true
                } else {
                    infoCell.reviewLookButton.addTarget(self, action: #selector(reviewLookActin(_:)), for: .touchUpInside)
                }
                infoCell.nameLabel.text = info.cafeName
                infoCell.addressLabel.text = info.addressDistrictName
                infoCell.detailAddressLabel.text = info.cafeAddressDetail
                infoCell.dayLabel.text = info.cafeDays
                infoCell.timeLabel.text = info.cafeTimes
                infoCell.phoneNumLabel.text = info.cafePhone
                infoCell.etcFlag = [info.cafeOptionParking, info.cafeOptionWifi, info.cafeOptionSmokingarea, info.cafeOptionAllnight, info.cafeOptionReservation]
                infoCell.signitureMenus = cafeSignitures
                
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
                    reviewCell.delegate = self
                    reviewCell.review = reviews[indexPath.row-1]
                    cell = reviewCell
                }
            }
        case 3:
            if let cafeCell = cafeDetailTableView.dequeueReusableCell(withIdentifier: "CafeDetailNearCafeCell") as? CafeDetailNearCafeCell {
                cafeCell.delegate = self
                cafeCell.nearByCafes = nearCafes
                cell = cafeCell
            }
        default:
            return cell
        }
        return cell
        
    }
}

extension LocationCafeDetailVC: ListViewCellDelegate {
    func goToViewController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "게시글 신고", style: .default, handler: { result in
            //doSomething
        }))
        actionSheet.addAction(UIAlertAction(title: "사용자 신고", style: .default, handler: { result in
            //doSomething
        }))
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
}
