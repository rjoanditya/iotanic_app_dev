import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iotanic_app_dev/view/Auth/signin.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:validators/validators.dart';

import '../../controller/address_controller.dart';
import '../../controller/auth_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late bool passwordVisible = true;
  late bool repasswordVisible = true;
  TextEditingController repassword = TextEditingController();
  AuthController signUpController = Get.put(AuthController());
  final _formSignupKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formSignupKey,
                child: Column(
                  children: [
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          controller: signUpController.name,
                          // obscureText: passwordVisible,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            // hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value == null || !isEmail(value)) {
                          //     return 'Phone Number is Required!';
                          //   }
                          // },
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          controller: signUpController.phone,
                          obscureText: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            // hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || !isEmail(value)) {
                              return 'Email is not valid!';
                            }
                          },
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          controller: signUpController.email,
                          obscureText: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            // hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          controller: signUpController.password,
                          obscureText: passwordVisible,
                          autofocus: false,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            suffixIcon: IconButton(
                              padding: const EdgeInsets.only(right: 15),
                              icon: Icon(
                                passwordVisible == true ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).primaryColorLight.withOpacity(.6),
                              ),
                              onPressed: () {
                                passwordVisible = !passwordVisible;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: TextFormField(
                          controller: repassword,
                          obscureText: repasswordVisible,
                          autofocus: false,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide.none,
                            ),
                            labelText: 'Konfirmasi Password',
                            labelStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            suffixIcon: IconButton(
                              padding: const EdgeInsets.only(right: 15),
                              icon: Icon(
                                repasswordVisible == true ? Icons.visibility_off : Icons.visibility,
                                color: Theme.of(context).primaryColorLight.withOpacity(.6),
                              ),
                              onPressed: () {
                                repasswordVisible = !repasswordVisible;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: DropdownSearch<dynamic>(
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.name ?? 'Pilih Provinsi',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onChanged: (newValue) async {
                          signUpController.province.text = newValue.id;
                          setState(() {});
                        },
                        asyncItems: (text) async {
                          return AddressController.getProvinces();
                        },

                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: ListTile(
                                title: Text(
                                  item.name ?? "",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            );
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            focusNode: FocusNode(),
                            padding: EdgeInsets.all(20),
                            style: TextStyle(color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              label: Text(
                                'Cari Provinsi',
                                style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            elevation: 10,
                            backgroundColor: Theme.of(context).highlightColor,
                          ),
                          listViewProps: const ListViewProps(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                        // items: snapshot.data!,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(color: Theme.of(context).primaryColor),
                          dropdownSearchDecoration: InputDecoration(
                            label: Text(
                              'Provinsi',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            suffixIconColor: Theme.of(context).primaryColorDark,
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: DropdownSearch<dynamic>(
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.name ?? 'Pilih Kabupaten',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onChanged: (newValue) async {
                          signUpController.regency.text = newValue.id;
                          setState(() {});
                        },
                        asyncItems: (text) async {
                          print('id provinsi: ${signUpController.province.text}');
                          return AddressController.getRegencies(signUpController.province.text);
                        },

                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: ListTile(
                                title: Text(
                                  item.name ?? "",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            );
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            focusNode: FocusNode(),
                            padding: EdgeInsets.all(20),
                            style: TextStyle(color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              label: Text(
                                'Cari Kabupaten',
                                style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            elevation: 10,
                            backgroundColor: Theme.of(context).highlightColor,
                          ),
                          listViewProps: const ListViewProps(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                        // items: snapshot.data!,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(color: Theme.of(context).primaryColor),
                          dropdownSearchDecoration: InputDecoration(
                            label: Text(
                              'Kabupaten',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            suffixIconColor: Theme.of(context).primaryColorDark,
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: DropdownSearch<dynamic>(
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.name ?? 'Pilih Kecamatan',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onChanged: (newValue) async {
                          signUpController.district.text = newValue.id;
                          setState(() {});
                        },
                        asyncItems: (text) async {
                          return AddressController.getDistricts(signUpController.regency.text);
                        },

                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: ListTile(
                                title: Text(
                                  item.name ?? "",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            );
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            focusNode: FocusNode(),
                            padding: EdgeInsets.all(20),
                            style: TextStyle(color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              label: Text(
                                'Cari Kecamatan',
                                style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            elevation: 10,
                            backgroundColor: Theme.of(context).highlightColor,
                          ),
                          listViewProps: const ListViewProps(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                        // items: snapshot.data!,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(color: Theme.of(context).primaryColor),
                          dropdownSearchDecoration: InputDecoration(
                            label: Text(
                              'Kecamatan',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            suffixIconColor: Theme.of(context).primaryColorDark,
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: DropdownSearch<dynamic>(
                        dropdownBuilder: (context, selectedItem) => Text(
                          selectedItem?.name ?? 'Pilih Desa',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onChanged: (newValue) async {
                          signUpController.village.text = newValue.id;
                          setState(() {});
                        },
                        asyncItems: (text) async {
                          return AddressController.getVillages(signUpController.district.text);
                        },

                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              child: ListTile(
                                title: Text(
                                  item.name ?? "",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            );
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            focusNode: FocusNode(),
                            padding: EdgeInsets.all(20),
                            style: TextStyle(color: Theme.of(context).primaryColor),
                            decoration: InputDecoration(
                              label: Text(
                                'Cari Desa',
                                style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                          ),
                          menuProps: MenuProps(
                            elevation: 10,
                            backgroundColor: Theme.of(context).highlightColor,
                          ),
                          listViewProps: const ListViewProps(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                        // items: snapshot.data!,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(color: Theme.of(context).primaryColor),
                          dropdownSearchDecoration: InputDecoration(
                            label: Text(
                              'Desa',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            suffixIconColor: Theme.of(context).primaryColorDark,
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ButtonTheme(
                  child: ElevatedButton(
                    onPressed: () {
                      if (repassword.text == signUpController.password.text) {
                        signUpController.signup(context);
                      } else {
                        Get.snackbar(
                          "Sign Up Gagal",
                          'Konfirmasi password tidak sama',
                          colorText: Theme.of(context).primaryColor,
                          margin: const EdgeInsets.all(20),
                        );
                      }
                      ;
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: 17),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        )),
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah memiliki akun? ',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const SignIn();
                        }),
                      );
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
