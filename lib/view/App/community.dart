import 'package:flutter/material.dart';

import 'chat.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController searchForum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                key: _formKey,
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
                                style: TextStyle(color: Theme.of(context).primaryColor),
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
                child: Wrap(
                  children: List.generate(1, (index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const Chats();
                          }),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            width: screenWidth * 0.9,
                            margin: const EdgeInsets.all(5),
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
                                          'Topik Komunitas',
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
                                  padding: const EdgeInsets.fromLTRB(13, 10, 20, 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(7),
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: Colors.red,
                                              image: DecorationImage(image: AssetImage('public/assets/img/joan.png'), fit: BoxFit.cover),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(7),
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: Colors.red,
                                              image: DecorationImage(image: AssetImage('public/assets/img/joan.png'), fit: BoxFit.cover),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(7),
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              color: Colors.grey,
                                              image: DecorationImage(image: AssetImage('public/assets/img/joan.png'), fit: BoxFit.cover),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
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
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
