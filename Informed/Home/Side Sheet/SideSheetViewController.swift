//
//  SideSheetViewController.swift
//  Informed
//
//  Created by Ethan Pippin on 11/17/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class SideSheetHolderNavigationController: UINavigationController {
    
    private lazy var animator = SlideInAnimator()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [SideSheetViewController()]
        transitioningDelegate = animator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class SideSheetViewController: BasicViewController {
    
    private lazy var backgroundTapOutView: UIView = makeBackgroundTapOutView()
    private lazy var sideSheet: UIView = makeSideSheet()
    private lazy var colorBlock: UIView = makeColorBlock()
    private lazy var titleLabel: UILabel = makeTitleLabel()
    private lazy var optionTableView: UITableView = makeOptionTableView()
    private let optionTableViewHandler = OptionTableViewHandler()
    private lazy var drawerView: SideSheetDrawerView = makeDrawerView()
    
    
    override func setupSubviews() {
        view.addSubview(backgroundTapOutView)
        view.addSubview(sideSheet)
        view.addSubview(colorBlock)
        view.addSubview(titleLabel)
        view.addSubview(optionTableView)
        view.addSubview(drawerView)
    }
    
    override func setupLayoutConstraints() {
        backgroundTapOutView.activateMatchingBoundsConstraintsFor(relatedView: view)
        NSLayoutConstraint.activate([
            sideSheet.topAnchor ⩵ view.topAnchor,
            sideSheet.bottomAnchor ⩵ view.bottomAnchor,
            sideSheet.widthAnchor ⩵ view.widthAnchor × 0.58,
            sideSheet.leftAnchor ⩵ view.leftAnchor
            ])
        NSLayoutConstraint.activate([
            colorBlock.topAnchor ⩵ view.topAnchor,
            colorBlock.leftAnchor ⩵ view.leftAnchor,
            colorBlock.rightAnchor ⩵ sideSheet.rightAnchor,
            colorBlock.heightAnchor ⩵ 167
            ])
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor ⩵ colorBlock.centerXAnchor,
            titleLabel.centerYAnchor ⩵ colorBlock.centerYAnchor + 10
            ])
        NSLayoutConstraint.activate([
            optionTableView.leftAnchor ⩵ view.leftAnchor,
            optionTableView.rightAnchor ⩵ sideSheet.rightAnchor,
            optionTableView.topAnchor ⩵ view.topAnchor + 180,
            optionTableView.bottomAnchor ⩵ view.centerYAnchor
            ])
        NSLayoutConstraint.activate([
            drawerView.bottomAnchor ⩵ view.bottomAnchor,
            drawerView.leftAnchor ⩵ view.leftAnchor,
            drawerView.rightAnchor ⩵ sideSheet.rightAnchor,
            drawerView.topAnchor ⩵ view.centerYAnchor
            ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.makeBarTransparent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideNavBehavior = HideNavigationBarBehavior(animated: true)
        addBehaviors(behaviors: [hideNavBehavior])
        
        navigationController?.navigationBar.tintColor = .white
        
        UserState.core.addSubscriber(subscriber: self, update: SideSheetViewController.update)
    }
    
    private func makeBackgroundTapOutView() -> UIView {
        let backgroundTapOutView = UIView.forAutoLayout()
        let tapOutRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOut))
        backgroundTapOutView.addGestureRecognizer(tapOutRecognizer)
        return backgroundTapOutView
    }
    
    @objc private func tapOut() {
        dismiss(animated: true, completion: nil)
    }
    
    private func makeSideSheet() -> UIView {
        let sideSheet = UIView.forAutoLayout()
        sideSheet.setBackgroundColor(.white)
        return sideSheet
    }
    
    private func makeColorBlock() -> UIView {
        let colorBlock = UIView.forAutoLayout()
        colorBlock.setBackgroundColor(Color.Informed.Primary.primary)
        return colorBlock
    }
    
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel.forAutoLayout()
        titleLabel.font = UIFont(name: "AppleMyungjo", size: 36)
        titleLabel.setText("Informed")
        titleLabel.setTextColor(.white)
        return titleLabel
    }
    
    private func makeOptionTableView() -> UITableView {
        let optionTableView = UITableView.forAutoLayout()
        optionTableView.delegate = self
        optionTableView.dataSource = self
        optionTableView.isScrollEnabled = false
        optionTableView.separatorStyle = .none
        
        OptionTableViewHandler.configure(optionTableView)
        optionTableViewHandler.buildRows()
        
        return optionTableView
    }
    
    private func makeDrawerView() -> SideSheetDrawerView {
        let drawerView = SideSheetDrawerView.forAutoLayout()
        return drawerView
    }
}

extension SideSheetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OptionRow.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionTableViewHandler.rows.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = optionTableViewHandler.rows[indexPath.row]
        let vc = row.presenting()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return optionTableViewHandler.cell(for: indexPath, in: tableView)
    }
}

extension SideSheetViewController: Subscriber {
    func update(with state: UserState) {
        if let user = state.user {
            drawerView.configure(with: "Logout", subtitle: user.email, titleColor: .red, delegate: self)
        } else {
            drawerView.configure(with: "Sign in", subtitle: "", titleColor: UIColor(hex: 0x4A90E2)!, delegate: self)
        }
    }
}

extension SideSheetViewController: SignInDelegate {
    func handleUserState() {
        if let _ = UserState.core.state.user {
            handleLogout()
        } else {
            let vc = LoginViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func handleLogout() {
        let alertController = UIAlertController(title: "Slow down there buckaroo", message: "Are you sure that you would like to logout?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive, handler: logout(_:))
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func logout(_ alertAction: UIAlertAction) {
        UserState.core.fire(.loggedOut)
        dismiss(animated: true, completion: nil)
    }
}
