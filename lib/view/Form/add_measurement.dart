import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../Pages_Monitoring/detail-lahan.dart';

class AddMeasurement extends StatefulWidget {
  const AddMeasurement({Key? key}) : super(key: key);

  @override
  State<AddMeasurement> createState() => _AddMeasurementState();
}

class _AddMeasurementState extends State<AddMeasurement> {
  final formKey = GlobalKey<FormState>();
  final _popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  TextEditingController fieldName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<dynamic> data = ['Padi', 'Cabai', 'Jagung'];
    // TextEditingController typePlant = TextEditingController();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Pengukuran Baru',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nama Lahan',
                            labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                            hintText: 'contoh: Sawah Cabeyan 01',
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor.withOpacity(0.5),
                              fontSize: 14,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                            ),
                            constraints: BoxConstraints(maxHeight: screenHeight * 0.08),
                          ),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          controller: fieldName,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        child: DropdownSearch<dynamic>(
                          popupProps: PopupProps.bottomSheet(
                            title: Text(
                              'Pilih Jenis Tanaman yang tersedia',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              focusNode: FocusNode(),
                              padding: EdgeInsets.all(20),
                              style: TextStyle(color: Theme.of(context).primaryColor),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: screenHeight * 0.065,
                                  )),
                            ),
                            bottomSheetProps: BottomSheetProps(
                              elevation: 10,
                              backgroundColor: Theme.of(context).highlightColor,
                            ),
                            listViewProps: const ListViewProps(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            fit: FlexFit.loose,
                            constraints: BoxConstraints(maxHeight: screenHeight * 0.6),
                            // itemBuilder: listItem,
                          ),
                          items: data,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            baseStyle: TextStyle(color: Theme.of(context).primaryColor),
                            dropdownSearchDecoration: InputDecoration(
                              label: Text(
                                'Jenis Tanaman',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                              suffixIconColor: Theme.of(context).primaryColorDark,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              constraints: BoxConstraints(maxHeight: screenHeight * 0.08),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7.5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Lokasi',
                            labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                            hintText: 'tentukan lokasi lahan anda',
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor.withOpacity(0.5),
                              fontSize: 14,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                            ),
                            constraints: BoxConstraints(maxHeight: screenHeight * 0.08),
                          ),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        child: DropdownSearch<dynamic>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              focusNode: FocusNode(),
                              padding: EdgeInsets.all(20),
                              style: TextStyle(color: Theme.of(context).primaryColor),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: screenHeight * 0.065,
                                  )),
                            ),
                            menuProps: MenuProps(
                              elevation: 10,
                              backgroundColor: Theme.of(context).highlightColor,
                            ),
                            listViewProps: const ListViewProps(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            fit: FlexFit.loose,
                            constraints: BoxConstraints(maxHeight: screenHeight * 0.6),
                            // itemBuilder: listItem,
                          ),
                          items: data,
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
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              constraints: BoxConstraints(maxHeight: screenHeight * 0.08),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        child: DropdownSearch<dynamic>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              focusNode: FocusNode(),
                              padding: EdgeInsets.all(20),
                              style: TextStyle(color: Theme.of(context).primaryColor),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: screenHeight * 0.065,
                                  )),
                            ),
                            menuProps: MenuProps(
                              elevation: 10,
                              backgroundColor: Theme.of(context).highlightColor,
                            ),
                            listViewProps: const ListViewProps(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            fit: FlexFit.loose,
                            constraints: BoxConstraints(maxHeight: screenHeight * 0.6),
                            // itemBuilder: listItem,
                          ),
                          items: data,
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
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              constraints: BoxConstraints(maxHeight: screenHeight * 0.08),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        child: DropdownSearch<dynamic>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              focusNode: FocusNode(),
                              padding: EdgeInsets.all(20),
                              style: TextStyle(color: Theme.of(context).primaryColor),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: screenHeight * 0.065,
                                  )),
                            ),
                            menuProps: MenuProps(
                              elevation: 10,
                              backgroundColor: Theme.of(context).highlightColor,
                            ),
                            listViewProps: const ListViewProps(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            fit: FlexFit.loose,
                            constraints: BoxConstraints(maxHeight: screenHeight * 0.6),
                            // itemBuilder: listItem,
                          ),
                          items: data,
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
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              constraints: BoxConstraints(maxHeight: screenHeight * 0.08),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        child: DropdownSearch<dynamic>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              focusNode: FocusNode(),
                              padding: EdgeInsets.all(20),
                              style: TextStyle(color: Theme.of(context).primaryColor),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    // gapPadding: 17.0,
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight: screenHeight * 0.065,
                                  )),
                            ),
                            menuProps: MenuProps(
                              elevation: 10,
                              backgroundColor: Theme.of(context).highlightColor,
                            ),
                            listViewProps: const ListViewProps(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                            ),
                            fit: FlexFit.loose,
                            constraints: BoxConstraints(maxHeight: screenHeight * 0.6),
                            // itemBuilder: listItem,
                          ),
                          items: data,
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
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                              ),
                              constraints: BoxConstraints(maxHeight: screenHeight * 0.08),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return DetailLahan(); // return const Index();
                          }),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 18.5, horizontal: screenWidth * 0.34),
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
        ),
      ),
    );
  }
}
