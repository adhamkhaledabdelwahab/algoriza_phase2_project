import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    Key? key,
    required this.message,
    required this.isError,
  }) : super(key: key);

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              isError
                  ? const Icon(
                      Icons.warning,
                      size: 30,
                      color: Colors.red,
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 20,
                    color: isError ? Colors.red : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              isError == true
                  ? TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Close',
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
