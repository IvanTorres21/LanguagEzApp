import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarWidget extends StatefulWidget {

  int currPage = 0;

  NavBarWidget(this.currPage);

  @override
  State<StatefulWidget> createState() {
    return NavBarState();
  }

}

class NavBarState extends State<NavBarWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: Color(0xFF3A53C2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon:SvgPicture.asset('assets/icons/home.svg'),
              color: Color(0xFFFAFAFA),
            onPressed: () {}
            ),
          IconButton(
              icon: SvgPicture.asset('assets/icons/graduation-hat.svg'),
              color: Color(0xFFFAFAFA),
              onPressed: () {}
          ),
          IconButton(
              icon: SvgPicture.asset('assets/icons/book.svg'),
              color: Color(0xFFFAFAFA),
              onPressed: () {}
          ),
          IconButton(
              icon: SvgPicture.asset('assets/icons/profile.svg'),
              color: Color(0xFFFAFAFA),
              onPressed: () {}
          )
        ],
      ),
    );
  }


}