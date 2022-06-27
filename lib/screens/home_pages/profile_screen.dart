import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenso/screens/user_reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/models/user_model.dart';
import '../../theme/themes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKeyForSetting = GlobalKey<FormState>();

  bool _loading = false;
  String? _companyName = "";
  String _email = '';
  String _name = '';
  String _phoneNumber = '';
  DateTime _dob = DateTime.now();
  bool _isInit = true;
  bool isUpdate = false;
  Map<String, dynamic> updateFields = {};

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      final _user = Provider.of<UserModel>(context, listen: false);

      _name = _user.name!;
      _email = _user.email;
      _companyName = _user.companyName;
      _dob = _user.dob ?? DateTime.now();
      _phoneNumber = _user.phoneNumber ?? '';
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void addToUpdateField(String key, dynamic val) {
    if (updateFields.containsKey(key)) {
      updateFields.update(key, (value) => val);
    } else {
      updateFields.putIfAbsent(key, () => val);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _user = Provider.of<UserModel>(context, listen: false);
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _loading
          ? loading
          : SafeArea(
              child: SizedBox(
                width: mediaQuery.size.width,
                child: Form(
                  key: _formKeyForSetting,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedBox20,
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Text(
                            'Edit Profile & Settings',
                            style: TextStyle(
                                color: Color.fromRGBO(0, 18, 56, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                        sizedBox10,
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: _user.imageUrl == null
                                        ? const Image(
                                            image: AssetImage(
                                                'assets/images/check.png'))
                                        : CachedNetworkImage(
                                            imageUrl:
                                                kBackendUrl + _user.imageUrl!,
                                            fit: BoxFit.cover,
                                            height: 60,
                                            width: 60,
                                            errorWidget: (context, url,
                                                    error) =>
                                                const Image(
                                                    image: AssetImage(
                                                        'assets/images/check.png')),
                                          )),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 40,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      color: Colors.green,
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          _loading = true;
                                        });

                                        var result = await _auth.updateProfile(
                                          null,
                                          ImageSource.gallery,
                                          _user.uid,
                                        );

                                        if (result == null) {
                                          showSnacBar(
                                              context, 'Something went wrong');
                                        } else {
                                          _user.imageUrl = result['url_image'];
                                          showSnacBar(
                                              context, 'Successfully updated.');
                                        }

                                        setState(() {
                                          _loading = false;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        sizedBox20,
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Company Name: $_companyName',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        sizedBox30,
                        isUpdate
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.orange),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                        onPressed: () async {
                                          if (_formKeyForSetting.currentState!
                                              .validate()) {
                                            setState(() {
                                              _loading = true;
                                            });

                                            var result =
                                                await _auth.updateProfile(
                                              updateFields,
                                              null,
                                              _user.uid,
                                            );

                                            if (result != null) {
                                              isUpdate = false;
                                              showSnacBar(context,
                                                  'Successfully updated.');
                                            } else {
                                              showSnacBar(context,
                                                  'Something went wrong');
                                            }

                                            setState(() {
                                              _loading = false;
                                            });
                                          }
                                        },
                                        child: const Text(
                                          'Update',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        )),
                                  ),
                                ),
                              )
                            : Container(),
                        const Divider(
                          thickness: 1.2,
                          color: Color.fromRGBO(14, 82, 182, 0.87),
                        ),
                        sizedBox25,
                        SettingItemTile(
                          title: 'Name',
                          validator: (val) {
                            final temp = val.toString().split(' ').join();
                            return !isAlpha(temp) ? 'Enter an name' : null;
                          },
                          onChanged: (val) {
                            _name = val;
                            addToUpdateField('name', val);
                          },
                          onTap: () {
                            setState(() {
                              isUpdate = true;
                            });
                          },
                          value: _name,
                        ),
                        sizedBox20,
                        SettingItemTile(
                          title: 'Phone Number',
                          validator: (val) => !isPhoneNumber.hasMatch(val!)
                              ? "Please enter a valid phone number"
                              : null,
                          onChanged: (val) {
                            if (isPhoneNumber.hasMatch(val)) {
                              _phoneNumber =
                                  isPhoneNumber.firstMatch(val)!.group(1)! +
                                      isPhoneNumber.firstMatch(val)!.group(2)!;
                              _phoneNumber = val;
                              addToUpdateField('phoneNumber', val);
                            }
                          },
                          onTap: () {
                            setState(() {
                              isUpdate = true;
                            });
                          },
                          value: _phoneNumber,
                        ),
                        sizedBox20,
                        InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.show');

                                  return const ShowEditEmail();
                                }).then((value) {
                              setState(() {
                                if (value != null) {}
                              });
                            });
                          },
                          child: ListTile(
                            dense: true,
                            title: const Text(
                              'Email',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _email,
                                style: const TextStyle(
                                    color: Color.fromRGBO(57, 98, 187, 1),
                                    fontSize: 18),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                        ),
                        sizedBox20,
                        const Divider(
                          thickness: 1.0,
                          color: Color.fromRGBO(14, 82, 182, 0.3),
                        ),
                        InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.show');
                                  return const ShowBankOrAddressDialog();
                                }).then((value) {
                              setState(() {
                                if (value != null) {}
                              });
                            });
                          },
                          child: ListTile(
                            dense: true,
                            title: const Text(
                              'Address',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${_user.address}, ${_user.city}, ${_user.province}',
                                style: const TextStyle(
                                    color: Color.fromRGBO(57, 98, 187, 1),
                                    fontSize: 18),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                        ),
                        sizedBox20,
                        const Divider(
                          thickness: 1.0,
                          color: Color.fromRGBO(14, 82, 182, 0.3),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isUpdate = true;
                            });
                            showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: _dob,
                                    lastDate: DateTime(2100))
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  _dob = value;
                                  addToUpdateField('dob', value);
                                });
                              }
                            });
                          },
                          child: ListTile(
                            dense: true,
                            title: const Text(
                              'Date of Birth',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                DateFormat("yyyy-MM-dd").format(_dob),
                                style: const TextStyle(
                                    color: Color.fromRGBO(57, 98, 187, 1),
                                    fontSize: 18),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                        ),
                        sizedBox20,
                        const Divider(
                          thickness: 1.0,
                          color: Color.fromRGBO(14, 82, 182, 0.3),
                        ),
                        InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.show');
                                  return const ShowBankOrAddressDialog(
                                    isBank: true,
                                  );
                                }).then((value) {
                              setState(() {
                                if (value != null) {}
                              });
                            });
                          },
                          child: ListTile(
                            dense: true,
                            title: const Text(
                              'Bank',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                '${_user.bankNumber ?? ''} ${_user.bankBranch ?? ''} ${_user.bankName ?? ''}',
                                style: const TextStyle(
                                    color: Color.fromRGBO(57, 98, 187, 1),
                                    fontSize: 18),
                              ),
                            ),
                            trailing: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                )),
                          ),
                        ),
                        sizedBox20,
                        const Divider(
                          thickness: 1.0,
                          color: Color.fromRGBO(14, 82, 182, 0.3),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.pushNamed(
                                context, UserReportsScreen.routeName);
                          },
                          child: const ListTile(
                            dense: true,
                            title: Text('User Reports',
                                style: TextStyle(
                                    color: Color.fromRGBO(57, 98, 187, 1),
                                    fontSize: 18)),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                            ),
                          ),
                        ),
                        sizedBox10,
                        SizedBox(
                          width: double.infinity,
                          height: 80,
                          child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  _loading = true;
                                });
                                await _auth.signOut(_user.id);
                              },
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                    color: Color.fromRGBO(240, 27, 27, 1)),
                              )),
                        ),
                        sizedBox40
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
