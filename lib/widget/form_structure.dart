import 'package:flutter/material.dart';
import 'package:mascotas/exception/datasource_exception.dart';
import 'package:mascotas/exception/notifier_exception.dart';

class FormStructure extends StatefulWidget {
  final Future<void> Function() onSave;
  final Widget child;
  final String successfulMessage;
  final String Function(DatasourceException) errorMessage;
  final String buttonMessage;

  const FormStructure({
    required this.onSave,
    required this.child,
    required this.successfulMessage,
    required this.errorMessage,
    required this.buttonMessage,
    super.key,
  });

  @override
  State<FormStructure> createState() => _FormStructureState();
}

class _FormStructureState extends State<FormStructure> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _error = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                widget.child,
                if (_error.isNotEmpty)
                  Text(
                    _error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                      onPressed: save,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              widget.buttonMessage,
                              style: const TextStyle(color: Colors.white),
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _error = '';
      });
      widget.onSave().then((_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.successfulMessage)),
        );
      }).catchError((error) {
        if (error is NotifierException) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
          return;
        }
        setState(() {
          _error = widget.errorMessage(error);
        });
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }
}
