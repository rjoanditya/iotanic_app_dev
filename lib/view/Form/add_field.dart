import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:iotanic_app_dev/controller/variety.dart';
import 'package:iotanic_app_dev/view/Form/add_location.dart';

import '../../controller/address_controller.dart';
import '../../controller/land_controller.dart';
import '../screen_monitoring/detail-lahan.dart';

class AddField extends StatefulWidget {
  const AddField({Key? key}) : super(key: key);

  @override
  State<AddField> createState() => _AddFieldState();
}

class _AddFieldState extends State<AddField> {
  final formKey = GlobalKey<FormState>();
  final _popupBuilderKey = GlobalKey<DropdownSearchState<String>>();

  var landC = Get.put(Land());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Lahan Baru',
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
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
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
                          controller: landC.name,
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(vertical: 7.5),
                      //   child: DropdownSearch<dynamic>(
                      //     asyncItems: (text) {
                      //       return VarietyController.getVariety();
                      //     },
                      //     dropdownBuilder: (context, selectedItem) => Text(selectedItem?.name ?? 'Pilih Tanaman'),
                      //     onChanged: (newValue) async {
                      //       landC.varietyId.text = newValue.id;
                      //     },
                      //     popupProps: PopupProps.bottomSheet(
                      //       itemBuilder: (context, item, isSelected) {
                      //         return Container(
                      //           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      //           child: Text(
                      //             item.name ?? "",
                      //             style: TextStyle(
                      //               color: Theme.of(context).primaryColor,
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       title: Container(
                      //         padding: const EdgeInsets.only(top: 20),
                      //         child: Text(
                      //           'Pilih Jenis Tanaman yang tersedia',
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //             color: Theme.of(context).primaryColor,
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //       ),
                      //       showSearchBox: true,
                      //       searchFieldProps: TextFieldProps(
                      //         controller: landC.varietyId,
                      //         focusNode: FocusNode(),
                      //         padding: const EdgeInsets.all(20),
                      //         style: TextStyle(color: Theme.of(context).primaryColor),
                      //         decoration: InputDecoration(
                      //             hintText: 'Cari Tanaman',
                      //             hintStyle: TextStyle(
                      //               color: Theme.of(context).primaryColor,
                      //             ),
                      //             focusedBorder: OutlineInputBorder(
                      //               // gapPadding: 17.0,
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                      //             ),
                      //             enabledBorder: OutlineInputBorder(
                      //               // gapPadding: 17.0,
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                      //             ),
                      //             constraints: BoxConstraints(
                      //               maxHeight: screenHeight * 0.065,
                      //             )),
                      //       ),
                      //       bottomSheetProps: BottomSheetProps(
                      //         elevation: 10,
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                      //         ),
                      //         backgroundColor: Theme.of(context).highlightColor,
                      //       ),
                      //       listViewProps: const ListViewProps(
                      //         padding: EdgeInsets.symmetric(horizontal: 20),
                      //       ),
                      //       fit: FlexFit.loose,
                      //       constraints: BoxConstraints(maxHeight: screenHeight * 0.6),

                      //       // itemBuilder: listItem,
                      //     ),
                      //     dropdownDecoratorProps: DropDownDecoratorProps(
                      //       baseStyle: TextStyle(color: Theme.of(context).primaryColor),
                      //       dropdownSearchDecoration: InputDecoration(
                      //         label: Text(
                      //           'Jenis Tanaman',
                      //           style: TextStyle(
                      //             color: Theme.of(context).primaryColor,
                      //             fontSize: 14,
                      //           ),
                      //         ),
                      //         suffixIconColor: Theme.of(context).primaryColorDark,
                      //         focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                      //         ),
                      //         enabledBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                      //         ),
                      //         constraints: BoxConstraints(maxHeight: screenHeight * 0.08),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            suffix: Text('m²'),
                            labelText: 'Luas Lahan',
                            labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
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
                          controller: landC.area,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
                        child: TextFormField(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) {
                                return const AddLocation(); // return const Index();
                              }),
                            );
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Lokasi',
                            labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                            hintText: (landC.lat.text != '') ? '${landC.lat.text}, ${landC.lon.text}' : 'Tersimpan, ketuk untuk mengubah',
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
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: DropdownSearch<dynamic>(
                          dropdownBuilder: (context, selectedItem) {
                            return Text(
                              selectedItem?.name ?? 'Pilih Provinsi',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            );
                          },
                          onChanged: (newValue) async {
                            landC.province.text = newValue.id;
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
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
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
                            landC.regency.text = newValue.id;
                          },
                          asyncItems: (text) async {
                            return AddressController.getRegencies(landC.province.text);
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
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
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
                            landC.district.text = newValue.id;
                          },
                          asyncItems: (text) async {
                            return AddressController.getDistricts(landC.regency.text);
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
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 7.5),
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
                            landC.village.text = newValue.id;
                          },
                          asyncItems: (text) async {
                            return AddressController.getVillages(landC.district.text);
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
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(builder: (BuildContext context) {
                        //     return DetailLahan(); // return const Index();
                        //   }),
                        // );
                        // createLand();

                        landC.createLand(context);
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
