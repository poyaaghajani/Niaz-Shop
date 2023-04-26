import 'package:flutter/material.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_profile/utils/profile_list_model.dart';
import 'package:niaz_shopping/features/feature_profile/widgets/line.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile_screen';

  ProfileScreen({super.key});

  final List<ProfileListModel> profileList = [
    ProfileListModel(
      iconData: Icons.person,
      title: "حساب کاربری شخصی",
      onTap: () {},
    ),
    ProfileListModel(
      iconData: Icons.shopping_bag_outlined,
      title: "حساب کاربری فروشگاهی",
      onTap: () {},
    ),
    ProfileListModel(
      iconData: Icons.mark_email_read,
      title: "تایید اعتبار",
      onTap: () {},
    ),
    ProfileListModel(
      iconData: Icons.calendar_month_sharp,
      title: "سفارشات",
      onTap: () {},
    ),
    ProfileListModel(
      iconData: Icons.home_work,
      title: "آدرس من",
      onTap: () {},
    ),
    ProfileListModel(
      iconData: Icons.support_agent,
      title: "پشتیبانی",
      onTap: () {},
    ),
    ProfileListModel(
      iconData: Icons.people,
      title: "درباره ما",
      onTap: () {},
    ),
    ProfileListModel(
      iconData: Icons.settings,
      title: "تنظیمات",
      onTap: () {},
    ),
    ProfileListModel(
      iconData: Icons.exit_to_app,
      title: "خروج از حساب",
      onTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final name = PrefsManager.readName();
    final phone = PrefsManager.readPhone();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: CustomColors.dark,
                highlightColor: Colors.grey,
                child: Text(
                  name,
                  style: CustomTextStyle.darkLarge,
                ),
              ),
              Text(phone),
              Line(width / 2),
              SizedBox(height: height / 15),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        profileList[index].title,
                        style: TextStyle(
                          color: index == profileList.length - 1
                              ? CustomColors.red
                              : CustomColors.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      leading: Icon(
                        profileList[index].iconData,
                        color: index == profileList.length - 1
                            ? CustomColors.red
                            : CustomColors.lightAmber,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: index == profileList.length - 1
                            ? CustomColors.red
                            : CustomColors.dark,
                      ),
                      onTap: index == profileList.length - 1
                          ? () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        CustomColors.backgroundScreenColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: const Text(
                                      'از خروج حساب کاربری خود مطمعن هستید؟',
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyle.darkMedium,
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    CustomColors.green),
                                            onPressed: () {
                                              PrefsManager.logOut();
                                              Restart.restartApp();
                                            },
                                            child: const Text('بله'),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    CustomColors.red),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              PrefsManager.readName();
                                              PrefsManager.readPhone();
                                            },
                                            child: const Text('خیر'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          : profileList[index].onTap,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Line(width),
                    );
                  },
                  itemCount: profileList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
