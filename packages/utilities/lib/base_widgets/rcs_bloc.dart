import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utilities/base_widgets/view_snack_bar_channel.dart';


abstract class RCSBloc<T> extends Cubit<T> {
  RCSBloc(super.initialState);
  ViewSnackMessageChannel? messageChannel;
}
