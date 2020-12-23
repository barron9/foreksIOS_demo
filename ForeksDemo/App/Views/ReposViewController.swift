import UIKit

class ReposViewController: UIViewController {
    private let viewModel: ReposViewModel
    
    private let tableView = UITableView()
    
    //  private let searchController = UISearchController(searchResultsController: nil)
    
    private var data: [SettingsModel]?
    private var tickersdata: [TickerModel]?
    private var preTickersdata: [[TickerModel]] 
    
    init(viewModel: ReposViewModel) {
        self.viewModel = viewModel
        self.preTickersdata=[]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        definesPresentationContext = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 56
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(TickerCellA.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.ready()
    }
    
    private func setupViewModel() {
        viewModel.isRefreshing = { loading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
        viewModel.didUpdateRepos = { [weak self] repos in
            guard let strongSelf = self else { return }
            print("didUpdateRepos",repos.count)
            strongSelf.data = repos
            strongSelf.tableView.reloadData()
        }
        viewModel.didUpdateTickers={ [weak self] tickers in
            guard let strongSelf = self else { return }
            print("didupdatetickers",tickers.count)
            strongSelf.tickersdata = tickers
            strongSelf.preTickersdata.append(tickers)
            print(strongSelf.preTickersdata.count)
            strongSelf.tableView.reloadData()
            if(strongSelf.preTickersdata.count>5){strongSelf.preTickersdata = []}
        }
        viewModel.didSelecteRepo = { [weak self] id in
            guard let strongSelf = self else { return }
            let alertController = UIAlertController(title: "\(id)", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            strongSelf.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ReposViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickersdata?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = tickersdata else { return TickerCellA() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TickerCellA;
        cell.tickerName.text = data[indexPath.row].tke
        cell.tickerPrice.text = data[indexPath.row].las
        cell.tickerTime.text = data[indexPath.row].clo
        let rcng = Float((data[indexPath.row].pdd).replacingOccurrences(of: ",", with: ".")) ?? 0
        if( self.preTickersdata.count > 1){
            
            
            let lastcng = Float( // bir önceki
                (self.preTickersdata[(self.preTickersdata.count )-2][indexPath.row].pdd).replacingOccurrences(of: ",", with: ".")
            ) ?? 0
            print(lastcng)
            if(lastcng-rcng < 0){ // if lastchagne > recentchange =goup
                cell.sym.text = "▲"
                cell.sym.textColor = UIColor.green
            }
            else if (lastcng-rcng > 0) {
                cell.sym.text = "▼"
                cell.sym.textColor = UIColor.red
            }
            else{
                cell.sym.text = ""
            }
        }
        if(rcng < 0){
            cell.tickerChg.textColor = UIColor.red
        }else if(rcng > 0){
            cell.tickerChg.textColor = UIColor.green
        }
        cell.tickerChg.text = "%"+data[indexPath.row].pdd
        return cell
        
    }
}

extension ReposViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelecteRepo!(indexPath.item)
    }
}

extension ReposViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //  viewModel.didChangeQuery(searchController.searchBar.text ?? "")
    }
}
