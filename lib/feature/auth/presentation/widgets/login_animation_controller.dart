import 'package:rive/rive.dart' show SMIInput, StateMachineController;

class LoginAnimationController {

  LoginAnimationController(this.stateMachineController);

  final StateMachineController stateMachineController;

  void setIsChecking([bool value = true]) {
    changeValue<bool>('isChecking', value);
  }

  void setIsHandsUp([bool value = true]) {
    changeValue<bool>('isHandsUp', value);
  }

  void setPeeking([bool value = true]) {
    changeValue<bool>('peeking', value);
  }

  void trigSuccess([bool value = true]) {
    changeValue<bool>('trigSuccess', value);
  }

  void trigFail([bool value = true]) {
    changeValue<bool>('trigFail', value);
  }

  void setNumLook(int numLength, [bool forceUpdate = false]) {
    if (forceUpdate) {
      setIsChecking(true);
    }

    changeValue<double>('numLook', numLength.toDouble());
  }

  void changeValue<T>(String inputName, Object newValue) {
    SMIInput? input = stateMachineController.findInput<T>(inputName);
    assert(input != null, 'Error while finding an $inputName input');
    input?.change(newValue);
  }
}
