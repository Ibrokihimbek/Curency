import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:valyuta_kursi/models/valyuta_kurs_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<ValyutaKurs>?>? getResult;

  Future<List<ValyutaKurs>> getData() async {
    String url = "https://nbu.uz/uz/exchange-rates/json/";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List json = jsonDecode(response.body) as List;
      List<ValyutaKurs> valyuta =
          json.map((e) => ValyutaKurs.froJson(e)).toList();
      return valyuta;
    }

    return List.empty();
  }

  @override
  void initState() {
    super.initState();

    getResult = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Valyuta kursi',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder<List<ValyutaKurs>?>(
        future: getResult,
        builder:
            (BuildContext context, AsyncSnapshot<List<ValyutaKurs>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    '''Hatolik yuz berdi internetni tekshirib ko'rib
            yangilash tugmasini bosing''',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 20.r),
                InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      setState(() {
                        getResult = getData();
                      });
                    },
                    child: Container(
                      width: 120.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 101, 181, 247),
                            Color.fromARGB(255, 28, 28, 223),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Yangilash',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
              ],
            );
          }
          if (snapshot.hasData) {
            List<ValyutaKurs?>? valyuta = snapshot.data;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: valyuta?.length ?? 0,
              itemBuilder: (context, index) {
                if (valyuta?[index]?.nbu_buy_price?.isEmpty == false){
                  return ValyutaWidget(valyuta?[index]);
                }
                return Container();
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ValyutaWidget(valyuta) {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Container(
        width: double.infinity.w,
        height: 160.h,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16).r,
                      width: 60.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://countryflagsapi.com/png/${valyuta?.code.toString().substring(0, 2)}"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      valyuta?.code ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ],
                ),
                Text(
                  valyuta?.date ?? '',
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16).r,
                  child: const Icon(
                    Icons.notifications_active_outlined,
                    size: 25,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Narx',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(
                    'Sotib olish',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Text(
                    'Sotish',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    valyuta?.cb_price ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Text(
                    valyuta?.nbu_buy_price ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Text(
                    valyuta?.nbu_cell_price ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
