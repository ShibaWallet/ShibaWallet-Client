

class TYNFTAssetItemModel {

  String? contractAddress;
  String? fromAddress;
  String? toAddress;
  int tokenId = 0;
  String? tokenName;
  String? tokenSymbol;
  int tokenDecimal = 0;
  String? nftUrl;
  String? nftName;
  String? nftDesc;

  String? blockHash;
  String? hash;
  String? blockNumber;
  String? nonce;
  String? timeStamp;
  int gas = 0;
  int gasPrice = 0;
  int gasUsed = 0;
  int cumulativeGasUsed = 0;
  String? input;
  int confirmations = 0;

  TYNFTAssetItemModel.fromJson(Map<String, dynamic> dict):
    contractAddress = dict["contract_address"] as String?,
    fromAddress = dict["from_address"] as String?,
    toAddress = dict["to_address"] as String?,
    tokenId = dict["token_id"] as int,
    tokenName = dict["token_name"] as String?,
    tokenSymbol = dict["token_symbol"] as String?,
    tokenDecimal = int.parse(dict["token_decimal"]),
    nftUrl = dict["nft_url"] as String?,
    nftName = dict["nft_name"] as String?,
    nftDesc = dict["nft_desc"] as String?,
    blockHash = dict["block_hash"] as String?,
    hash = dict["hash"] as String?,
    blockNumber = dict["block_number"] as String?,
    nonce = dict["nonce"] as String?,
    timeStamp = dict["time_stamp"] as String?,
    gas = int.parse(dict["gas"]),
    gasPrice = int.parse(dict["gas_price"]),
    gasUsed = int.parse(dict["gas_used"]),
    cumulativeGasUsed = int.parse(dict["cumulative_gas_used"]),
    input = dict["input"] as String?,
    confirmations = int.parse(dict["confirmations"])
    ;

}

// [
//   {
//     'contract_address': '0x5bc94e9347f3b9be8415bdfd24af16666704e44f',
//     'from_address': '0x0000000000000000000000000000000000000000',
//     'to_address': '0x6b112cc0402ea3963e432ab8d6031abf7eb93f27',
//     'token_id': 24073,
//     'token_name': 'Artwork NFT',
//     'token_symbol': 'ANFT',
//     'token_decimal': '0',
//     'nft_url': 'https://www.bakeryswap.org/api/v1/artworks/442ebc9780ea40fcbfd5e891b854ccb4'
//     'block_hash': '0x1c631279bc44edee97e2a71b59c7c61e5ec3094a2803728194b567b0d103022f',
//     'hash': '0x88f784bf9cca7660a0a3541d9e4a15163266da94e3b0eb2142f83e4c3594dbfa',
//     'block_number': '7566545',
//     'nonce': '20',
//     'time_stamp': '1621494338',
//     'gas': '390483',
//     'gas_price': '5000000000',
//     'gas_used': '260322',
//     'cumulative_gas_used': '16688566',
//     'input': 'deprecated',
//     'confirmations': '3259826',
//   }
// ]