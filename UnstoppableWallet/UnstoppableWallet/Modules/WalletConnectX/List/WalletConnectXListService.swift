import RxSwift
import RxRelay
import RxCocoa

class WalletConnectXListService {
    private var disposeBag = DisposeBag()
    private let uriHandler: WalletConnectUriHandler

    private let createModuleRelay = PublishRelay<IWalletConnectXMainService>()
    private let connectionErrorRelay = PublishRelay<Error>()

    private let sessionManager: WalletConnectSessionManager
    private var sessionKiller: WalletConnectSessionKiller?
    private let showSessionV1Relay = PublishRelay<WalletConnectSession>()
    private let sessionKillingRelay = PublishRelay<SessionKillingState>()

    init(uriHandler: WalletConnectUriHandler, sessionManager: WalletConnectSessionManager) {
        self.uriHandler = uriHandler
        self.sessionManager = sessionManager
    }

    private func onUpdateSessionKiller(state: WalletConnectSessionKiller.State) {
        switch state {
        case .killed: finishSessionKill()
        case .failed: finishSessionKill(successful: false)
        default: ()
        }
    }

    private func finishSessionKill(successful: Bool = true) {
        if let killer = sessionKiller {
            sessionManager.deleteSession(peerId: killer.peerId)
        }

        sessionKiller = nil             //deinit session killer and clean disposeBag
        disposeBag = DisposeBag()

        sessionKillingRelay.accept(successful ? .completed : .removedOnly)
    }

    private func items(sessions: [WalletConnectSession]) -> [Item] {
        sessions.map {
            Item(
                id: $0.id,
                chains: [Chain(rawValue: $0.chainId)].flatMap { $0 },
                version: 1,
                appName: $0.peerMeta.name,
                appUrl: $0.peerMeta.url,
                appDescription: $0.peerMeta.description,
                appIcons: $0.peerMeta.icons
            )
        }
    }

}

extension WalletConnectXListService {

    var itemsV1: [Item] {
        items(sessions: sessionManager.sessions)
    }

    var itemsV2: [Item] {
        []
    }

    var sessionV1Count: Int {
        sessionManager.sessions.count
    }

    var sessionV2Count: Int {
        0
    }

    var itemsV1Observable: Observable<[Item]> {
        sessionManager.sessionsObservable.map { [weak self] in
            self?.items(sessions: $0) ?? []
        }
    }

    var itemsV2Observable: Observable<[Item]> {
        sessionManager.sessionsObservable.map { [weak self] in
            self?.items(sessions: $0) ?? []
        }
    }

    var showSessionV1Observable: Observable<WalletConnectSession> {
        showSessionV1Relay.asObservable()
    }

    var sessionKillingObservable: Observable<SessionKillingState> {
        sessionKillingRelay.asObservable()
    }

    func kill(id: Int) {
        if let session = sessionManager.sessions.first(where: { $0.id == id }) {
            sessionKillingRelay.accept(.processing)

            let sessionKiller = WalletConnectSessionKiller(session: session)
            let forceTimer = Observable.just(()).delay(.seconds(5), scheduler: ConcurrentDispatchQueueScheduler(qos: .userInitiated))

            subscribe(disposeBag, forceTimer) { [weak self] in
                self?.finishSessionKill(successful: false)
            }
            subscribe(disposeBag, sessionKiller.stateObservable) { [weak self] in
                self?.onUpdateSessionKiller(state: $0)
            }

            sessionKiller.kill()
            self.sessionKiller = sessionKiller
        }
    }

    var createModuleObservable: Observable<IWalletConnectXMainService> {
        createModuleRelay.asObservable()
    }

    var connectionErrorObservable: Observable<Error> {
        connectionErrorRelay.asObservable()
    }

    func connect(uri: String) {
        let result = uriHandler.connect(uri: uri)

        switch result {
        case .success(let service): createModuleRelay.accept(service)
        case .failure(let error): connectionErrorRelay.accept(error)
        }
    }

    func showSession(id: Int) {
        if let sessionV1 = sessionManager.sessions.first(where: { $0.id == id }) {
            showSessionV1Relay.accept(sessionV1)
        }
    }

}

extension WalletConnectXListService {

    enum SessionKillingState {
        case processing
        case completed
        case removedOnly
    }

    enum Chain: Int, CaseIterable {
        case ethereum = 1
        case binanceSmartChain = 56
        case ropsten = 3
        case rinkeby = 4
        case kovan = 42
        case goerli = 5
    }

    struct Item {
        let id: Int
        let chains: [Chain]
        let version: Int

        let appName: String
        let appUrl: String
        let appDescription: String
        let appIcons: [String]
    }

}

extension WalletConnectSession: Hashable {

    public var id: Int {
        hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(accountId)
        hasher.combine(peerId)
    }

    public static func ==(lhs: WalletConnectSession, rhs: WalletConnectSession) -> Bool {
        lhs.accountId == rhs.accountId && lhs.peerId == rhs.peerId
    }

}