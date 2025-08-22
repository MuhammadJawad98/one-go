import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';


bool isDarkModeEnabled(BuildContext context){
  return Provider.of<ThemeProvider>(context,listen: true).isDarkModeEnabled;
}