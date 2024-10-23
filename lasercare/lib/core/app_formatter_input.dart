import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppFormatterInput {
  
  static MaskTextInputFormatter cnpjFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[a-zA-Z0-9]')},
  );
}
