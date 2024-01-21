import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SPMCalculator extends StatefulWidget {
  const SPMCalculator({super.key});

  @override
  State<SPMCalculator> createState() => _SPMCalculatorState();
}

class _SPMCalculatorState extends State<SPMCalculator> {
  bool isSubmit = false;

  var pocketLoss = TextEditingController();
  var throughput = TextEditingController();
  var latency = TextEditingController();
  var jitter = TextEditingController();
  var preventiveMain = TextEditingController();
  var maintenance = TextEditingController();
  var availability = TextEditingController();
  var capacity = TextEditingController();
  var ber = TextEditingController();

  var valuePerformance;
  var valueMaintenance;
  var valueSPM;
  var value_quality_of_service;

  void hitungPerformance(double pocketLoss, throughput, latency, jitter) {
    valuePerformance = (pocketLoss + throughput + latency + jitter) * 0.10;
  }

  void hitungMaintenance(double preventiveMain, maintenance) {
    valueMaintenance = preventiveMain + maintenance;
  }

  void hitungSPM() {
    valueSPM = (double.parse(availability.text) * 0.8) +
        (valuePerformance * 0.1) +
        (valueMaintenance * 0.1);

    if (valueSPM < 90.0) {
      value_quality_of_service = 'Bad';
    } else if (valueSPM > 90.0 && valueSPM < 100.0) {
      value_quality_of_service = 'Good';
    } else {
      value_quality_of_service = 'Good';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.png',
            height: double.maxFinite,
            width: 500,
            fit: BoxFit.cover,
          ),
          SafeArea(
              child: ListView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                      'SPM CALCULATOR',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'PERFORMANCE',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Pocket Loss',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                          Expanded(
                              flex: 4,
                              child: TextField(
                                controller: pocketLoss,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true, fillColor: Colors.white),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Throughput',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                          Expanded(
                              flex: 4,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: throughput,
                                decoration: InputDecoration(
                                    filled: true, fillColor: Colors.white),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Latency',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                          Expanded(
                              flex: 4,
                              child: TextField(
                                controller: latency,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true, fillColor: Colors.white),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Jitter',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                          Expanded(
                              flex: 4,
                              child: TextField(
                                controller: jitter,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true, fillColor: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'MAINTENANCE',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Preventive Maintenance',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                          Expanded(
                              flex: 4,
                              child: TextField(
                                controller: preventiveMain,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true, fillColor: Colors.white),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                'Maintenance',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                          Expanded(
                              flex: 4,
                              child: TextField(
                                controller: maintenance,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    filled: true, fillColor: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'AVAILABILITY',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: TextField(
                              controller: availability,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  filled: true, fillColor: Colors.white),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'CAPACITY',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: TextField(
                              controller: capacity,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  filled: true, fillColor: Colors.white),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'BIT ERROR RATE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                            flex: 5,
                            child: TextField(
                              controller: ber,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  filled: true, fillColor: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              isSubmit == true
                  ? Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'THE RESULT',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Performance',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    ': ${valuePerformance}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(flex: 1, child: Text('%')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Maintenance',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    ': ${valuePerformance}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(flex: 1, child: Text('%')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Availability',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    ': ${availability.text}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(flex: 1, child: Text('%')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Capacity',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    ': ${capacity.text}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(flex: 1, child: Text('Bytes')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'BER',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    ': ${ber.text}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Quality of Service',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    ': Good',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Data disimpan'),
                          backgroundColor: Colors.blue,
                        ));
                        addData();
                        setState(() {
                          isSubmit = true;
                        });
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                    ),
              SizedBox(
                height: 25,
              )
            ],
          ))
        ],
      ),
    );
  }

  Future addData() async {
    hitungMaintenance(
        double.parse(preventiveMain.text), double.parse(maintenance.text));
    hitungPerformance(
        double.parse(pocketLoss.text),
        double.parse(throughput.text),
        double.parse(latency.text),
        double.parse(jitter.text));
    final doc = FirebaseFirestore.instance
        .collection('DATA')
        .doc(DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()).toString());
    final data = Calculate(
        performance: valuePerformance.toString(),
        maintenance: valueMaintenance.toString(),
        availability: availability.text,
        capacity: capacity.text,
        ber: ber.text,
        user: FirebaseAuth.instance.currentUser!.email.toString(),
        quality_of_service: value_quality_of_service,
        datetime:
            DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()).toString());
    final json = data.toJson();
    await doc.set(json);
  }
}

class Calculate {
  var performance, maintenance, availability, capacity, ber;
  final String quality_of_service, datetime, user;

  Calculate(
      {required this.performance,
      required this.maintenance,
      required this.availability,
      required this.capacity,
      required this.ber,
      required this.quality_of_service,
      required this.user,
      required this.datetime});

  Map<String, dynamic> toJson() => {
        'performance': performance,
        'maintenance': maintenance,
        'availability': availability,
        'capacity': capacity,
        'ber': ber,
        'quality_of_service': quality_of_service,
        'datetime': datetime,
        'user': user
      };
}
