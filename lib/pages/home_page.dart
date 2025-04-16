import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spacepod/bloc/chat_bloc.dart';
import 'package:spacepod/model/chat_message_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ChatBloc, ChatState>(
      bloc: chatBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case ChatSuccessState:
            List<ChatMessageModel> message =
                (state as ChatSuccessState).messages;
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/space_wallpaper.jpg"),
                      opacity: .4,
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Space-Pod",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(Icons.image_search_outlined)),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: message.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.all(12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.amber.withOpacity(0.1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message[index].role == "user"
                                          ? "User"
                                          : "Space Pod",
                                      style: TextStyle(
                                        height: 1.2,
                                        color: message[index].role == "user"
                                            ? Colors.amber
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      message[index].parts.first.text,
                                      style: TextStyle(height: 1.2),
                                    ),
                                  ],
                                ));
                          })),
                  if (chatBloc.generating)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          child: Lottie.asset("assets/lottie/animation.json")),
                          const SizedBox(width: 20,),
                          Text("Loading..."),
                      ],
                    ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Ask Something From Space Pod",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                            onPressed: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGenerateNewTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            icon: Icon(
                              Icons.send_rounded,
                              size: 30,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            );

          default:
            return SizedBox();
        }
      },
    ));
  }
}
