// ignore_for_file: unused_element, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/values/colors.dart';
import 'package:chat_app/pages/message/chat/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'index.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  photo_profile() {
    return Container(
      padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
      child: InkWell(
        child: SizedBox(
          width: 44.w,
          height: 44.h,
          child: CachedNetworkImage(
            imageUrl: controller.state.to_avatar.value,
            imageBuilder: (context, imageProvider) => Container(
              height: 44.w,
              width: 44.h,
              margin: null,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(44.w)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  )),
            ),
            errorWidget: (context, url, error) => const Image(
              image: AssetImage("assets/images/feature-1.png"),
            ),
          ),
        ),
      ),
    );
  }

  rest_info() {
    return Container(
      width: 180.w,
      padding: EdgeInsets.only(
        top: 0.w,
        bottom: 0.w,
        right: 0.w,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 44.w,
            width: 180.w,
            child: GestureDetector(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.state.to_name.value,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBackground,
                        fontSize: 16.sp),
                  ),
                  Text(
                    "pseudo",
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryBackground,
                        fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(60, 172, 219, 1)
          //   gradient: LinearGradient(
          // colors: [
          //   Color.fromARGB(255, 176, 106, 231),
          //   Color.fromARGB(255, 166, 112, 231),
          //   Color.fromARGB(255, 131, 123, 231),
          //   Color.fromARGB(255, 104, 132, 231),
          // ],
          // transform: GradientRotation(90),
        // )
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
        child: Row(
          children: [
            photo_profile(),
            SizedBox(
              width: 15.w,
            ),
            rest_info(),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  controller.imgFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text("Camera"),
                onTap: () {},
              )
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            children: [
              const ChatList(),
              Positioned(
                bottom: 0.h,
                height: 50.h,
                child: Container(
                  width: 360.w,
                  height: 50.h,
                  color: AppColors.primaryBackground,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                        width: 217.w,
                        height: 50.h,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          controller: controller.textController,
                          autofocus: false,
                          focusNode: controller.contentNode,
                          decoration: const InputDecoration(
                            hintText: "Send messages...",
                          ),
                        ),
                      ),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        margin: EdgeInsets.only(left: 5.w),
                        child: GestureDetector(
                          child: Icon(
                            Icons.photo_outlined,
                            size: 35.w,
                            color: Colors.blue,
                          ),
                          onTap: () {
                            _showPicker(context);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.w),
                        width: 80.w,
                        height: 35.w,
                        child: ElevatedButton(
                          child: const Text("Send"),
                          onPressed: () {
                            controller.sendMessage();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
