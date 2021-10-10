//
//  TrustWalletFlutterMethodChannelHandler.swift
//  Runner
//
//  Created by Johnny Cheung on 2021/7/1.
//

import WalletCore



class TrustWalletFlutterMethodChannelHandler {

    private static var _instance = TrustWalletFlutterMethodChannelHandler()

    private init() { }

    class func getInstance() -> TrustWalletFlutterMethodChannelHandler {
        return _instance
    }
    
    func handle(dict: Any?) -> TrustWalletResult {
        if let _dict = dict as? [String:Any] {
            if let _type = _dict["type"] as? String,
               let coinType = _dict["coinType"] as? UInt32,
               let passphrase = _dict["passphrase"] as? String {
                if _type == "create" {
                    return createWith(coinType: coinType, passphrase: passphrase)
                } else if _type == "import_from_mnemonic" {
                    if let mnemonic = _dict["mnemonic"] as? String {
                        return importWith(coinType: coinType, mnemonic: mnemonic, passphrase: passphrase)
                    }
                } else if _type == "get_private_key" {
                    if let mnemonic = _dict["mnemonic"] as? String {
                        return getPrivateKey(coinType: coinType, mnemonic: mnemonic, passphrase: passphrase)
                    }
                }
            }
        }
        return TrustWalletResult(isSuccess: false)
    }

    func createWith(coinType: UInt32, passphrase: String) -> TrustWalletResult {
        if let _coinType = CoinType(rawValue: coinType) {
            let wallet = getWallet(passphrase: passphrase)
            let address = wallet.getAddressForCoin(coin: _coinType)
            return TrustWalletResult(isSuccess: true, address: address, mnemonic: wallet.mnemonic)
        }
        return TrustWalletResult(isSuccess: false)
    }

    func importWith(coinType: UInt32, mnemonic: String, passphrase: String) -> TrustWalletResult {
        if !(HDWallet.isValid(mnemonic: mnemonic)) {
            return TrustWalletResult(isSuccess: false)
        }
        if let _coinType = CoinType(rawValue: coinType) {
            let wallet = getWallet(passphrase: passphrase, mnemonic: mnemonic)
            let address = wallet.getAddressForCoin(coin: _coinType)
            return TrustWalletResult(isSuccess: true, address: address, mnemonic: wallet.mnemonic)
        }
        return TrustWalletResult(isSuccess: false)
    }

    func importWith(coinType: UInt32, data: Data, passphrase: String) -> TrustWalletResult {
        if let _coinType = CoinType(rawValue: coinType) {
            let wallet = getWallet(passphrase: passphrase, data: data)
            let address = wallet.getAddressForCoin(coin: _coinType)
            return TrustWalletResult(isSuccess: true, address: address, mnemonic: wallet.mnemonic)
        }
        return TrustWalletResult(isSuccess: false)
    }
    
    func getPrivateKey(coinType: UInt32, mnemonic: String, passphrase: String) -> TrustWalletResult {
        if let _coinType = CoinType(rawValue: coinType) {
            let wallet = getWallet(passphrase: passphrase, mnemonic: mnemonic)
            let address = wallet.getAddressForCoin(coin: _coinType)
            let privateKeyObj = wallet.getKeyForCoin(coin: _coinType)
            // let priketyKeyStr = privateKeyObj.data.base64EncodedString(options: Data.Base64EncodingOptions()) 不好使
            let priketyKeyStr = privateKeyObj.data.hexEncodedString(options: .upperCase)
            return TrustWalletResult(isSuccess: true, address: address, mnemonic: wallet.mnemonic, privateKey: priketyKeyStr)
        }
        return TrustWalletResult(isSuccess: false)
    }
    
    private func getWallet(passphrase: String, mnemonic: String? = nil, data: Data? = nil) -> HDWallet {
        var wallet = HDWallet(strength: 128, passphrase: passphrase)
        if let _mnemonic = mnemonic, _mnemonic.count > 0 {
            wallet = HDWallet(mnemonic: _mnemonic, passphrase: passphrase)
        } else if let _data = data, _data.count > 0 {
            wallet = HDWallet(data: _data, passphrase: passphrase)
        }
        return wallet;
    }

}


class TrustWalletResult {
    var isSuccess: Bool
    var address: String?
    var mnemonic: String?
    var privateKey: String?
    
    init(isSuccess: Bool, address: String? = nil, mnemonic: String? = nil, privateKey: String? = nil) {
        self.isSuccess = isSuccess
        self.address = address
        self.mnemonic = mnemonic
        self.privateKey = privateKey
    }
    
    func toDict() -> [String:Any] {
        return [
            "isSuccess" : isSuccess,
            "address" : address ?? "",
            "mnemonic" : mnemonic ?? "",
            "privateKey" : privateKey ?? ""
        ]
    }
}
