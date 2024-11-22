import 'package:email_campaign_app/views/view_details/view_from_details.dart';
import 'package:email_campaign_app/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> with TickerProviderStateMixin {
  late AnimationController _controllerDetails;
  late AnimationController _controllerSidebar;
  late Animation<Offset> _slideAnimationDetails;
  late Animation<Offset> _slideAnimationSidebar;

  @override
  void initState() {
    super.initState();

    _controllerDetails = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _controllerSidebar = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _slideAnimationDetails = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controllerDetails, curve: Curves.easeInOut),
    );

    _slideAnimationSidebar = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controllerSidebar, curve: Curves.easeInOut),
    );

    _controllerDetails.forward();
    _controllerSidebar.forward();
  }

  @override
  void dispose() {
    _controllerDetails.dispose();
    _controllerSidebar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isDesktopSize = MediaQuery.of(context).size.width > 1024;
          if (isDesktopSize) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                    vertical: 16 * 2, horizontal: 16 * 15),
                child: Row(
                  children: [
                    Expanded(
                      child: SlideTransition(
                        position: _slideAnimationDetails,
                        child: ViewFromDetails(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    SlideTransition(
                      position: _slideAnimationSidebar,
                      child: const Sidebar(),
                    ),
                  ],
                ),
              ),
            );
          }
          return Expanded(
            child: SlideTransition(
              position: _slideAnimationDetails,
              child: ViewFromDetails(),
            ),
          );
        },
      ),
    );
  }
}
