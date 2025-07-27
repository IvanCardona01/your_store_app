import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_store_app/features/cart/interactor/watch_cart_count_use_case.dart';

class CartBadgeCubit extends Cubit<int> {
  final WatchCartCountUseCase _watchCartCountUseCase;
  late final Stream<int> _countStream;

  CartBadgeCubit(this._watchCartCountUseCase) : super(0) {
    _countStream = _watchCartCountUseCase();
    _countStream.listen((count) => emit(count));
  }
}
