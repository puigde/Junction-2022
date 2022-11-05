import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../widgets/main_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<User> users = User.users;
    List<Chat> chats = Chat.chats;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ])),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: Column(children: [
          _SocialBar(height: height, users: users),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                _ChatPreview(height: height, chats: chats),
                _BottomBar(width: width),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({Key? key, required this.width}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 65,
        width: width * 0.5,
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withAlpha(150),
                spreadRadius: 4,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.primary.withAlpha(200)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                      color: Colors.black, Icons.person_outline_outlined)),
            ),
            const SizedBox(width: 30),
            Material(
              color: Colors.transparent,
              child: IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(color: Colors.black, Icons.message_outlined)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatPreview extends StatelessWidget {
  const _ChatPreview({
    Key? key,
    required this.height,
    required this.chats,
  }) : super(key: key);

  final double height;
  final List<Chat> chats;

  @override
  Widget build(BuildContext context) {
    return MainContainer(
        height: height,
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            User user =
                chats[index].users!.where((user) => user.id != '1').first;
            chats[index]
                .messages
                .sort((a, b) => b.createdAt.compareTo(a.createdAt));
            Message lastMessage = chats[index].messages.first;

            return ListTile(
              onTap: () {
                Get.toNamed('/chat', arguments: [
                  user,
                  chats[index],
                ]);
              },
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(user.imagePath),
              ),
              title: Text(
                '${user.name} ${user.surname}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(lastMessage.text,
                  maxLines: 1, style: Theme.of(context).textTheme.bodySmall),
              trailing: Text(
                  '${lastMessage.createdAt.hour}:${lastMessage.createdAt.minute}',
                  style: Theme.of(context).textTheme.bodySmall),
            );
          },
        ));
  }
}

class _SocialBar extends StatelessWidget {
  const _SocialBar({
    Key? key,
    required this.height,
    required this.users,
  }) : super(key: key);

  final double height;
  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.125,
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(user.imagePath)),
                    const SizedBox(height: 10),
                    Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ));
          }),
    );
  }
}