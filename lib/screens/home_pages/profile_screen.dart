import 'package:cached_network_image/cached_network_image.dart';
import 'package:expenso/screens/user_reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  String _email = '';
  String _name = '';
  String _phoneNumber = '';
  bool _isInit = true;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      final _user = Provider.of<UserModel>(context, listen: false);

      _name = _user.name!;
      _email = _user.email;
      _phoneNumber = _user.phoneNumber ?? '';
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _user = Provider.of<UserModel>(context, listen: false);
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 241, 245, 1),
      body: _loading
          ? loading
          : SafeArea(
              child: SizedBox(
                width: mediaQuery.size.width,
                child: Form(
                  key: _formKeyForSetting,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedBox20,
                        Stack(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: _user.imageUrl == null
                                      ? const Image(
                                          image: AssetImage(
                                              'assets/images/check.png'))
                                      : CachedNetworkImage(
                                          imageUrl:
                                              kBackendUrl + _user.imageUrl!,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 100,
                                          errorWidget: (context, url, error) =>
                                              const Image(
                                                  image: AssetImage(
                                                      'assets/images/check.png')),
                                        )),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 50,
                                  width: 50,
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
                                          _user.email,
                                          _name,
                                          _phoneNumber,
                                          ImageSource.gallery,
                                          _user.uid);

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
                        sizedBox50,
                        sizedBox20,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ClassTextFormField(
                            initialValue: _name,
                            imageName: kUserIcon,
                            hintText: 'Name',
                            validator: (val) {
                              final temp = val.toString().split(' ').join();
                              return !isAlpha(temp) ? 'Enter an name' : null;
                            },
                            onChanged: (val) {
                              _name = val;
                            },
                          ),
                        ),
                        sizedBox20,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ClassTextFormField(
                            initialValue: _phoneNumber,
                            imageName: kPhoneIcon,
                            hintText: 'Phone Number',
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter mobile number';
                              } else if (val.length != 10 ||
                                  int.tryParse(val) == null) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              _phoneNumber = val;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ClassTextFormField(
                            initialValue: _email,
                            imageName: kEmailIcon2,
                            hintText: 'Email',
                            validator: (val) =>
                                !isEmail(val!) ? 'Enter an email' : null,
                            onChanged: (val) {
                              _email = val;
                            },
                          ),
                        ),
                        sizedBox40,
                        SizedBox(
                          width: 250,
                          child: ClassicButton(
                            title: 'Save',
                            handler: () async {
                              if (_formKeyForSetting.currentState!.validate()) {
                                setState(() {
                                  _loading = true;
                                });

                                var result = await _auth.updateProfile(_email,
                                    _name, _phoneNumber, null, _user.uid);

                                if (result != null) {
                                  showSnacBar(context, 'Successfully updated.');
                                } else {
                                  showSnacBar(context, 'Something went wrong');
                                }

                                setState(() {
                                  _loading = false;
                                });
                              }
                            },
                          ),
                        ),
                        sizedBox20,
                        SizedBox(
                          width: 250,
                          child: ClassicButton(
                            title: 'User Reports',
                            handler: () {
                              Navigator.pushNamed(
                                  context, UserReportsScreen.routeName);
                            },
                          ),
                        ),
                        sizedBox50,
                        SizedBox(
                          width: 250,
                          child: ClassicButton(
                            title: 'Logout',
                            color: Colors.red,
                            handler: () async {
                              setState(() {
                                _loading = true;
                              });
                              await _auth.signOut();
                            },
                          ),
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
