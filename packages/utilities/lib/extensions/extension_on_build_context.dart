import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
Author: Nagaraju.lj
Date: April,2024.
Description: extension on Build context to get the instance of bloc class [Basically Cubit]
 */

extension BlocShortAccess on BuildContext {
  T bloc<T extends Cubit>() {
    return BlocProvider.of<T>(this);
  }
}
