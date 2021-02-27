class Post {
  final String status ;
  final List<dynamic> data;

  Post({this.status,this.data});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      status: json['status'],
      data: json['data'],
    );
  }
}

// save(String token) async{
//   final prefs = await SharedPreferences.getInstance();
//   int counter = (prefs.getInt('counter') ?? 0) + 1;
//   print('Pressed $counter times.');
//   await prefs.setInt('counter', counter);
// }
//
// _getAndSaveToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   String token = await loginUser(email, password);
//   await prefs.setInt('jwt', token);
// }

// Future<List<Datum>>_fetchDocs() async {
//
//   final doctorListURl = 'http://65.1.45.74:8181/doctor/get-all/';
//   final response = await http.get(doctorListURl);
//
//   if (response.body.isNotEmpty) {
//     List jsonResponse = jsonDecode (response.body);
//     return jsonResponse;
//   } else {
//     throw Exception('Failed to load doctor from API');
//   }
// }