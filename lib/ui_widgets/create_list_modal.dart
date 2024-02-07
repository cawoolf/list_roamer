import 'package:flutter/cupertino.dart';

class CreateListModal extends StatefulWidget {
  const CreateListModal({Key? key, this.closeModal}) : super(key: key);

  final Function? closeModal;

  @override
  State<CreateListModal> createState() => _CreateListModalState();


}

class _CreateListModalState extends State<CreateListModal>{

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();

  bool _isLoading = false;

  // Rive Animation examples. Need to import package.
  // late rive.SMITrigger _successAnim;
  // late rive.SMITrigger _errorAnim;
  // late rive.SMITrigger _confettiAnim;

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
    // Copy UI from RiveExampleApp
  }
}
