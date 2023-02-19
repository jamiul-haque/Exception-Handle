import 'package:baseclient/helper/dialog_helper.dart';
import 'package:baseclient/services/app_exceptions.dart';

class BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      // show dialog
      var message = error.message;
      DialogHelper.showErroDialog(description: message);
    } else if (error is FetchDataExcption) {
      var message = error.message;
      DialogHelper.showErroDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErroDialog(
          description: 'Oops! It took longer to respond.');
    }
  }

  showLoading(String message) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
