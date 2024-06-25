import 'package:Convertify/presentation/widgets/size_config.dart';
import 'package:flutter/material.dart';

class SizeConfigProvider with ChangeNotifier {
  late SizeConfig _sizeConfig;

  SizeConfigProvider(BuildContext context) {
    _sizeConfig = SizeConfig();
    _sizeConfig.init(context);
  }

  SizeConfig get sizeConfig => _sizeConfig;
}
