import 'package:flutter/material.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  TextEditingController name = TextEditingController();
  TextEditingController plantFarmer = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Personal Data',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: screenWidth * 0.175,
                  height: screenWidth * 0.175,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Image(
                    image: AssetImage('public/assets/img/joan.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Builder(
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).highlightColor.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          initialValue: 'Rizky Joanditya Nur Iman',
                          // controller: name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                          obscureText: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), gapPadding: 4, borderSide: BorderSide.none),
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
                              vertical: 17,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).highlightColor.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          initialValue: 'Padi Rojolele',
                          // controller: plantFarmer,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                          obscureText: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), gapPadding: 4, borderSide: BorderSide.none),
                            labelText: 'Plant Farmer',
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            // hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).highlightColor.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          initialValue: '+62 812-3456-7890',
                          // controller: phoneNumber,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                          obscureText: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), gapPadding: 4, borderSide: BorderSide.none),
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
                              vertical: 17,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).highlightColor.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          initialValue: 'Jalan Angkasa, No. 169 Jebres, Jebres, Surakarta',
                          // controller: address,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                          ),
                          maxLines: 4,
                          obscureText: false,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), gapPadding: 4, borderSide: BorderSide.none),
                            labelText: 'Address',
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                            // hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                            fillColor: Theme.of(context).highlightColor,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 50),
                      child: ButtonTheme(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: 15),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              )),
                          child: const Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
