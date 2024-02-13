import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateListModal extends StatefulWidget {
  const CreateListModal(
      {Key? key, required this.closeModal, required this.onListCreate})
      : super(key: key);

  final Function? closeModal;
  final Function(String name, String category)? onListCreate;

  @override
  State<CreateListModal> createState() => _CreateListModalState();
}

class _CreateListModalState extends State<CreateListModal> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();

  final bool _isLoading = false;

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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.8), Colors.white10],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(29),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              // RiveAppTheme.shadow.withOpacity(0.3),
                              offset: const Offset(0, 3),
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              // RiveAppTheme.shadow.withOpacity(0.3),
                              offset: const Offset(0, 30),
                              blurRadius: 30)
                        ],
                        color: CupertinoColors.secondarySystemBackground,
                        // This kind of give the background iOS style "Frosted Glass" effect,
                        // it works for this particular color, might not for other
                        backgroundBlendMode: BlendMode.luminosity),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Create List",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 34),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                            "Enter the name and category of your List to get started",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 17,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 24),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Title",
                            style: TextStyle(
                                color: CupertinoColors.secondaryLabel,
                                fontFamily: "Inter",
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          // decoration: authInputStyle("icon_email"),
                          controller: _nameController,
                        ),
                        const SizedBox(height: 24),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Category",
                            style: TextStyle(
                                color: CupertinoColors.secondaryLabel,
                                fontFamily: "Inter",
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          // decoration: authInputStyle("icon_lock"),
                          controller: _categoryController,
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF77D8E).withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              )
                            ],
                          ),
                          child: CupertinoButton(
                            padding: const EdgeInsets.all(20),
                            color: const Color(0xFFF77D8E),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 4),
                                Text(
                                  "Create",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            onPressed: () {
                              createList();
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Image.asset(AssetPaths.logoEmail),
                            // Image.asset(AssetPaths.logoApple),
                            // Image.asset(AssetPaths.logoGoogle)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // successAnimation(),
                closeIcon()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createList() {
    print(
        'create_list_modal line 183 --> Title: ${_nameController.text} Category: ${_categoryController.text}');
    widget.onListCreate!(
        _nameController.text,
        _categoryController
            .text); // Passes the back to the ListViewPage to create the List
    widget.closeModal!(); // Closes the modal
  }

  Positioned closeIcon() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(36 / 2),
          minSize: 36,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36 / 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black, //RiveAppTheme.shadow.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            widget.closeModal!();
          },
        ),
      ),
    );
  }
}
