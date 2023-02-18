import '../services/base_client.dart';
import 'base_controller.dart';

class TestController with BaseController {
  void getData() async {
    var response = await BaseClient()
        .get('https://jsonplaceholder.typicode.com', '/todos/1')
        .catchError(handleError);
    if (response == null) return;
    print(response);
  }

  void postData() async {
    var request = {'message': 'Jamiul Haque !'};
    var response = await BaseClient()
        .post('https://jsonplaceholder.typicode.com', '/posts', request)
        .catchError(handleError);
    if (response == null) return;
    print(response);
  }
}
