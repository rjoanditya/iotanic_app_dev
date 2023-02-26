import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    TextEditingController searchForum = TextEditingController();

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 75,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Center(
            child: Text(
              'Community',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: screenWidth * 0.8,
                child: Text(
                  'Learn Market, Educate the Farmer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Material(
                              elevation: 0,
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              child: TextFormField(
                                controller: searchForum,
                                obscureText: false,
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                  ),
                                  hintText: 'Telusuri Forum',
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
                padding: const EdgeInsets.all(15),
                height: screenHeight - 175,
                child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        AlertDialog alert = AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // Icon(Icons.close_outlined),
                              Text("Fitur belum tersedia")
                            ],
                          ),
                        );
                        showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            width: screenWidth * 0.9,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          // data lahan disini
                                          'Lahan Pak Supriyadi ${index + 1}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Forum ini digunakan untuk membahas tentang apa itu pertanian presisi dan penerapannya kepada petani di Indonesia',
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.w100),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(13, 13, 20, 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(7),
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          // image: DecorationImage(
                                          //   image: AssetImage('public/assets/img/logo.png'),
                                          // ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(7),
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          // image: DecorationImage(
                                          //   image: AssetImage('public/assets/img/logo.png'),
                                          // ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(7),
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          // image: DecorationImage(
                                          //   image: AssetImage('public/assets/img/logo.png'),
                                          // ),
                                        ),
                                      ),
                                      Text(
                                        'Join Forum',
                                        style: TextStyle(color: Theme.of(context).splashColor, fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        Icons.play_arrow_rounded,
                                        size: 20,
                                        color: Theme.of(context).splashColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
