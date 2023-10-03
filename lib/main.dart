// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:d_maretti/service/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/statistic_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HisobotScreen(),
    );
  }
}

class HisobotScreen extends StatefulWidget {
  @override
  _HisobotScreenState createState() => _HisobotScreenState();
}

class _HisobotScreenState extends State<HisobotScreen> {
  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _dateBar() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2300),
      ).then((value) {
        setState(() {
          _selectedValue = value!;

          ApiService().getUser(DateFormat("dd-MM-yyyy").format(_selectedValue));
        });
      });
    }

    int naqd = 0;
    int plastik = 0;
    int chiqimNaqd = 0;
    int chiqimPlastik = 0;
    int haridorNaqd = 0;
    int haridorPlastik = 0;
    int vozvratNaqd = 0;
    int vozvratPlastik = 0;

    int kunlikSavdo = naqd + plastik + haridorNaqd + haridorPlastik;
    int kassaNaqd = naqd + haridorNaqd - vozvratNaqd - chiqimNaqd;
    int kassaPlastik =
        plastik + haridorPlastik - chiqimPlastik - vozvratPlastik;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff2B2937),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('D.MARETTI HISOBOT'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat("dd-MM-yyyy").format(_selectedValue),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(
                        () => _dateBar(),
                      ),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: const Color(0xFF394165),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        width: 122,
                        height: 40,
                        child: const Center(
                            child: Text(
                          "Vaqtni tanlang",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<HisobotModel>(
                future: ApiService()
                    .getUser(DateFormat("dd-MM-yyyy").format(_selectedValue)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                      child: Text("Internetga ulanishni tekshiring !!!"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('No data available');
                  } else {
                    final user = snapshot.data;

                    naqd = int.parse(user!.naqd);
                    plastik = int.parse(user.plastik);
                    chiqimNaqd = int.parse(user.chiqimNaqd);
                    chiqimPlastik = int.parse(user.chiqimPlastik);
                    haridorNaqd = int.parse(user.haridorNaqd);
                    haridorPlastik = int.parse(user.haridorPlastik);
                    vozvratNaqd = int.parse(user.vozvratNaqd);
                    vozvratPlastik = int.parse(user.vozvratPlastik);

                    return Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            margin: EdgeInsets.only(top: 12, bottom: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Savdodan tushum',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Naqd',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      naqd.toString(),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Plastik',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      plastik.toString(),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    width: 266,
                                    height: 4,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Undurilgan qarzdorlik',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Naqd',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    haridorNaqd.toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Plastik',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    haridorPlastik.toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Container(
                                  width: 266,
                                  height: 4,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Qaytarilgan tovarlar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Naqd',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    vozvratNaqd.toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Plastik',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    vozvratPlastik.toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Container(
                                  width: 266,
                                  height: 4,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Chiqimlar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Naqd',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    chiqimNaqd.toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Plastik',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    chiqimPlastik.toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Container(
                                  width: 266,
                                  height: 4,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Bugungi savdo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Text(
                                kunlikSavdo.toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              width: 266,
                              height: 4,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Kassa',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Naqd',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    chiqimNaqd.toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Plastik',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    chiqimPlastik.toString(),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Container(
                                  width: 266,
                                  height: 4,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );

                    //   SizedBox(
                    //   width: 371,
                    //   height: 842,
                    //   child: Stack(
                    //     children: [
                    //       const Positioned(
                    //         left: 2,
                    //         top: 163,
                    //         child: Text(
                    //           'Undirilgan qarzdorlik',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 3,
                    //         top: 326,
                    //         child: Text(
                    //           'Qaytarilgan tovarlar',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 2,
                    //         top: 489,
                    //         child: Text(
                    //           'Chiqimlar',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 2,
                    //         top: 201,
                    //         child: Text(
                    //           'Naqd',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 3,
                    //         top: 364,
                    //         child: Text(
                    //           'Naqd',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 2,
                    //         top: 527,
                    //         child: Text(
                    //           'Naqd',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 2,
                    //         top: 652,
                    //         child: Text(
                    //           'Kunlik savdo',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 4,
                    //         top: 739,
                    //         child: Text(
                    //           'Kassa',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 2,
                    //         top: 777,
                    //         child: Text(
                    //           'Naqd',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 4,
                    //         top: 815,
                    //         child: Text(
                    //           'Plastik',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 1,
                    //         top: 239,
                    //         child: Text(
                    //           'Plastik',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 2,
                    //         top: 402,
                    //         child: Text(
                    //           'Plastik',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       const Positioned(
                    //         left: 1,
                    //         top: 565,
                    //         child: Text(
                    //           'Plastik',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 341,
                    //         top: 201,
                    //         child: Text(
                    //           haridorNaqd.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 342,
                    //         top: 364,
                    //         child: Text(
                    //           vozvratNaqd.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 341,
                    //         top: 527,
                    //         child: Text(
                    //           chiqimNaqd.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 341,
                    //         top: 652,
                    //         child: Text(
                    //           kunlikSavdo.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 341,
                    //         top: 777,
                    //         child: Text(
                    //           kassaNaqd.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 343,
                    //         top: 815,
                    //         child: Text(
                    //           kassaPlastik.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 342,
                    //         top: 239,
                    //         child: Text(
                    //           haridorPlastik.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 343,
                    //         top: 402,
                    //         child: Text(
                    //           vozvratPlastik.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 342,
                    //         top: 565,
                    //         child: Text(
                    //           chiqimPlastik.toString(),
                    //           textAlign: TextAlign.right,
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 22,
                    //             fontFamily: 'Inter',
                    //             fontWeight: FontWeight.w400,
                    //             height: 0,
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 0,
                    //         top: 0,
                    //         child: SizedBox(
                    //           width: 369,
                    //           height: 135,
                    //           child: Stack(
                    //             children: [
                    //               const Positioned(
                    //                 left: 1,
                    //                 top: 0,
                    //                 child: Text(
                    //                   'Savdodan tushum',
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 22,
                    //                     fontFamily: 'Inter',
                    //                     fontWeight: FontWeight.w400,
                    //                     height: 0,
                    //                   ),
                    //                 ),
                    //               ),
                    //               const Positioned(
                    //                 left: 1,
                    //                 top: 38,
                    //                 child: Text(
                    //                   'Naqd',
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 22,
                    //                     fontFamily: 'Inter',
                    //                     fontWeight: FontWeight.w400,
                    //                     height: 0,
                    //                   ),
                    //                 ),
                    //               ),
                    //               const Positioned(
                    //                 left: 0,
                    //                 top: 76,
                    //                 child: Text(
                    //                   'Plastik',
                    //                   style: TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 22,
                    //                     fontFamily: 'Inter',
                    //                     fontWeight: FontWeight.w400,
                    //                     height: 0,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Positioned(
                    //                 left: 340,
                    //                 top: 38,
                    //                 child: Text(
                    //                   naqd.toString(),
                    //                   textAlign: TextAlign.right,
                    //                   style: const TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 22,
                    //                     fontFamily: 'Inter',
                    //                     fontWeight: FontWeight.w400,
                    //                     height: 0,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Positioned(
                    //                 left: 341,
                    //                 top: 76,
                    //                 child: Text(
                    //                   plastik.toString(),
                    //                   textAlign: TextAlign.right,
                    //                   style: const TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 22,
                    //                     fontFamily: 'Inter',
                    //                     fontWeight: FontWeight.w400,
                    //                     height: 0,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Positioned(
                    //                 left: 69,
                    //                 top: 131,
                    //                 child: Container(
                    //                   width: 266,
                    //                   height: 4,
                    //                   decoration: ShapeDecoration(
                    //                     color: const Color(0xFFD9D9D9),
                    //                     shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(4)),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 70,
                    //         top: 294,
                    //         child: Container(
                    //           width: 266,
                    //           height: 4,
                    //           decoration: ShapeDecoration(
                    //             color: const Color(0xFFD9D9D9),
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(4)),
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 71,
                    //         top: 457,
                    //         child: Container(
                    //           width: 266,
                    //           height: 4,
                    //           decoration: ShapeDecoration(
                    //             color: const Color(0xFFD9D9D9),
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(4)),
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 70,
                    //         top: 620,
                    //         child: Container(
                    //           width: 266,
                    //           height: 4,
                    //           decoration: ShapeDecoration(
                    //             color: const Color(0xFFD9D9D9),
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(4)),
                    //           ),
                    //         ),
                    //       ),
                    //       Positioned(
                    //         left: 72,
                    //         top: 707,
                    //         child: Container(
                    //           width: 266,
                    //           height: 4,
                    //           decoration: ShapeDecoration(
                    //             color: const Color(0xFFD9D9D9),
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(4)),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
