import 'package:bloc/bloc.dart';

/// Used to control state from [TreeNode] to open it
class NodeIsOpenCubit extends Cubit<bool> {
  NodeIsOpenCubit() : super(false);

  /// Called on user clicks on Node to open or close it.
  void clickOnNode() => emit(!state);
}
