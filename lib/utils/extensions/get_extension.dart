import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension GetFromProvider on State {
  T get<T>() {
    return context.read<T>();
  }
}