import 'package:excel_google/sheetscolumn.dart';
import 'package:gsheets/gsheets.dart';

class FlutterSheet {
  static String _sheetId = "1kOcueCfFSCaYH466NJwBGaH5AvQ-Z69dcCr86GCUqrQ";

  static const _sheetCredentials = r'''
  {
  "type": "service_account",
  "project_id": "robust-zenith-331014",
  "private_key_id": "6f2d949dead6b5c7dc132e1410590baf89101228",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDeGra6TyZn1wvz\n2Oz/LnzvrA1TkF39FHkF/OY000ET07ebbWBC7XqLc664lcMvfG8rz0DU+pIQ9BkM\nKbsM6yxcPYZdaTR7njA7yiBLaoc4/SalejaoJW4/TqLs1tkWe+5l15jI65+kdSxN\npi7pMQv2R3H0u+xfN3cLEjcd6p6hy0VIQjQbz2A2AsTSAjJdhO1VG9lsaNhy0t6k\nh5+MJollkCc7p6Aoo6FCzoduIUBwvSKUd6qnVkGplI9gRElrmycL4WvrSb0fQ1cu\nfTMBickHeExu/WRzpjBnrYRSeztch44RduKU044gtMwcwyUiBmGSIKiKtH0BP/ZW\nXv+A2AhnAgMBAAECggEAbKQSh5WZyqdVEGUmoDfkIvQ83Ig8gUPXYwdur546MfGY\n2S0qLfKtw7LFX0LaY8rxMjPBmawrcKGF8v4iodITM9dgdyaz5lfdbhGTtHAaTtT9\nZ2odfCg7Ajp71W/OZoIefbB06qrevvoVvrGwNp6oJEKUSkr19ylRUJgLX9XY3HiB\nVzb9QrbygDWgPxbMIcCFbEJ5dJLmdfX76ayg+SYkkyTgrihaQDEAe7FSd4KZEvwE\nTF8gdJrFbW5mHlNz4V9pMBwQCcXsKIhE5Y32n/yJ+03tYauTszgww+KEklkiCbzP\nN5wZYPoJ+e3Q2eJj+fJZ0bLg+noqEDvy3GeF+2Lq4QKBgQDu994T4iv09p4lIP1f\nLBWm58Ibq+lSoIQn8gxWu00Nkh4cJ+AYTUD36OwsaUGi5oZM7aGxA7ssobntwsYr\nfAax54+X4OeFefpiaUHYjmzTQXXqoPBdDpBiadwiO4NbWxEvQqCu6pr1pYtwynDL\nnRFCM8w5fXSA3IdYF+5V2dHgtwKBgQDt7ydXpAwSIAgrOKIH+5C9+dhZmA4qFQBJ\nT461aojs5vmegqdWNop/Rsil5yp4KW0GFx7UrNHO9DHGk1idNODOG3QT/fEv74yd\nvixtLTx890Y3Olq0HOL7ubR4lCfXrXYTQlkzWEqq9d9k7EDo7NuaE9dGey5VAYcb\nBt0vscQF0QKBgQCw7DCuVfAncANMB+2u7cumA8ZRiGi5dQADNxBtkkSM/JZwUBF4\nzJGCOh/JDbC7s6LRB8qDbPjCJYargl4Hyc6HHqLQVoHy74kyHS3T8Daf/cIYkUkE\nDIlXY3rImXk6ROUnMVQXzLgnkIX5Xtg91670bbcRBVIhKaTG0wjw5NCfZwKBgB+J\n1s4wKYVxh4OrIxcpylrUNlBR7na3h+0vxXvYnkPArg/Lw8CSxDLwwAH1rVR2MURg\nZi7MpZboGXz35QQZkT7gtrc7ru+qshnqrlreZyktYbpKWuGK/q9dQ0XEZa+aB4+v\n+MDskCEvLChlhIkbdFRtEtj91Pthk3YKp+D9kD0xAoGBAKQUhP+9bvdEfA26v6g3\n0AM9TwYyuAYfC6wskhuoRcmGqS3egF4ZEPYXWViLjr6LxU1uTjGYBr3QXIc/wGoX\nLIc23z0mCXlTr2YIrY1gecVwMuHi5Shil/VOJDQlqYHrIA58tCDq+slt9ydukArj\nmjdmacerduAD48ajnKFgVd0F\n-----END PRIVATE KEY-----\n",
  "client_email": "excelgoogle@robust-zenith-331014.iam.gserviceaccount.com",
  "client_id": "110913522414349664271",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/excelgoogle%40robust-zenith-331014.iam.gserviceaccount.com"
}
''';

  static Worksheet? _userSheet;
  static final _gsheets = GSheets(_sheetCredentials);

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_sheetId);

      _userSheet = await _getWorkSheet(spreadsheet, title: "Planilha");
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (erro) {
      print(erro);
    }
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (erro) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}
