import 'package:flutter/material.dart';

class FAQs extends StatelessWidget {
  const FAQs({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'FAQs',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ExpansionTile(
                childrenPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text(
                  'Apa kegunaan Forum?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                children: [
                  Text(
                    'Forum ini digunakan untuk membahas tentang apa itu pertanian presisi dan penerapannya kepada petani di Indonesia',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
