//
//  TopicsPresenter.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 12/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation

class TopicsPresenter {

    //MARK: - Stored properties
    fileprivate let router: TopicsRouterProtocol
    fileprivate let interactor: TopicsInteractorProtocol
    fileprivate unowned let view: TopicsUserInterfaceProtocol
    var idTechnologySelected = Int()

    var state: LoadingState<TopicsViewModel> = .loading

    var viewModel: TopicsViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                state = .error(AppError.unknown)
                return
            }

            state = .loaded(viewModel: viewModel)
        }
    }

    //MARK: - Initializer
    init(router: TopicsRouterProtocol, interactor: TopicsInteractorProtocol, view: TopicsUserInterfaceProtocol) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}

extension TopicsPresenter: TopicsPresenterProtocol {

    func viewDidLoad() {
        _ = interactor.retrieveAPITopics(technologyId: idTechnologySelected).upon(.main) { result in
            switch result {
            case .failure(let error):
                self.state = .error(error)
            case .success(let topics):
                var arrayTopicViewModels = [TopicViewModel]()
                for topicModel in topics {
                    let topicViewModel = topicModel.toViewModel()
                    arrayTopicViewModels.append(topicViewModel)
                }
                let topicsViewModel = TopicsViewModel(topics: arrayTopicViewModels)
                self.view.configureFor(viewModel: topicsViewModel)
            }
        }
    }
    
    func didClickOnTopic(index: Int) {
        guard let topic = viewModel?.topics[index] else { return }
        router.navigateToNextScene(selectedTopic: topic)
    }
}
