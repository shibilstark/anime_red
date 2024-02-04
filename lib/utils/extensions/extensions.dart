import 'package:anime_red/utils/connectivity/connectivity_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension CustomContextOperations on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}

extension CustomBlocFunctions on Bloc {
  Future<bool> haveInternetConnection() =>
      ConnectivityUtil.checkInernetConnectivity();
}
