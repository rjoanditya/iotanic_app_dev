import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  TextEditingController chat = TextEditingController();
  final _messageKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'Topik Komunitas',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            children: [
              Container(
                height: screenHeight * 0.775,
                child: ListView.builder(
                    // padding: const EdgeInsets.symmetric(vertical: 40),
                    reverse: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).splashColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Today',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: 45,
                              height: 45,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).highlightColor,
                              ),
                              child: const Image(
                                image: AssetImage('public/assets/img/joan.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  bottomLeft: Radius.circular(24),
                                  bottomRight: Radius.circular(24),
                                ),
                                color: Theme.of(context).highlightColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Divider(
                                        height: 1,
                                      ),
                                      Text(
                                        "Rizky Joanditya",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).splashColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Forum ini digunakan untuk membahas tentang apa itu pertanian presisi dan penerapannya kepada petani di Indonesia.",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth,
                                    child: Text(
                                      "14:30",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).primaryColor.withOpacity(.45),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                height: screenHeight * 0.87,
                width: screenWidth,
                alignment: Alignment.bottomCenter,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Container(
                        width: screenWidth * 0.85,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: _messageKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Builder(
                                builder: (context) => SingleChildScrollView(
                                  reverse: true,
                                  child: TextFormField(
                                    controller: chat,
                                    obscureText: false,
                                    autofocus: false,
                                    maxLines: 5,
                                    minLines: 1,
                                    style: TextStyle(
                                      color: Theme.of(context).splashColor,
                                    ),
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Message',
                                      hintStyle: TextStyle(
                                        color: Theme.of(context).splashColor,
                                        fontSize: 14,
                                      ),
                                      fillColor: Theme.of(context).highlightColor,
                                      filled: true,
                                      prefixIcon: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Theme.of(context).splashColor,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.attach_file_rounded,
                                        color: Theme.of(context).splashColor,
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
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     padding: EdgeInsets.symmetric(horizontal: 20),
      //     child: Chat(
      //       messages: _messages,
      //       onSendPressed: _handleSendPressed,
      //       user: _user,
      //     ),
      //   ),
      // ),
    );
  }
}
