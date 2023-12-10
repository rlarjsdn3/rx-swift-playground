//
//  DelegateProxyViewController.swift
//  HelloRxSwift
//
//  Created by 김건우 on 11/21/23.
//

import UIKit
import CoreLocation
import MapKit
import RxSwift
import RxCocoa

class DelegateProxyViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let disposeBag: DisposeBag = DisposeBag()
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        locationManager.rx.didUpdateLocations
            .map { $0[0] }
            .bind(to: mapView.rx.center)
            .disposed(by: disposeBag)
    }

}

extension Reactive where Base: MKMapView {
    var center: Binder<CLLocation> {
        return Binder(base.self) { mapView, location in
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 10_000,
                longitudinalMeters: 10_000
            )
            self.base.setRegion(region, animated: true)
        }
    }
}

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
    static func registerKnownImplementations() {
        self.register {
            RxCLLocationManagerDelegateProxy(parentObject: $0, delegateProxy: self)
        }
    }
}


extension Reactive where Base: CLLocationManager {
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: self.base)
    }
    
    var didUpdateLocations: Observable<[CLLocation]> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map { $0[1] as! [CLLocation] }
    }
}
