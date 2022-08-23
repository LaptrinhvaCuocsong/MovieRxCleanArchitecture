//
//  ProfileVC.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 19/06/2022.
//

import RxCocoa
import RxSwift
import UIKit

class ProfileVC: BaseVC {
    private var viewModel: ProfileVM
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameBackgroudInput: UIView!
    @IBOutlet var inputNameTextField: UITextField!
    @IBOutlet var emailBackground: UIView!
    @IBOutlet var birthDayButton: UIButton!
    @IBOutlet var inputEmailTextField: UITextField!
    @IBOutlet var checkedMaleButton: UIButton!
    @IBOutlet var checkedMaleBackgroudView: UIView!
    @IBOutlet var checkedFemaleButton: UIButton!
    @IBOutlet var checkedFemaleBackgroudView: UIView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var saveEditButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var showAllButton: UIButton!
    @IBOutlet var pickerView: UIView!
    @IBOutlet var datePickerView: UIDatePicker!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    private var disposeBag = DisposeBag()
    private var profileData = PublishSubject<ProfileDataSource>()
    private var isEdited = true
    private var isShowAll = false
    private var sexIsMale = true

    init(viewModel: ProfileVM) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        saveEditButton.rx.tap.subscribe { [unowned self] _ in
            profileData.onNext(
                DefaultProfileDataSource(sex: sexIsMale,
                                         history: viewModel.dataSource.history,
                                         name: inputNameTextField.text ?? viewModel.dataSource.name,
                                         email: inputEmailTextField.text ?? viewModel.dataSource.email,
                                         birth: datePickerView.date)
            )
            self.edited()
        }
        .disposed(by: disposeBag)

        checkedMaleButton.rx.tap.subscribe { [unowned self] _ in
            sexIsMale = true
            self.reloadSexView()
        }
        .disposed(by: disposeBag)
        checkedFemaleButton.rx.tap.subscribe { [unowned self] _ in
            sexIsMale = false
            self.reloadSexView()
        }
        .disposed(by: disposeBag)

        birthDayButton.rx.tap.subscribe { [unowned self] _ in
            self.pickerView.isHidden = false
        }
        .disposed(by: disposeBag)

        saveButton.rx.tap.subscribe { [unowned self] _ in
            self.reloadBirth()
            self.pickerView.isHidden = true
        }
        .disposed(by: disposeBag)

        cancelButton.rx.tap.subscribe { [unowned self] _ in
            self.pickerView.isHidden = true
        }
        .disposed(by: disposeBag)
        let output = viewModel
            .transform(
                input: ProfileInput(data: profileData.asDriverOnErrorJustComplete(),
                                    stateEdidtedTrigger: editButton
                                        .rx
                                        .tap
                                        .map({ _ in
                                            !self.isEdited
                                        }
                                        )
                                        .asDriverOnErrorJustComplete(),
                                    stateShowAllHistoryTrigger: showAllButton
                                        .rx
                                        .tap
                                        .map({ _ in
                                            !self.isShowAll
                                        })
                                        .asDriverOnErrorJustComplete()
                )
            )

        output.stateEdidted.drive { state in
            if state {
                self.edited()
            } else {
                self.onEditing()
            }
        }
        .disposed(by: disposeBag)

        output.stateShowAllHistory.drive { _ in
            print("Load more")
        }
        .disposed(by: disposeBag)
    }

    private func resetUI() {
        inputEmailTextField.text = viewModel.dataSource.name
        inputNameTextField.text = viewModel.dataSource.email
    }

    override func binding() {
    }

    private func onEditing() {
        isEdited = false
        nameBackgroudInput.layer.borderWidth = 1
        nameBackgroudInput.layer.cornerRadius = nameBackgroudInput.bounds.height / 4
        inputNameTextField.isEnabled = true
        inputEmailTextField.isEnabled = true
        emailBackground.layer.borderWidth = 1
        emailBackground.layer.cornerRadius = nameBackgroudInput.bounds.height / 4
        birthDayButton.isEnabled = true
        reloadSexView()
        checkedMaleBackgroudView.isHidden = false
        checkedFemaleBackgroudView.isHidden = false
        editButton.setTitle("Cacel", for: .normal)
        saveEditButton.isHidden = false
        datePickerView.date = viewModel.dataSource.birth
        tableView.isHidden = true
        showAllButton.isHidden = true
    }

    private func edited() {
        isEdited = true
        inputNameTextField.text = viewModel.dataSource.name
        inputEmailTextField.text = viewModel.dataSource.email

        nameBackgroudInput.layer.borderWidth = 0
        nameBackgroudInput.layer.cornerRadius = 0
        inputNameTextField.backgroundColor = .clear
        inputNameTextField.isEnabled = false

        birthDayButton.isEnabled = false
        reloadBirth()

        inputEmailTextField.isEnabled = false
        emailBackground.layer.borderWidth = 0
        emailBackground.layer.cornerRadius = 0
        reloadSexView()
        checkedMaleBackgroudView.isHidden = viewModel.dataSource.sex == false
        checkedFemaleBackgroudView.isHidden = viewModel.dataSource.sex == true
        editButton.setTitle("Edit", for: .normal)
        saveEditButton.isHidden = true
        datePickerView.date = viewModel.dataSource.birth
        tableView.isHidden = false
        showAllButton.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func reloadBirth() {
        let dateFormarter = DateFormatter()
        dateFormarter.dateFormat = "MM/dd/YYYY"
        birthDayButton.setTitle(dateFormarter.string(from: datePickerView.date), for: .normal)
    }

    private func reloadSexView() {
        checkedMaleButton.setImage(UIImage(named: sexIsMale == true ? "ic_tabbar_setting_unselected" : "ic_tabbar_setting_selected"), for: .normal)
        checkedFemaleButton.setImage(UIImage(named: sexIsMale == true ? "ic_tabbar_setting_selected" : "ic_tabbar_setting_unselected"), for: .normal)
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.history.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
