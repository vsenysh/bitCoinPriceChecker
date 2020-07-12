
import Foundation

protocol CoinManagerDelegate {
    func getCoinData(price: CoinModel)
}

struct CoinManager{
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8E9DD7E7-66B2-4DDC-AE99-75529AFF24EE"
    
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR","UAH"]
    
    
    func getCoinPrice(for currency: String){
        let urlString = ("\(baseURL)/\(currency)?apikey=\(apiKey)")
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    print("error")
                    return
                }
                if let safeData = data{
                    if let bitCoin = self.parseJSON(safeData){
                        self.delegate?.getCoinData(price: bitCoin)
                       
                    }
                }
            }
            task.resume()
            
        }
    }
    func parseJSON(_ data: Data) -> CoinModel?{
        
        do{
            let decodedData = try JSONDecoder().decode(CoinData.self, from: data)
            let price = decodedData.rate
            let name = decodedData.asset_id_quote
            let bitCoin = CoinModel(name: name, price: price)
            return bitCoin
        }catch{
            print("fuckedup")
            return nil
        }
    }
}

