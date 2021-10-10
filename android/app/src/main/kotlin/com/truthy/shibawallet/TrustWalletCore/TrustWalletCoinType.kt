//import wallet.core.jni.CoinType
//
///*
// * 钱包 公链 类型
// * */
//
//class TrustWalletCoinType {
//
//    private var _value: Int = 0
//
//    constructor(value: Int) {
//        this._value = value
//    }
//
//    fun getCoinType(): CoinType? {
//        return when (this._value) {
//            457 -> CoinType.AETERNITY
//            425 -> CoinType.AION
//            714 -> CoinType.BINANCE
//            0 -> CoinType.BITCOIN
//            145 -> CoinType.BITCOINCASH
//            282 -> CoinType.BRAVOCOIN
//            820 -> CoinType.CALLISTO
//            118 -> CoinType.COSMOS
//            5 -> CoinType.DASH
//            42 -> CoinType.DECRED
//            20 -> CoinType.DIGIBYTE
//            3 -> CoinType.DOGECOIN
//            194 -> CoinType.EOS
//            60 -> CoinType.ETHEREUM
//            61 -> CoinType.ETHEREUMCLASSIC
//            235 -> CoinType.FIO
//            6060 -> CoinType.GOCHAIN
//            17 -> CoinType.GROESTLCOIN
//            74 -> CoinType.ICON
//            304 -> CoinType.IOTEX
//            2017 -> CoinType.KIN
//            2 -> CoinType.LITECOIN
//            22 -> CoinType.MONACOIN
//            2718 -> CoinType.NEBULAS
//            8964 -> CoinType.NULS
//            165 -> CoinType.NANO
//            397 -> CoinType.NEAR
//            242 -> CoinType.NIMIQ
//            1024 -> CoinType.ONTOLOGY
//            178 -> CoinType.POANETWORK
//            2301 -> CoinType.QTUM
//            144 -> CoinType.XRP
//            501 -> CoinType.SOLANA
//            148 -> CoinType.STELLAR
//            396 -> CoinType.TON
//            1729 -> CoinType.TEZOS
//            500 -> CoinType.THETA
//            1001 -> CoinType.THUNDERTOKEN
//            889 -> CoinType.TOMOCHAIN
//            195 -> CoinType.TRON
//            818 -> CoinType.VECHAIN
//            14 -> CoinType.VIACOIN
//            5718350 -> CoinType.WANCHAIN
//            133 -> CoinType.ZCASH
//            136 -> CoinType.ZCOIN
//            313 -> CoinType.ZILLIQA
//            19167 -> CoinType.ZELCASH
//            175 -> CoinType.RAVENCOIN
//            5741564 -> CoinType.WAVES
//            330 -> CoinType.TERRA
//            1023 -> CoinType.HARMONY
//            283 -> CoinType.ALGORAND
//            434 -> CoinType.KUSAMA
//            354 -> CoinType.POLKADOT
//            else -> null
//        }
//    }
//
//}
