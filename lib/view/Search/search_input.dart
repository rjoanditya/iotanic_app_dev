import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:validators/validators.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    List riwayat = [
      // 'Pertanian',
      // 'Cabai',
      // 'Pupuk',
      // 'Presisi',
      // 'Badai Cabeyan',
    ];
    // double screenWidth = MediaQuery.of(context).size.width;
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
                'Pencarian',
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
                // key: formKey,
                child: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Material(
                              elevation: 0,
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              child: TextField(
                                onSubmitted: (value) async {
                                  print(value);
                                },
                                style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.6)),
                                controller: search,
                                obscureText: false,
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Theme.of(context).primaryColor.withOpacity(.5),
                                  ),
                                  hintText: 'Telusuri Koleksi',
                                  hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor.withOpacity(.6)),
                                  fillColor: Theme.of(context).highlightColor,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(width: 0.8, color: Theme.of(context).primaryColor)),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 20,
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
                  // 'Riwayat Anda',
                  '',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: screenWidth * .9,
                // height: 30,
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  // alignment: WrapAlignment.spaceAround,
                  direction: Axis.horizontal,
                  children: List.generate(riwayat.length, (index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide.none,
                        ),
                        primary: Theme.of(context).highlightColor,
                        onPrimary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                      child: Text('${riwayat[index]}'),
                    );
                  }),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                alignment: Alignment.topLeft,
                child: Text(
                  // 'Cari Kategori',
                  '',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                width: screenWidth * .9,
                // height: 30,
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  // alignment: WrapAlignment.spaceAround,
                  direction: Axis.horizontal,
                  children: List.generate(riwayat.length, (index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide.none,
                        ),
                        primary: Theme.of(context).highlightColor,
                        onPrimary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                      child: Text('${riwayat[index]}'),
                    );
                  }),
                ),
              ),
            ],
          ),
        )));
  }
}
