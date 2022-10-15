class Valyuta_Kurs {
  String? code;
  String? cb_price;
  String? nbu_buy_price;
  String? nbu_cell_price;
  String? date;

  Valyuta_Kurs({
    required this.code,
    required this.cb_price,
    required this.nbu_buy_price,
    required this.nbu_cell_price,
    required this.date,
  });

  factory Valyuta_Kurs.froJson(Map<String, dynamic> jsonData) {
    String code = jsonData['code'] ?? '' ;
    String cb_price = jsonData['cb_price'] ?? '';
    String nbu_buy_price = jsonData['nbu_buy_price'] ?? '';
    String nbu_cell_price = jsonData['nbu_cell_price'] ?? '' ;
    String date = jsonData['date'] ?? '';

    return Valyuta_Kurs(
      code: code,
      cb_price: cb_price,
      nbu_buy_price: nbu_buy_price,
      nbu_cell_price: nbu_cell_price,
      date: date,
    );
  }
}
