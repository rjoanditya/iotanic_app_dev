import 'package:flutter/material.dart';

class AddField extends StatelessWidget {
  const AddField({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController fieldName = TextEditingController();
    TextEditingController typePlant = TextEditingController();

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
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Column(
            children: [
              TextFormField(
                key: formKey,
                decoration: InputDecoration(
                  labelText: 'Nama Lahan',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                  ),
                  hintText: 'contoh: Sawah Cabeyan 01',
                  hintStyle: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                controller: fieldName,
              ),
              TextFormField(
                // key: formKey,
                decoration: InputDecoration(
                  labelText: 'Jenis Tanaman',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                  ),
                ),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                controller: typePlant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
