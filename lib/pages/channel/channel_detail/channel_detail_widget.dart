import 'package:flutter/material.dart';
import 'package:twake/config/image_path.dart';
import 'package:twake/routing/app_router.dart';
import 'package:twake/widgets/common/rounded_image.dart';

class ChannelDetailWidget extends StatelessWidget {
  const ChannelDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF2F2F6),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () => popBack(),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xff004dff),
                        )),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.keyboard_control,
                          color: Color(0xff004dff),
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: RoundedImage(
                        width: 88,
                        height: 88,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 6),
                child: Text('Twake product team',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    )
                ),
              ),
              Text('24 members',
                  style: TextStyle(
                    color: Color(0x59000000),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  )
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 80,
                    height: 70,
                    child: Column(
                      children: [
                        Image.asset(imageAddMember, width: 46, height: 36,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Add members',
                              style: TextStyle(
                                color: Color(0xff004dff),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 70,
                    child: Column(
                      children: [
                        Image.asset(imageMessages, width: 46, height: 36,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Messages',
                              style: TextStyle(
                                color: Color(0xff004dff),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 70,
                    child: Column(
                      children: [
                        Image.asset(imageSearch, width: 46, height: 36,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Search',
                              style: TextStyle(
                                color: Color(0xff004dff),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 70,
                    child: Column(
                      children: [
                        Image.asset(imageNotificationSetting, width: 46, height: 36,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Mute',
                              style: TextStyle(
                                color: Color(0xff004dff),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 16, left: 10, right: 20),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                          Expanded(
                            child: Text('Edit channel info',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0, left: 4),
                            child: Icon(Icons.keyboard_arrow_right, color: Color(0x4c3c3c43),),
                          )
                        ],
                      ),
                    Divider(height: 1, color: Color(0x1e000000),),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, bottom: 16, left: 10, right: 20),
                          child: Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Text('Channel settings',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 4),
                          child: Icon(Icons.keyboard_arrow_right, color: Color(0x4c3c3c43),),
                        )
                      ],
                    ),
                    Divider(height: 1, color: Color(0x1e000000),),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, bottom: 16, left: 10, right: 20),
                          child: Image.asset(imageGroupBlack, width: 16, height: 16,),
                        ),
                        Expanded(
                          child: Text('Member management',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                        Text('24',
                            style: TextStyle(
                              color: Color(0xff004dff),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.keyboard_arrow_right, color: Color(0x4c3c3c43),),
                        )
                      ],
                    )
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