import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/app_barrel.dart';
import '../../global/ui/ui_barrel.dart';
import '../../global/ui/widgets/fields/custom_textfield.dart';
import 'shared.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [

          Ui.padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar("General Doctor",action: CircleIcon(Icons.search),),
                Ui.boxHeight(24),
                TitleSeeAll("Nearby Doctor"),
                Ui.boxHeight(12),
                ...List.generate(10, (i){
                  return DoctorInfo(false);
                })
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
      
            Ui.padding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("General Doctor",action: CircleIcon(Icons.search),),
                  Ui.boxHeight(24),
                  TitleSeeAll("Nearby Doctor"),
                  Ui.boxHeight(12),
                  ...List.generate(10, (i){
                    return DoctorInfo(false);
                  })
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}