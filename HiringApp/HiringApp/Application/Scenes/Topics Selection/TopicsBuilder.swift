//
//  TopicsBuilder.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
import HiringAppCore
import Deferred

protocol TopicsPresenterProtocol {
    func viewDidLoad()
    func didClickOnTopic(index: Int)
}

protocol TopicsInteractorProtocol {
    func retrieveAPITopics(technologyId: Int) -> Task<[TopicModel]>
}

protocol TopicsUserInterfaceProtocol: class {
    func configureFor(viewModel: TopicsViewModel)
}

protocol TopicsRouterProtocol {
    func navigateToNextScene(selectedTopic: TopicViewModel)
}

class TopicsBuilder {

    //MARK: - Configuration
    static func build(idTechnology: Int) -> TopicsViewController {
        let viewController = TopicsViewController()
        let router = TopicsRouter(view: viewController)
        let interactor = TopicsInteractor(repository: TopicsRepository())
        let presenter = TopicsPresenter(router: router,
                                        interactor: interactor,
                                        view: viewController,
                                        idTechnology: idTechnology)
        
        viewController.presenter = presenter

        return viewController
    }
}
