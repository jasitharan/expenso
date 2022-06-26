import 'package:expenso/providers/auth_provider.dart';
import 'package:expenso/providers/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../constants.dart';
import 'themes.dart';

class ShowEditEmail extends StatefulWidget {
  const ShowEditEmail({
    Key? key,
  }) : super(key: key);

  @override
  _ShowEditEmailState createState() => _ShowEditEmailState();
}

class _ShowEditEmailState extends State<ShowEditEmail> {
  final _formEditEmail = GlobalKey<FormState>();
  String _email = '';
  bool _loading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final _user = Provider.of<UserModel>(context, listen: false);
      _email = _user.email;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context, listen: false);
    final _auth = Provider.of<AuthProvider>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: const EdgeInsets.all(0.0),
      content: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromRGBO(10, 78, 178, 0.49), width: 2.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Form(
            key: _formEditEmail,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 16),
                    child: Text(
                      'Email',
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ),
                  sizedBox20,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                    child: TextFormField(
                      key: UniqueKey(),
                      style: const TextStyle(color: Colors.black),
                      initialValue: _email,
                      validator: (val) =>
                          !isEmail(val!) ? 'Enter an email' : null,
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(165, 165, 165, 0.75)),
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1))),
                      onChanged: (val) async {
                        _email = val;
                      },
                    ),
                  ),
                  sizedBox20,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
                        child: _loading
                            ? loading
                            : ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () async {
                                  if (_formEditEmail.currentState!.validate()) {
                                    setState(() {
                                      _loading = true;
                                    });

                                    var result = await _auth.updateProfile(
                                      {'email': _email},
                                      null,
                                      _user.uid,
                                    );

                                    if (result == null) {
                                      showSnacBar(
                                          context, 'This email already exists');
                                    } else {
                                      if (_email != _user.email) {
                                        _auth.sendVerificationEmail(_user.uid);
                                      }

                                      Navigator.pop(context);
                                    }

                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class ShowBankOrAddressDialog extends StatefulWidget {
  final bool isBank;
  const ShowBankOrAddressDialog({
    this.isBank = false,
    Key? key,
  }) : super(key: key);

  @override
  _ShowBankOrAddressDialogState createState() =>
      _ShowBankOrAddressDialogState();
}

class _ShowBankOrAddressDialogState extends State<ShowBankOrAddressDialog> {
  final _formEditAddressOrBank = GlobalKey<FormState>();
  String? _field1;
  String? _field2;
  String? _field3;
  bool _loading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final _user = Provider.of<UserModel>(context, listen: false);

      if (widget.isBank) {
        _field1 = _user.bankNumber;
        _field2 = _user.bankName;
        _field3 = _user.bankBranch;
      } else {
        _field1 = _user.address;
        _field2 = _user.city;
        _field3 = _user.province;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context, listen: false);
    final _auth = Provider.of<AuthProvider>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: const EdgeInsets.all(0.0),
      content: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromRGBO(10, 78, 178, 0.49), width: 2.0),
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Form(
            key: _formEditAddressOrBank,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  sizedBox20,
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Text(
                      widget.isBank ? 'Bank Number' : 'Address',
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ),
                  sizedBox10,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                    child: TextFormField(
                      key: UniqueKey(),
                      style: const TextStyle(color: Colors.black),
                      initialValue: _field1,
                      validator: (val) => widget.isBank
                          ? (!isNumeric(val!) ? 'Enter an bank number' : null)
                          : (val!.isEmpty ? 'Enter an address' : null),
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(165, 165, 165, 0.75)),
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1))),
                      onChanged: (val) async {
                        _field1 = val;
                      },
                    ),
                  ),
                  sizedBox10,
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Text(
                      widget.isBank ? 'Bank Name' : 'City',
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ),
                  sizedBox10,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                    child: TextFormField(
                      key: UniqueKey(),
                      style: const TextStyle(color: Colors.black),
                      initialValue: _field2,
                      validator: (val) => widget.isBank
                          ? (val!.isEmpty ? 'Enter an bank name' : null)
                          : (val!.isEmpty ? 'Enter an city' : null),
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(165, 165, 165, 0.75)),
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1))),
                      onChanged: (val) async {
                        _field2 = val;
                      },
                    ),
                  ),
                  sizedBox10,
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Text(
                      widget.isBank ? 'Bank Branch' : 'Province',
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ),
                  sizedBox10,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                    child: TextFormField(
                      key: UniqueKey(),
                      style: const TextStyle(color: Colors.black),
                      initialValue: _field3,
                      validator: (val) => widget.isBank
                          ? (val!.isEmpty ? 'Enter an bank branch' : null)
                          : (val!.isEmpty ? 'Enter an province' : null),
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(165, 165, 165, 0.75)),
                          ),
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(189, 189, 189, 1))),
                      onChanged: (val) async {
                        _field3 = val;
                      },
                    ),
                  ),
                  sizedBox20,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
                        child: _loading
                            ? loading
                            : ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () async {
                                  if (_formEditAddressOrBank.currentState!
                                      .validate()) {
                                    setState(() {
                                      _loading = true;
                                    });

                                    if (widget.isBank) {
                                      var result = await _auth.updateProfile(
                                        {
                                          'bank_number': _field1,
                                          'bank_name': _field2,
                                          'bank_branch': _field3,
                                        },
                                        null,
                                        _user.uid,
                                      );

                                      if (result == null) {
                                        showSnacBar(context,
                                            'This bank account associated with another account');
                                      } else {
                                        showSnacBar(
                                          context,
                                          'Successfully updated',
                                        );
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      var result = await _auth.updateProfile(
                                        {
                                          'address': _field1,
                                          'city': _field2,
                                          'province': _field3,
                                        },
                                        null,
                                        _user.uid,
                                      );

                                      if (result == null) {
                                        showSnacBar(
                                            context, 'Something went wrong');
                                      } else {
                                        showSnacBar(
                                          context,
                                          'Successfully updated',
                                        );
                                        Navigator.pop(context);
                                      }
                                    }

                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
