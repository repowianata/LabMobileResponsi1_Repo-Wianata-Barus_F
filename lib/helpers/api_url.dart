class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/api';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk =  baseUrl + '/kesehatan/data_nutrisi';
  static const String createProduk =  baseUrl + '/kesehatan/data_nutrisi';

  static String updateProduk(int id) {
    return '$baseUrl/kesehatan/data_nutrisi/$id/update';

  }

  static String showProduk(int id) {
    return '$baseUrl/kesehatan/data_nutrisi/$id';
  }

  static String deleteProduk(int id) {
    return '$baseUrl/kesehatan/data_nutrisi/$id/delete';
  }
}
