import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 75,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
              )
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Material(
                              elevation: 0,
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              child: TextFormField(
                                // validator: (value) {
                                //   if (value == null || !isEmail(value)) {
                                //     return 'Email is not valid!';
                                //   }
                                // },
                                controller: search,
                                obscureText: false,
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                  hintText: 'Telusuri Koleksi',
                                  hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                                  fillColor: Theme.of(context).highlightColor,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Riwayat Anda',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        )));
  }
}
