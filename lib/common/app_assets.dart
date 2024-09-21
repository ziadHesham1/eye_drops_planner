// ignore_for_file: non_constant_identifier_names

abstract class AppAssets {
  static addImage(String name) => 'assets/images/$name';
  static addIcon(String name) => 'assets/icons/$name';

  static addSvg(String name) => 'assets/svg/$name';

  //------------------------------- icons ---------------------------------------

  static final String basket_icon = addIcon('basket_icon.png');
  static final String calender_icon = addIcon('calender_icon.png');
  static final String linkedin_icon = addIcon('linkedin_icon.png');
  static final String facebook_icon = addIcon('facebook_icon.png');
  static final String twitter_icon = addIcon('twitter_icon.png');
  static final String first_icon = addIcon('First.png');
  static final String last_icon = addIcon('Last_icon.png');
  static final String next_icon = addIcon('Next.png');
  static final String prev_icon = addIcon('Prev.png');

  //------------------------------- svg ---------------------------------------
  // 'assets/svg/pause.svg'
  static final String pauseSvg = addSvg('pause.svg');
  // 'assets/svg/water_drop.svg'
  static final String waterDropSvg = addSvg('water_drop.svg');
  //------------------------------- images ---------------------------------------

  static final String login_illustration_image =
      addImage('login_illustration_image.png');
  static final String person_illustration_image =
      addImage('person_illustration_image.png');
  static final String service_image = addImage('product_image.png');
  static final String profile_image = addImage('profile_image.png');
}
