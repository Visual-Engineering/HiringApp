//
//  WalkthroughPageThree.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit

class WalkthroughPageThreeViewController: UIViewController {
    
    var presenter: WalkthroughPresenter?
    
    enum Constants {
        static let blueBackground : UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
    }
    
    let labelTop : UILabel = {
        let label = UILabel()
        label.text = "¿Dónde estamos?"
        label.font = UIFont(name: "Arial", size: 20.0)
        label.numberOfLines = 1
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let imageMapView : UIImageView = {
        let image = UIImage(named: "map-screenshot")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let labelBottom : UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        label.font = UIFont(name: "Arial", size: 14.0)
        label.numberOfLines = 3
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    //MARK: - Private API
    private func layout() {
        view.backgroundColor = Constants.blueBackground
        
        stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: view.frame.height * 0.2).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -view.frame.height * 0.2).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnMap))
        imageMapView.addGestureRecognizer(tapGesture)
        imageMapView.isUserInteractionEnabled = true
        
        view.addSubviewWithAutolayout(stackView)
        
        stackView.addArrangedSubview(labelTop)
        stackView.addArrangedSubview(imageMapView)
        stackView.addArrangedSubview(labelBottom)
    }
}

extension WalkthroughPageThreeViewController {
    convenience init(presenter: WalkthroughPresenter) {
        self.init()
        
        self.presenter = presenter
    }
    
    func didTapOnMap() {
        presenter?.showModalMap()
    }
}
