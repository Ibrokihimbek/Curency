import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:valyuta_kursi/models/valyuta_kurs_model.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Future<List<Valyuta_Kurs>?>? getResult;

  Future<List<Valyuta_Kurs>> getData() async {
    String url = "https://nbu.uz/uz/exchange-rates/json/";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List json = jsonDecode(response.body) as List;
      List<Valyuta_Kurs> valyuta =
          json.map((e) => Valyuta_Kurs.froJson(e)).toList();
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
      body: FutureBuilder<List<Valyuta_Kurs>?>(
        future: getResult,
        builder: (BuildContext context,
            AsyncSnapshot<List<Valyuta_Kurs>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            List<Valyuta_Kurs?>? valyuta = snapshot.data;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: valyuta?.length ?? 0,
              itemBuilder: (context, index) {
                if (valyuta?[index]?.nbu_buy_price?.isEmpty == false)
                  return ValyutaWidget(valyuta?[index]);
                return Container();
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget ValyutaWidget(valyuta) {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Container(
        width: double.infinity,
        height: 160,
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
              children: [
                SizedBox(width: 16.w),
                Container(
                  width: 60.w,
                  height: 30.w,
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
                SizedBox(width: 50.w),
                Text(
                  valyuta?.date ?? '',
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                SizedBox(width: 70.w),
                const Icon(
                  Icons.notifications_active_outlined,
                  size: 25,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
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
