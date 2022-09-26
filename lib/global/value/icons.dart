import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_user_ios/global/function/enums.dart';
import 'package:gym_user_ios/global/function/formatter.dart';

import 'colors.dart';

class SquattIcon {
  SquattIcon._();

  static String _path(String name) {
    return "assets/svg/$name.svg";
  }

  static SvgPicture appleIcon = SvgPicture.asset(
    _path("apple_icon"),
    height: SquattFormatter.adaptableSize(45, SizeType.height),
    width: SquattFormatter.adaptableSize(45, SizeType.width),
  );
  static SvgPicture googleIcon = SvgPicture.asset(
    _path("google_icon"),
    height: SquattFormatter.adaptableSize(45, SizeType.height),
    width: SquattFormatter.adaptableSize(45, SizeType.width),
  );
  static SvgPicture kakaoIcon = SvgPicture.asset(
    _path("kakao_icon"),
    height: SquattFormatter.adaptableSize(45, SizeType.height),
    width: SquattFormatter.adaptableSize(45, SizeType.width),
  );
  static SvgPicture naverIcon = SvgPicture.asset(
    _path("naver_icon"),
    height: SquattFormatter.adaptableSize(45, SizeType.height),
    width: SquattFormatter.adaptableSize(45, SizeType.width),
  );
  static SvgPicture eyeOn = SvgPicture.asset(
    _path("eye_on"),
    height: SquattFormatter.adaptableSize(13, SizeType.height),
    width: SquattFormatter.adaptableSize(18, SizeType.width),
  );
  static SvgPicture eyeOff = SvgPicture.asset(
    _path("eye_off"),
    height: SquattFormatter.adaptableSize(13, SizeType.height),
    width: SquattFormatter.adaptableSize(18, SizeType.width),
  );

  static SvgPicture eyeOffGrey = SvgPicture.asset(
    _path("eye_off_grey"),
    height: SquattFormatter.adaptableSize(13, SizeType.height),
    width: SquattFormatter.adaptableSize(18, SizeType.width),
  );

  static SvgPicture setPermissions = SvgPicture.asset(
    _path("set_permissions_logo"),
    height: SquattFormatter.adaptableSize(35, SizeType.height),
    width: SquattFormatter.adaptableSize(78, SizeType.width),
  );

  static SvgPicture pocketIcon = SvgPicture.asset(_path("text_logo"),
      height: SquattFormatter.adaptableSize(25, SizeType.height),
      width: SquattFormatter.adaptableSize(109, SizeType.width));
  static SvgPicture phoneIcon = SvgPicture.asset(
    _path("phone_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(18, SizeType.width),
  );
  static SvgPicture placeIcon = SvgPicture.asset(
    _path("place_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(13, SizeType.width),
  );
  static SvgPicture folderIcon = SvgPicture.asset(
    _path("folder_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(21, SizeType.width),
  );
  static SvgPicture cameraIcon = SvgPicture.asset(
    _path("camera_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(20, SizeType.width),
  );

  static SvgPicture logo(double h, double w) {
    return SvgPicture.asset(
      _path("logo"),
      height: SquattFormatter.adaptableSize(h, SizeType.height),
      width: SquattFormatter.adaptableSize(w, SizeType.width),
    );
  }

  static SvgPicture squatLogo(double h, double w) {
    return SvgPicture.asset(
      _path("logo"),
      height: SquattFormatter.adaptableSize(h, SizeType.height),
      width: SquattFormatter.adaptableSize(w, SizeType.width),
    );
  }

  static SvgPicture backIcon({Color color}) {
    return SvgPicture.asset(
      _path("back_icon"),
      color: color,
      height: SquattFormatter.adaptableSize(16, SizeType.height),
      width: SquattFormatter.adaptableSize(16, SizeType.width),
    );
  }

  static SvgPicture nonCheckIcon = SvgPicture.asset(
    _path("non_check_icon"),
    height: SquattFormatter.adaptableSize(16, SizeType.height),
    width: SquattFormatter.adaptableSize(16, SizeType.width),
  );

  static final SvgPicture checkIcon = SvgPicture.asset(
    _path("check_icon"),
    height: SquattFormatter.adaptableSize(8, SizeType.height),
    width: SquattFormatter.adaptableSize(10, SizeType.width),
  );

  static final SvgPicture albumIcon = SvgPicture.asset(
    _path("album_icon"),
    height: SquattFormatter.adaptableSize(9, SizeType.height),
    width: SquattFormatter.adaptableSize(9, SizeType.width),
  );

  static final SvgPicture bigAlbumIcon = SvgPicture.asset(
    _path("album_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(19, SizeType.width),
  );

  static final SvgPicture profileWhiteLogo = SvgPicture.asset(
    _path("profile_white_logo"),
    height: SquattFormatter.adaptableSize(10, SizeType.height),
    width: SquattFormatter.adaptableSize(44, SizeType.width),
  );

  static final SvgPicture placeIcon2 = SvgPicture.asset(
    _path("place_icon_2"),
    height: SquattFormatter.adaptableSize(13, SizeType.height),
    width: SquattFormatter.adaptableSize(11, SizeType.width),
  );

  static final SvgPicture searchIcon = SvgPicture.asset(
    _path("search_icon"),
    height: SquattFormatter.adaptableSize(13, SizeType.height),
    width: SquattFormatter.adaptableSize(13, SizeType.width),
  );

  static final SvgPicture bigPlusIcon = SvgPicture.asset(
    _path("big_plus_icon"),
    height: SquattFormatter.adaptableSize(20, SizeType.height),
    width: SquattFormatter.adaptableSize(20, SizeType.width),
  );
  static final SvgPicture photoAddIcon = SvgPicture.asset(
    _path("big_plus_icon"),
    height: SquattFormatter.adaptableSize(14, SizeType.height),
    width: SquattFormatter.adaptableSize(14, SizeType.width),
  );

  static final SvgPicture closeIcon = SvgPicture.asset(
    _path("close_icon"),
    height: SquattFormatter.adaptableSize(8, SizeType.height),
    width: SquattFormatter.adaptableSize(8, SizeType.width),
  );
  static final SvgPicture bigCloseIcon = SvgPicture.asset(
    _path("big_close_icon"),
    height: SquattFormatter.adaptableSize(15, SizeType.height),
    width: SquattFormatter.adaptableSize(15, SizeType.width),
  );

  static final SvgPicture activeCalendarIcon = SvgPicture.asset(
    _path("active_calendar_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(16, SizeType.width),
  );
  static final SvgPicture calendarIcon = SvgPicture.asset(
    _path("calendar_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(16, SizeType.width),
  );

  static final SvgPicture exerPostureIcon = SvgPicture.asset(
    _path("exerposture_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(23, SizeType.width),
  );
  static final SvgPicture activeExerPostureIcon = SvgPicture.asset(
    _path("active_exerposture_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(23, SizeType.width),
  );

  static final SvgPicture menuExerposture = SvgPicture.asset(
    _path("menu_exerposture"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(28, SizeType.width),
  );
  static final SvgPicture portfolioIcon = SvgPicture.asset(
    _path("portfolio_icon"),
    height: SquattFormatter.adaptableSize(20, SizeType.height),
    width: SquattFormatter.adaptableSize(22, SizeType.width),
  );
  static final SvgPicture activePortfolioIcon = SvgPicture.asset(
    _path("active_portfolio_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(22, SizeType.width),
  );

  static final SvgPicture curriculumIcon = SvgPicture.asset(
    _path("curriculum_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(14, SizeType.width),
  );

  static final SvgPicture activeCurriculumIcon = SvgPicture.asset(
    _path("active_curriculum_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(14, SizeType.width),
  );
  static final SvgPicture myPageIcon = SvgPicture.asset(
    _path("my_page_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(20, SizeType.width),
  );

  static final SvgPicture activeMyPageIcon = SvgPicture.asset(
    _path("active_my_page_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(20, SizeType.width),
  );

  static final SvgPicture schedulerIcon = SvgPicture.asset(
    _path("scheduler_icon"),
    height: SquattFormatter.adaptableSize(17, SizeType.height),
    width: SquattFormatter.adaptableSize(17, SizeType.width),
  );

  static final SvgPicture plusIcon = SvgPicture.asset(
    _path("plus_icon"),
    height: SquattFormatter.adaptableSize(15, SizeType.height),
    width: SquattFormatter.adaptableSize(15, SizeType.width),
  );

  static final SvgPicture blackPlusIcon = SvgPicture.asset(
    _path("plus_icon"),
    color: SquattColor.blackTwo,
    height: SquattFormatter.adaptableSize(15, SizeType.height),
    width: SquattFormatter.adaptableSize(15, SizeType.width),
  );
  static final SvgPicture filterIcon = SvgPicture.asset(
    _path("filter_icon"),
    height: SquattFormatter.adaptableSize(15, SizeType.height),
    width: SquattFormatter.adaptableSize(15, SizeType.width),
  );

  static final SvgPicture myRecordIcon = SvgPicture.asset(
    _path("my_record_icon"),
    height: SquattFormatter.adaptableSize(18, SizeType.height),
    width: SquattFormatter.adaptableSize(15, SizeType.width),
  );
  static final SvgPicture rightIcon = SvgPicture.asset(
    _path("right_icon"),
    height: SquattFormatter.adaptableSize(9, SizeType.height),
    width: SquattFormatter.adaptableSize(4, SizeType.width),
  );
  static SvgPicture whiteEditIcon(double h, double w) {
    return SvgPicture.asset(
      _path("white_edit_icon"),
      height: SquattFormatter.adaptableSize(h, SizeType.height),
      width: SquattFormatter.adaptableSize(w, SizeType.width),
    );
  }

  static SvgPicture chevronDown(double h, double w,
      {Color color = SquattColor.blackTwo}) {
    return SvgPicture.asset(
      _path("album_chevron_down_icon"),
      color: color,
      height: SquattFormatter.adaptableSize(h, SizeType.height),
      width: SquattFormatter.adaptableSize(w, SizeType.width),
    );
  }

  static SvgPicture gymDumbleIcon(double h, double w,
      {Color color = SquattColor.blackTwo}) {
    return SvgPicture.asset(
      _path("gym_dumbell_icon"),
      color: color,
      height: SquattFormatter.adaptableSize(h, SizeType.height),
      width: SquattFormatter.adaptableSize(w, SizeType.width),
    );
  }

  static SvgPicture homeTrainIcon(double h, double w,
      {Color color = SquattColor.blackTwo}) {
    return SvgPicture.asset(
      _path("hometrain_icon"),
      color: color,
      height: SquattFormatter.adaptableSize(h, SizeType.height),
      width: SquattFormatter.adaptableSize(w, SizeType.width),
    );
  }
}
