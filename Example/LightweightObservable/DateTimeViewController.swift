//
//  DateTimeViewController.swift
//  LightweightObservable_Example
//
//  Created by Felix Mau on 04/27/19.
//  Copyright © 2019 Felix Mau. All rights reserved.
//

import UIKit
import LightweightObservable

class DateTimeViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!

    // MARK: - Private properties

    /// The view model calculating the current date and time.
    private let dateTimeViewModel = DateTimeViewModel()

    /// The dispose bag for this view controller. On it's deallocation, it removes the
    /// subscribtion-closures from the corresponding observable-properties.
    private var disposeBag = DisposeBag()

    // MARK: - Public methods

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModelToView()
    }

    // MARK: - Private methods

    private func bindViewModelToView() {
        dateTimeViewModel.formattedDate.subscribeDistinct { [weak self] newFormattedDate, _ in
            self?.dateLabel.text = newFormattedDate
        }.disposed(by: &disposeBag)

        dateTimeViewModel.formattedTime.subscribe { [weak self] newFormattedTime, _ in
            self?.timeLabel.text = newFormattedTime
        }.disposed(by: &disposeBag)
    }
}
