import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () => Get.offAllNamed('home-page'));
  }

  @override
  Widget build(BuildContext context) {
    double gWidth = context.width / 1.8;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Stack(
          children: [

            Positioned(
              left: -1,
              right: -2,
              bottom: 0,
              child: CustomPaint(
                size: Size(context.width, context.height / 1.9),
                painter: RPSCustomPainter1(),
              ),
            ),
            Positioned(
              left: -2,
              right: -2,
              bottom: -2,
              child: CustomPaint(
                size: Size(context.width, context.height / 2.0),
                painter: RPSCustomPainter2(),
              ),
            ),
            
            Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: gWidth / 1,
                        width: gWidth,
                        // padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                            'assets/images/screening-logo-transparan.png'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Selamat mencoba aplikasi kami',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 25,
                  ),
                  child: Text(
                    'PAIN DRE Innovation',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter2 extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  // Layer 1
  Paint paintFill0 = Paint()
      ..color = Colors.blue[900]!
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.5714286);
    path_0.lineTo(size.width*0.0008333,size.height*1.0014286);
    path_0.lineTo(size.width,size.height*0.9985714);
    path_0.lineTo(size.width*0.9991667,size.height*0.0080286);
    path_0.quadraticBezierTo(size.width*0.7377083,size.height*0.0650000,size.width*0.5008333,size.height*0.3328571);
    path_0.quadraticBezierTo(size.width*0.2912500,size.height*0.6289286,0,size.height*0.5714286);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);
  

  // Layer 1
  Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}

class RPSCustomPainter1 extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  // Layer 1
  
  Paint paintFill0 = Paint()
      ..color = Colors.amber[600]!
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.5714286);
    path_0.lineTo(size.width*0.0008333,size.height*1.0014286);
    path_0.lineTo(size.width,size.height*0.9985714);
    path_0.lineTo(size.width*0.9995667,size.height*0.0000286);
    path_0.quadraticBezierTo(size.width*0.7477083,size.height*0.0850000,size.width*0.5198533,size.height*0.3488571);
    path_0.quadraticBezierTo(size.width*0.2916500,size.height*0.6289286,0,size.height*0.5224286);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);
  

  // Layer 1
  
  Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
    
    canvas.drawPath(path_0, paintStroke0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}