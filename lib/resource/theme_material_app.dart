import 'package:flutter/material.dart';
import 'package:structure_example/resource/colors_data.dart';
import 'package:structure_example/resource/dimen.dart';
import 'package:structure_example/resource/fonts_name.dart';
import 'package:structure_example/resource/fonts_size.dart';

class ThemeMaterialApp {
  final ThemeData themeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: ColorsData.background,
    primarySwatch: Colors.green,
    fontFamily: FontsName.regular,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimen.dialogRadius),
      ),
    ),
    dividerColor: ColorsData.divider,
    textTheme: TextTheme(
      button: TextStyle(
        color: ColorsData.textButtom,
        fontFamily: FontsName.regular,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorsData.background,
    ),
    dialogBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: ColorsData.appBarBackground,
      iconTheme: IconThemeData(color: ColorsData.appBarIcon),
      actionsIconTheme: IconThemeData(color: ColorsData.appBarActionIcon),
    ),
    primaryTextTheme: TextTheme(
      button: TextStyle(color: ColorsData.text),
    ),
    tabBarTheme: TabBarTheme(
      indicator: UnderlineTabIndicator(borderSide: BorderSide(color: ColorsData.tabsIndicator, width: 2)),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: ColorsData.tabsSelected,
      unselectedLabelColor: ColorsData.tabsUnselected,
      labelStyle: TextStyle(fontFamily: FontsName.semiBold, color: ColorsData.tabsSelected),
      unselectedLabelStyle: TextStyle(fontFamily: FontsName.semiBold, color: ColorsData.tabsUnselected),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorsData.selected,
      unselectedItemColor: ColorsData.unselected,
      selectedIconTheme: IconThemeData(
        color: ColorsData.selected,
      ),
      unselectedIconTheme: IconThemeData(
        color: ColorsData.unselected,
      ),
      selectedLabelStyle: TextStyle(
        fontFamily: FontsName.semiBold,
        fontSize: FontsSize.caption,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: FontsName.semiBold,
        fontSize: FontsSize.caption,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorsData.buttom,
      textTheme: ButtonTextTheme.normal,
      colorScheme: ColorScheme.dark(),
      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimen.radiousButton),
        // side: BorderSide(color: ColorsData.borderButtom),
      ),
      padding: EdgeInsets.symmetric(vertical: Dimen.paddingContentButtom),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    backgroundColor: ColorsData.background,
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsData.fillInput,
      labelStyle: TextStyle(color: ColorsData.lableInput),
      hintStyle: TextStyle(color: ColorsData.hintInput),
      prefixStyle: TextStyle(color: ColorsData.iconInput),
      suffixStyle: TextStyle(color: ColorsData.iconInput),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimen.borderInput),
        borderSide: BorderSide(color: ColorsData.boderInput),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimen.borderInput),
        borderSide: BorderSide(color: ColorsData.boderInput),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimen.borderInput),
        borderSide: BorderSide(color: ColorsData.focusBoderInput),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimen.borderInput),
        borderSide: BorderSide(color: ColorsData.errorBoderInput),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimen.borderInput),
        borderSide: BorderSide(color: ColorsData.boderInput),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: Dimen.paddingChildInput, vertical: 0),
    ),
    sliderTheme: SliderThemeData(
      activeTickMarkColor: ColorsData.buttom,
      activeTrackColor: ColorsData.buttom,
      inactiveTickMarkColor: ColorsData.textSubTitle,
      inactiveTrackColor: ColorsData.textSubTitle,
      thumbColor: ColorsData.buttom,
    ),
  );
}
