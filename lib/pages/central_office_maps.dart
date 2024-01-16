import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/utils.dart';

class CentralOfficeMaps extends StatefulWidget {
  const CentralOfficeMaps({super.key});

  @override
  State<CentralOfficeMaps> createState() => _CentralOfficeMapsState();
}

class _CentralOfficeMapsState extends State<CentralOfficeMaps> {
  String valTelkom = 'Telkom Turangga - Telkom Cijawura';

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            fit: BoxFit.cover,
            height: double.maxFinite,
            width: double.maxFinite,
          ),
          SafeArea(
              child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/LOGO.png',
                      height: 50,
                    ),
                    const Text(
                      'Central Office Maps',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'CENTRAL OFFICE :',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButton(
                  hint: Text("Select Status"),
                  underline: SizedBox(),
                  isExpanded: true,
                  value: valTelkom,
                  items: Utils.data_telkom.map((value) {
                    return DropdownMenuItem(
                      child: Text(value['nama']),
                      value: value['nama'],
                    );
                  }).toList(),
                  onChanged: (value) {
                    for (var i = 0; i < Utils.data_telkom.length; i++) {
                      if (Utils.data_telkom[i]['nama'] == value.toString()) {
                        setState(() {
                          index = i;
                          valTelkom = value as String;
                        });
                      }
                    }
                    print('PRINT INDEX ${index}');
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Image.asset(
                  'assets/${Utils.data_telkom[index]['gambar']}',
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
