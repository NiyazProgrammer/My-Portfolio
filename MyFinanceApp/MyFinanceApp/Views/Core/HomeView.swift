import UIKit
import SnapKit

class HomeView: UIView {
    var addNewBankCard: (() -> Void)?
    var addNewTransaction: ((BankCard) -> Void)?

    private var bankCardCollectionHeightConstraint: Constraint?
    private var currencyCollectionHeightConstraint: Constraint?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()

    private lazy var amountMoneyCard: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background8"))
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var amountMoneyLabel: UILabel = {
        let label = UILabel()
        label.text = "Сумма:"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()

    lazy var userTotalMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()

    private lazy var accountsLabel: UILabel = {
        let label = UILabel()
        label.text = "Бюджет"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var newAccountsLabel: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.addNewBankCard?()
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.setTitle("Новый счет", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.purple, for: .normal)
        return button
    }()

    private lazy var coursesLabel: UILabel = {
        let label = UILabel()
        label.text = "Топ валют"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var accountsLabelSV: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [accountsLabel, newAccountsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    var bankCards: [BankCard] = [] {
           didSet {
               updateCollectionViewHeight()
               bankCardCollection.reloadData()
           }
       }

    var currencies: [Valute] = [] {
        didSet {
            updateCollectionViewHeight()
            currencyCollection.reloadData()
        }
    }

    let bankCardCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BankCardViewCollectionViewCell.self, forCellWithReuseIdentifier: BankCardViewCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    let currencyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CurrencyCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    lazy var avatarImage: UIImageView = {
        let image = UIImage(named: "avatar1")
        let userAvatar = UIImageView(image: image)
        userAvatar.contentMode = .scaleAspectFill
        return userAvatar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(amountMoneyCard)
        contentView.addSubview(amountMoneyLabel)
        contentView.addSubview(userTotalMoneyLabel)
        contentView.addSubview(accountsLabelSV)
        contentView.addSubview(bankCardCollection)
        contentView.addSubview(coursesLabel)
        contentView.addSubview(currencyCollection)
        setupLayout()

        bankCardCollection.dataSource = self
        bankCardCollection.delegate = self
        currencyCollection.dataSource = self
        currencyCollection.delegate = self

        amountMoneyCard.layer.cornerRadius = 20
        amountMoneyCard.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(user: User) {
        if let avatarImageUrl = user.avatarImageUrl, let url = URL(string: avatarImageUrl) {
            avatarImage.kf.setImage(with: url)
        } else {
            avatarImage.image = UIImage(named: "defaultAvatar")
        }
    }


    func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.width.equalTo(UIScreen.main.bounds.width)
        }

        amountMoneyCard.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.height.equalTo(80)
        }

        amountMoneyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(amountMoneyCard.snp.centerY)
            make.leading.equalTo(amountMoneyCard.snp.leading).offset(15)
        }

        userTotalMoneyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(amountMoneyCard.snp.centerY)
            make.trailing.equalTo(amountMoneyCard.snp.trailing).offset(-15)
        }

        accountsLabelSV.snp.makeConstraints { make in
            make.top.equalTo(amountMoneyCard.snp.bottom).offset(20)
            make.leading.equalTo(amountMoneyCard.snp.leading)
            make.trailing.equalTo(amountMoneyCard.snp.trailing)
        }

        bankCardCollection.snp.makeConstraints { make in
            make.top.equalTo(accountsLabelSV.snp.bottom).offset(20)
            make.leading.equalTo(accountsLabelSV.snp.leading)
            make.trailing.equalTo(accountsLabelSV.snp.trailing)
            bankCardCollectionHeightConstraint = make.height.equalTo(0).constraint
        }

        coursesLabel.snp.makeConstraints { make in
            make.top.equalTo(bankCardCollection.snp.bottom).offset(20)
            make.leading.equalTo(bankCardCollection.snp.leading)
            make.trailing.equalTo(bankCardCollection.snp.trailing)
        }

        currencyCollection.snp.makeConstraints { make in
            make.top.equalTo(coursesLabel.snp.bottom).offset(20)
            make.leading.equalTo(coursesLabel.snp.leading)
            make.trailing.equalTo(coursesLabel.snp.trailing)
            currencyCollectionHeightConstraint = make.height.equalTo(0).constraint
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
        }

        avatarImage.snp.makeConstraints { make in
                    make.width.equalTo(40)
                    make.height.equalTo(40)
                }
        avatarImage.layer.cornerRadius = 20
        avatarImage.clipsToBounds = true
    }

    private func updateCollectionViewHeight() {
        let bankCardsHeight = CGFloat(bankCards.count) * 78.0
        bankCardCollectionHeightConstraint?.update(offset: bankCardsHeight)

        let currenciesHeight = CGFloat(currencies.count) * 78.0
        currencyCollectionHeightConstraint?.update(offset: currenciesHeight)
    }
}

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bankCardCollection {
            updateCollectionViewHeight()
            return bankCards.count
        } else {
            updateCollectionViewHeight()
            return Resources.NumbersItemCount.currencyCount
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bankCardCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BankCardViewCollectionViewCell.identifier, for: indexPath) as? BankCardViewCollectionViewCell
            let card = bankCards[indexPath.item]
            cell?.addNewTransaction = { [weak self] in
                self?.addNewTransaction?(card)
            }
            cell?.configure(with: card)

            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.identifier, for: indexPath) as? CurrencyCollectionViewCell
            let currency = currencies[indexPath.item]
            cell?.configure(coin: currency)
            return cell ?? UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 70)
    }
}
