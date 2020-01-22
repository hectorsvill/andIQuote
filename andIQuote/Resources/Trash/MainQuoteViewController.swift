////
////  MainQuoteViewController.swift
////  andIQuote
////
////  Created by Hector on 12/31/19.
////  Copyright © 2019 Hector. All rights reserved.
////
//
//import UIKit
//
//class MainQuoteViewController: UIViewController {
//    var delegate: HomeControllerViewDelegate?
//    var quoteController: QuoteController!
//    var menuButton: UIButton!
//    var shareButton: UIButton!
//    var themeButton: UIButton!
//    var ReviewButton: UIButton!
//    var likeButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavButtons()
//        setupLayouts()
//        setupGestureRecogniser()
//        setBackground(quoteController.background)
//    }
//  
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        setup3dTouch()
//    }
//    
//    // MARK: lowerStackView
//    var lowerStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .horizontal
//        stackView.spacing = 32
//        return stackView
//    }()
//    
//    // MARK: quoteTextView
//    var quoteTextView: UITextView  = {
//        let textView = UITextView()
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.backgroundColor = .clear
//        textView.textAlignment = .justified
//        textView.isEditable = false
//        textView.isSelectable = false
//        textView.isScrollEnabled = false
//        return textView
//    }()
//}
//
//extension MainQuoteViewController {
//    // MARK: Setup 3d Touch
//    func setup3dTouch() {
//        let icon = UIApplicationShortcutIcon(type: .share)
//        let item = UIApplicationShortcutItem(type: "com.hectorstevenvillasano.andIQuote.Quote", localizedTitle: "Share", localizedSubtitle: nil, icon: icon, userInfo: nil)
//        UIApplication.shared.shortcutItems = [item]
//        
//        
//    }
//    
//    // MARK: setupNavButtons
//    private func setupNavButtons() {
//        navigationController?.navigationBar.barTintColor = view.backgroundColor
//        navigationController?.navigationBar.barStyle = .default
//        
//        let menuImage = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage().mainViewSymbolConfig())
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(slideMenuButtonTapped))
//        navigationItem.leftBarButtonItem?.tintColor = .label
//        
//        let shareImage = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage().mainViewSymbolConfig())
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(shareButtonTapped))
//        navigationItem.rightBarButtonItem?.tintColor = .label
//    }
//    
//    // MARK: setupLayouts
//    private func setupLayouts() {
//        quoteController.fetchQuotes { error in
//            if let error = error {
//                NSLog("\(error)")
//            }
//            self.setup3dTouch()
//        }
//
//        view.addSubview(quoteTextView)
//        
//        themeButton = UIButton().sfImageButton(systemName: "paintbrush")
//        themeButton.addTarget(self, action: #selector(themeButtonTapped), for: .touchUpInside)
//        lowerStackView.addArrangedSubview(themeButton)
//        
////        ReviewButton = UIButton().sfImageButton(systemName: "text.bubble")
////        ReviewButton.addTarget(self, action: #selector(reviewButtonTapped), for: .touchUpInside)
////        lowerStackView.addArrangedSubview(ReviewButton)
//        
//        likeButton = UIButton().sfImageButton(systemName: "hand.thumbsup")
//        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
//        lowerStackView.addArrangedSubview(likeButton)
//        
//        view.addSubview(lowerStackView)
//        
//        NSLayoutConstraint.activate([
//            lowerStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
//            lowerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            quoteTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            quoteTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            quoteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
//            quoteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
//        ])
//    }
//}
//
//extension MainQuoteViewController {
//    
//    // MARK: Impact Gesture
//    func impactGesture(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
//        let impactFeedback = UIImpactFeedbackGenerator(style: style)
//        impactFeedback.impactOccurred()
//    }
//    
//    // MARK: menuButtonTapped
//    @objc func slideMenuButtonTapped() {
//        guard !quoteController.quoteThemeIsActive else { return }
//        impactGesture(style: .rigid)
//        delegate?.handleMenuToggle()
//    }
//    
//    // MARK: shareButtonTapped
//    @objc func shareButtonTapped() {
//        guard quoteController.quoteThemeIsActive != true else { return }
//        impactGesture(style: .rigid)
//        lowerStackView.isHidden = true
//        let activityVC = UIActivityViewController(activityItems: [quoteController.attributedString, view.screenShot()], applicationActivities: [])
//        present(activityVC, animated: true)
//        lowerStackView.isHidden = false
//    }
//    
//    // MARK: themeButtonTapped
//    @objc func themeButtonTapped() {
//        impactGesture(style: .medium)
//        quoteController.quoteThemeIsActive.toggle()
//        let buttonImageName = quoteController.quoteThemeIsActive ? "paintbrush.fill" : "paintbrush"
//        let configuration = UIImage().mainViewSymbolConfig()
//        let image = UIImage(systemName: buttonImageName, withConfiguration: configuration)
//        themeButton.setImage(image, for: .normal)
//        quoteController.saveBackgroundIndex()
//    }
//    
//    // MARK: ReviewButtonTapped
//    @objc func ReviewButtonTapped() {
//        impactGesture(style: .medium)
//        let layout = UICollectionViewFlowLayout()
//        let quoteReviewCollectionViewController = QuoteReviewCollectionViewController(collectionViewLayout: layout)
//        quoteReviewCollectionViewController.quoteController = quoteController
//        present(quoteReviewCollectionViewController, animated: true)
//    }
//    
//    // MARK: likeButtonTapped
//    @objc func likeButtonTapped() {
//        guard !quoteController.quoteThemeIsActive else { return }
//        impactGesture(style: .medium)
//        
//        let quoteID = quoteController.quote.id
//        var buttonImageName =  "hand.thumbsup"
//        guard var user = quoteController.quoteUser else { return }
//        
//        if user.favorites.contains(quoteID!) {
//            if let index = user.favorites.firstIndex(of: quoteID!) {
//                user.favorites.remove(at: index)
//            }
//        } else {
//            user.favorites.append(quoteID!)
//            buttonImageName =  "hand.thumbsup.fill"
//        }
//        
//        let configuration = UIImage().mainViewSymbolConfig()
//        let image = UIImage(systemName: buttonImageName, withConfiguration: configuration)
//        likeButton.setImage(image, for: .normal)
//        
//        quoteController.likeButtonpressed()
//    }
//}
