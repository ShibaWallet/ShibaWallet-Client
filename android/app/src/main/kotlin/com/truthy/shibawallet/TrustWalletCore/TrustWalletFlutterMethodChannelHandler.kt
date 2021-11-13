package com.truthy.shibawallet

import android.util.Base64.DEFAULT
import android.util.Base64.encodeToString
import wallet.core.jni.CoinType
import wallet.core.jni.HDWallet


class TrustWalletFlutterMethodChannelHandler private constructor() {

    companion object { 
        @JvmStatic 
        val getInstance by lazy(LazyThreadSafetyMode.SYNCHRONIZED) { TrustWalletFlutterMethodChannelHandler() }
    }

    fun handle(dict: Any?) : TrustWalletResult {
        try {
            val _dict = dict as? Map<String, Any>
            if (_dict != null) {
                val _type = _dict["type"] as? String
                if (_type == null) {
                    return TrustWalletResult(false, "", "", "")
                }
                val coinType = _dict["coinType"] as? Int
                if (coinType == null) {
                    return TrustWalletResult(false, "", "", "")
                }
                val passphrase = _dict["passphrase"] as? String
                if (passphrase == null) {
                    return TrustWalletResult(false, "", "", "")
                }
                if (_type == "create") {
                    return createWith(coinType, passphrase)
                } else if (_type == "import_from_mnemonic") {
                    val mnemonic = _dict["mnemonic"] as? String ?: ""
                    return importWith(coinType, mnemonic, passphrase)
                } else if (_type == "get_private_key") {
                    val mnemonic = _dict["mnemonic"] as? String ?: ""
                    return getPrivateKey(coinType, mnemonic, passphrase)
                }
            }
            return TrustWalletResult(false, "", "", "")
        } catch (e: Exception) {
            return TrustWalletResult(false, "", "", "")
        }
    }

    init {
        System.loadLibrary("TrustWalletCore")
    }

    fun createWith(coinType: Int, passphrase: String) : TrustWalletResult {
        val ctype = CoinType.createFromValue(coinType)
        val wallet = getWallet(passphrase)
        val address = wallet.getAddressForCoin(ctype)
        return TrustWalletResult(true, address, wallet.mnemonic(), "")
    }

    fun importWith(coinType: Int, mnemonic: String, passphrase: String) : TrustWalletResult {
        val ctype = CoinType.createFromValue(coinType)
        val wallet = getWallet(passphrase, mnemonic)
        val address = wallet.getAddressForCoin(ctype)
        return TrustWalletResult(true, address, wallet.mnemonic(), "")
    }

    fun importWith(coinType: Int, bytes: ByteArray, passphrase: String) : TrustWalletResult {
        val ctype = CoinType.createFromValue(coinType)
        val wallet = getWallet(passphrase, null, bytes)
        val address = wallet.getAddressForCoin(ctype)
        return TrustWalletResult(true, address, wallet.mnemonic(), "")
    }

    fun getPrivateKey(coinType: Int, mnemonic: String, passphrase: String) : TrustWalletResult {
        val ctype = CoinType.createFromValue(coinType)
        val wallet = getWallet(passphrase, mnemonic)
        val address = wallet.getAddressForCoin(ctype)
        val privateKeyObj = wallet.getKeyForCoin(ctype)
        val privateKeyBase64 = base64Encode(privateKeyObj.data())
        return TrustWalletResult(true, address, wallet.mnemonic(), privateKeyBase64)
    }

    private fun getWallet(passphrase: String, mnemonic: String? = null, bytes: ByteArray? = null) : HDWallet {
        var wallet: HDWallet
        if (mnemonic != null && mnemonic.length > 0) {
            wallet = HDWallet(mnemonic, passphrase)
        } else if (bytes != null) {
            wallet = HDWallet(bytes, passphrase)
        } else {
            wallet = HDWallet(128, passphrase)
        }
        return wallet
    }

    fun base64Encode(data: ByteArray) : String {
        return encodeToString(data, DEFAULT)
    }

}


class TrustWalletResult constructor(val isSuccess: Boolean, val address: String, val mnemonic: String, val privateKey: String) {

    fun toDict() : Map<String, Any> {
        return mapOf(
            "isSuccess" to isSuccess,
            "address" to address,
            "mnemonic" to mnemonic,
            "privateKey" to privateKey
        )
    }
}