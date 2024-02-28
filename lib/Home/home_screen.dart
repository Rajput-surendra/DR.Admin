import 'dart:convert';
import 'dart:developer';
import 'package:doctoradmin/Authentification/LoginScreen.dart';
import 'package:doctoradmin/Helper/Color.dart';
import 'package:doctoradmin/api/model/accept_reject_data_response.dart';
import 'package:doctoradmin/utils/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.name}) : super(key: key);
  final String? name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int selectedSegmentVal = 0;

  GetAcceptRejectData? getAcceptRejectData;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.name != null) {
      setSegmentValue(int.parse(widget.name!));
    }
    print('__________${widget.name}_____________');

    getAcceptRejectDataList();
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future _refresh() {
    return callApi();
  }

  Future callApi() async {
    getAcceptRejectDataList();
  }

  bool _canPop = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: WillPopScope(
        onWillPop: () async {
          if (_canPop) {
            return true;
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Doctor Admin"),
                content: Text("Are you sure you want to exit?"),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic)),
                    onPressed: () {
                      setState(() {
                        _canPop = true;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Yes"),
                  ),
                ],
              ),
            );
            return false;
          }
        },
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.95),
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Sign out"),
                          content: Text("Are  sure to sign out from app now?"),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: colors.primary),
                              child: Text("YES"),
                              onPressed: () async {
                                SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                prefs.clear();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: colors.primary),
                              child: Text("NO"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
                child: const Icon(Icons.logout),
              ),
              centerTitle: true,
              backgroundColor: colors.primary,
              actions: const [],
              title: const Text('Dashboard'),
            ),
            body: getAcceptRejectData == null
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  _segmentButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  getAcceptRejectData == null
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : selectedSegmentVal == 0
                      ? listData0()
                      : selectedSegmentVal == 1
                      ? listData1()
                      : selectedSegmentVal == 2
                      ? listData2()
                      : selectedSegmentVal == 3
                      ? listData3()
                      : selectedSegmentVal == 4
                      ? listData4()
                      : selectedSegmentVal == 5
                      ? listData5()
                      : selectedSegmentVal == 6
                      ? listData6()
                      : listData7()
                ],
              ),
            )),
      ),
    );
  }

  Widget listData0() {
    return getAcceptRejectData?.data?.news?.isEmpty ?? false
        ? Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: Text(
            'No news available',
          ),
        )
      ],
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: getAcceptRejectData?.data?.news?.length,
      itemBuilder: (context, index) {
        var item = getAcceptRejectData?.data?.news?[index];
        return card0(item, index);
      },
    );
  }

  Widget listData1() {
    return getAcceptRejectData?.data?.webinar?.isEmpty ?? false
        ? Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: Text(
            'No webinar available',
          ),
        )
      ],
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20),
      itemCount: getAcceptRejectData?.data?.webinar?.length,
      itemBuilder: (context, index) {
        var data = getAcceptRejectData?.data?.webinar?[index];
        return card1(data, index);
      },
    );
  }

  Widget listData2() {
    return getAcceptRejectData?.data?.event?.isEmpty ?? false
        ? Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: Text(
            'No event available',
          ),
        )
      ],
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20),
      itemCount: getAcceptRejectData?.data?.event?.length,
      itemBuilder: (context, index) {
        var data = getAcceptRejectData?.data?.event?[index];
        return card2(data, index);
      },
    );
  }

  Widget listData3() {
    return getAcceptRejectData?.data?.editorial?.isEmpty ?? false
        ? Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: Text(
            'No editorial available',
          ),
        )
      ],
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20),
      itemCount: getAcceptRejectData?.data?.editorial?.length,
      itemBuilder: (context, index) {
        var data = getAcceptRejectData?.data?.editorial?[index];
        return card3(data, index);
      },
    );
  }

  Widget listData4() {
    return getAcceptRejectData?.data?.awareness?.isEmpty ?? false
        ? Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: Text(
            'No awareness available',
          ),
        )
      ],
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20),
      itemCount: getAcceptRejectData?.data?.awareness?.length,
      itemBuilder: (context, index) {
        var data = getAcceptRejectData?.data?.awareness?[index];
        return card4(data, index);
      },
    );
  }

  Widget listData5() {
    return getAcceptRejectData?.data?.products?.isEmpty ?? false
        ? Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: Text(
            'No products available',
          ),
        )
      ],
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: getAcceptRejectData?.data?.products?.length,
      padding: EdgeInsets.only(bottom: 20),
      itemBuilder: (context, index) {
        var data = getAcceptRejectData?.data?.products?[index];
        print(
            '__________${getAcceptRejectData?.data?.products?.length}_____________');
        return card5(data, index);
      },
    );
  }

  Widget listData6() {
    return getAcceptRejectData?.data?.doctor?.isEmpty ?? false
        ? Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: Text(
            'No doctor available',
          ),
        )
      ],
    )
        : ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20),
      itemCount: getAcceptRejectData?.data?.doctor?.length,
      itemBuilder: (context, index) {
        Doctor? data = getAcceptRejectData?.data?.doctor?[index];
        print(
            '__________${getAcceptRejectData?.data?.doctor?.length}_____________');
        return card6(data, index);
      },
    );
  }

  Widget listData7() {
    return getAcceptRejectData?.data?.pharma?.isEmpty ?? false
        ? Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        const Center(
          child: Text(
            'No pharma available',
          ),
        )
      ],
    )
        : ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: getAcceptRejectData?.data?.pharma?.length,
      itemBuilder: (context, index) {
        Pharma? data = getAcceptRejectData?.data?.pharma?[index];
        print(
            '__________${getAcceptRejectData?.data?.pharma?.length}_____________');
        return card7(data, index);
      },
    );
  }

  Widget _segmentButton() => Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: Colors.white,
    ),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Container(
          //   height: 30,
          //   width: 70,
          //   decoration: ShapeDecoration(
          //       shape: const StadiumBorder(),
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: selectedSegmentVal == 0
          //               ? [colors.primary, colors.primary]
          //               : [Colors.transparent, Colors.transparent])),
          //   child: MaterialButton(
          //     shape: const StadiumBorder(),
          //     onPressed: () => setSegmentValue(0),
          //     child: Text(
          //       'News',
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14,
          //           color: selectedSegmentVal == 0
          //               ? Colors.white
          //               : Colors.black),
          //     ),
          //   ),
          // ),
          Container(
            height: 30,
            width: 90,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 1
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(1),
              child: Text(
                'Webinar',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 1
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 70,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 2
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(2),
              child: Text(
                'Event',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 2
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          // Container(
          //   height: 30,
          //   width: 85,
          //   decoration: ShapeDecoration(
          //       shape: const StadiumBorder(),
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: selectedSegmentVal == 3
          //               ? [colors.primary, colors.primary]
          //               : [Colors.transparent, Colors.transparent])),
          //   child: MaterialButton(
          //     shape: const StadiumBorder(),
          //     onPressed: () => setSegmentValue(3),
          //     child: Text(
          //       'Editorial',
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14,
          //           color: selectedSegmentVal == 3
          //               ? Colors.white
          //               : Colors.black),
          //     ),
          //   ),
          // ),
          Container(
            height: 30,
            width: 110,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 4
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(4),
              child: Text(
                'Awareness',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 4
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          // Container(
          //   height: 30,
          //   width: 110,
          //   decoration: ShapeDecoration(
          //       shape: const StadiumBorder(),
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: selectedSegmentVal == 5
          //               ? [colors.primary, colors.primary]
          //               : [Colors.transparent, Colors.transparent])),
          //   child: MaterialButton(
          //     shape: const StadiumBorder(),
          //     onPressed: () => setSegmentValue(5),
          //     child: Text(
          //       'Product',
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14,
          //           color: selectedSegmentVal == 5
          //               ? Colors.white
          //               : Colors.black),
          //     ),
          //   ),
          // ),
          Container(
            height: 30,
            width: 110,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 6
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(6),
              child: Text(
                'Doctor',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 6
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
          Container(
            height: 30,
            width: 110,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 7
                        ? [colors.primary, colors.primary]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(7),
              child: Text(
                'Pharma',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: selectedSegmentVal == 7
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  setSegmentValue(int i) {
    selectedSegmentVal = i;
    String status;
    if (i == 0) {
      status = 'Ongoing';
    } else if (i == 1) {
      status = 'Complete';
    }
    setState(() {
      getAcceptRejectDataList();
    });
    // getOrderList(status: status);
  }

  customTabbar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 0
                      ? colors.primary
                      : colors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              height: 65,
              width: MediaQuery.of(context).size.width / 3.3,
              child: const Center(
                child: Text("Doctor News"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    color: _currentIndex == 1
                        ? colors.primary
                        : colors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                // width: 120,
                height: 65,
                width: MediaQuery.of(context).size.width / 3.3,

                child: const Center(
                  child: Text("Product News"),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _currentIndex == 2
                      ? colors.primary
                      : colors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              // width: 120,
              height: 65,
              width: MediaQuery.of(context).size.width / 3.3,

              child: Center(
                child: Text("Pharma News"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget card0(data, int index) {
    final date = DateTime.parse(data.date ?? '2023-03-30 16:36:03');
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${data.name.toString().capitalizeFirst}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AppNetworkImage(
                        image: '${data.image ?? ''}',
                        height: 80,
                        width: 120,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${data.title ?? ''}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                        width: 180,
                        child: Text(
                          'By ${data.description}',
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF3E4095)),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Date: ${DateFormat('dd-MM-yyyy ').format(date)}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.news?[index].id
                                    .toString() ??
                                    '';
                                String status = '1';
                                String type = 'news';
                                if (getAcceptRejectData
                                    ?.data?.news?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                acceptData(id, status, type, userType);
                                getAcceptRejectData?.data?.news
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(
                                    Colors.green),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.news?[index].id
                                    .toString() ??
                                    '';
                                String status = '2';
                                String type = 'news';
                                if (getAcceptRejectData
                                    ?.data?.news?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                rejectData(id, status, type, userType);
                                getAcceptRejectData?.data?.news
                                    ?.removeAt(index);
                                setState(() {});
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red),
                              ),
                              child: const Text(
                                'Reject',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card1(data, int index) {
    print("${data.image.toString().split('.').last}");
    //final startDate = DateTime.parse(data.startDate ?? '2023-03-30 16:36:03');
    // final endtDate = DateTime.parse(data.startDate ?? '2023-03-30 16:36:03');

    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${data.name.toString().capitalizeFirst}',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (data.image.toString().split('.').last == 'pdf') {
                      await launchUrl(Uri.parse(data.image),
                          mode: LaunchMode.externalApplication);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return InteractiveViewer(
                            panEnabled: false, // Set it to false
                            boundaryMargin: EdgeInsets.all(100),
                            minScale: 0.5,
                            maxScale: 2,
                            child: Image.network(
                              '${data.image}',
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: data.image.toString().split('.').last == 'pdf'
                            ? Container(
                          height: 140,
                          width: 120,
                          child: Center(
                            child: Image.asset('assets/images/pdf.png'), // Replace 'your_image_file.png' with the actual path to your image asset
                          ),
                        )
                            : AppNetworkImage(
                          image: '${data.image}',
                          height: 140,
                          width: 120,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) {
                //         return InteractiveViewer(
                //           panEnabled: false, // Set it to false
                //           boundaryMargin: EdgeInsets.all(100),
                //           minScale: 0.5,
                //           maxScale: 2,
                //           child: Image.network(
                //             '${data.image}',
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.all(5.0),
                //     child: ClipRRect(
                //         borderRadius: BorderRadius.circular(10),
                //         child: AppNetworkImage(
                //           image: '${data.image}',
                //           height: 140,
                //           width: 120,
                //           fit: BoxFit.fill,
                //         )),
                //   ),
                // ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 180,
                        child: Text(
                          'Title: ${data.title}',
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    // const SizedBox(height: 5),
                    // SizedBox(
                    //     width: 180,
                    //     child: Text(
                    //       'By ${data.description}',
                    //       maxLines: 3,
                    //       style: const TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           color: Color(0XFF3E4095)),
                    //     )),
                    // const SizedBox(
                    //   height: 5,
                    // ),

                    const SizedBox(height: 5),
                    SizedBox(
                        width: 180,
                        child: Text(
                          'Topic: ${data.topic}',
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF3E4095)),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 180,
                        child: Text(
                          'Speaker: ${data.speaker}',
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF3E4095)),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 180,
                        child: Text(
                          'Moderator: ${data.moderator}',
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF3E4095)),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Date: ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${data.startDate}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0XFF3E4095)),
                        ),
                        /*Column(
                          children: [
                            const Text(
                              'End Date',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${data.endDate ?? '2023-04-08'}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0XFF3E4095)),
                            ),
                          ],
                        ),*/
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Time:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${data.fromTime}',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0XFF3E4095)),
                        ),
                        SizedBox(
                          width: 45,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     launchUrl(Uri.parse(data.link));
                    //   },
                    //   child: SizedBox(
                    //       width: 180,
                    //       child: Text(
                    //         'Link: ${data.link}',
                    //         maxLines: 3,
                    //         style: const TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w700,
                    //             color: Color(0XFF3E4095),
                    //             decoration: TextDecoration.underline),
                    //       )),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.webinar?[index].id
                                    .toString() ??
                                    '';
                                String status = '1';
                                String type = 'webinar';
                                if (getAcceptRejectData
                                    ?.data?.webinar?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                acceptData(id, status, type, userType);
                                getAcceptRejectData?.data?.webinar
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(
                                    Colors.green),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.webinar?[index].id
                                    .toString() ??
                                    '';
                                String status = '2';
                                String type = 'webinar';
                                if (getAcceptRejectData
                                    ?.data?.webinar?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                rejectData(id, status, type, userType);
                                getAcceptRejectData?.data?.webinar
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red),
                              ),
                              child: const Text(
                                'Reject',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card2(data, int index) {
    final date = DateTime.parse(data.date ?? '2023-03-30 16:36:03');

    print('__________${data.endDate}_____endDate________');
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${data.title.toString().capitalizeFirst} ${data.name.toString().capitalizeFirst}',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    if (data.image.toString().split('.').last == 'pdf') {
                      await launchUrl(Uri.parse(data.image),
                          mode: LaunchMode.externalApplication);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return InteractiveViewer(
                            panEnabled: false, // Set it to false
                            boundaryMargin: EdgeInsets.all(100),
                            minScale: 0.5,
                            maxScale: 2,
                            child: Image.network(
                              '${data.image}',
                            ),
                          );
                        },
                      );
                    }
                  },


                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: data.image.toString().split('.').last == 'pdf'
                            ? Container(
                          height: 140,
                          width: 120,
                          child: Center(
                            child: Image.asset('assets/images/pdf.png'), // Replace 'your_image_file.png' with the actual path to your image asset
                          ),
                        )
                            : AppNetworkImage(
                          image: '${data.image}',
                          height: 140,
                          width: 120,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 180,
                        child: Text(
                          'Title: ${data.title}',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),  SizedBox(
                        width: 180,
                        child: Text(
                          'Name: ${data.name}',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    /*const SizedBox(height: 5),
                      SizedBox(
                        width: 180,
                          child: Text('By ${data.description}',
                            maxLines: 3,
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color:Color(0XFF3E4095) ),)),*/
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: 180,
                        child: Text(
                          'Address: ${data.address}',
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Start Date',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${data.startDate}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0XFF3E4095)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            const Text(
                              'End Date',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${data.endDate}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0XFF3E4095)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     launchUrl(Uri.parse(data.link));
                    //   },
                    //   child: SizedBox(
                    //       width: 180,
                    //       child: Text(
                    //         'Link: ${data.link}',
                    //         maxLines: 3,
                    //         style: const TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w700,
                    //             color: Color(0XFF3E4095),
                    //             decoration: TextDecoration.underline),
                    //       )),
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Sponsored',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name:',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Designation: ',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            // Text(
                            //   'Mobile:  ',
                            //   style: const TextStyle(
                            //       fontSize: 12, fontWeight: FontWeight.w700),
                            // ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.name}',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${data.designation} ',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${data.mobile}',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.event?[index].id
                                    .toString() ??
                                    '';
                                String status = '1';
                                String type = 'event';
                                if (getAcceptRejectData
                                    ?.data?.event?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                acceptData(id, status, type, userType);
                                getAcceptRejectData?.data?.event
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(
                                    Colors.green),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.event?[index].id
                                    .toString() ??
                                    '';
                                String status = '2';
                                String type = 'event';
                                if (getAcceptRejectData
                                    ?.data?.event?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                rejectData(id, status, type, userType);
                                getAcceptRejectData?.data?.event
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red),
                              ),
                              child: const Text(
                                'Reject',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card3(data, int index) {
    final date = DateTime.parse(data.date ?? '2023-03-30 16:36:03');
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${data.name.toString().capitalizeFirst} ',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return InteractiveViewer(
                          panEnabled: false, // Set it to false
                          boundaryMargin: EdgeInsets.all(100),
                          minScale: 0.5,
                          maxScale: 2,
                          child: Image.network(
                            '${data.image}',
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AppNetworkImage(
                          image: '${data.image}',
                          height: 80,
                          width: 120,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title: ${data.title}',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'By ${data.description}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF3E4095)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Date: ${DateFormat('dd-MM-yyyy ').format(date)}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.editorial?[index].id
                                    .toString() ??
                                    '';
                                String status = '1';
                                String type = 'editorial';
                                if (getAcceptRejectData
                                    ?.data?.editorial?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                acceptData(id, status, type, userType);

                                getAcceptRejectData?.data?.editorial
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(
                                    Colors.green),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.editorial?[index].id
                                    .toString() ??
                                    '';
                                String status = '2';
                                String type = 'editorial';
                                if (getAcceptRejectData
                                    ?.data?.editorial?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }

                                rejectData(id, status, type, userType);
                                getAcceptRejectData?.data?.editorial
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red),
                              ),
                              child: const Text(
                                'Reject',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card4(data, int index) {
    final date = DateTime.parse(data.date ?? '2023-03-30 16:36:03');
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${data.name.toString().capitalizeFirst}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    if (data.image.toString().split('.').last == 'pdf') {
                      await launchUrl(Uri.parse(data.image),
                          mode: LaunchMode.externalApplication);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return InteractiveViewer(
                            panEnabled: false, // Set it to false
                            boundaryMargin: EdgeInsets.all(100),
                            minScale: 0.5,
                            maxScale: 2,
                            child: Image.network(
                              '${data.image}',
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: data.image.toString().split('.').last == 'pdf'
                            ? Container(
                          height: 140,
                          width: 120,
                          child: Center(
                            child: Image.asset('assets/images/pdf.png'), // Replace 'your_image_file.png' with the actual path to your image asset
                          ),
                        )
                            : AppNetworkImage(
                          image: '${data.image}',
                          height: 140,
                          width: 120,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 180,
                        child: Text(
                          'Awareness: ${data.title}',
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    const SizedBox(height: 5),
                    Text(
                      'Language: ${data.awareLanguage}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF3E4095)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Awareness Input: ${data.awareInput}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.awareness?[index].id
                                    .toString() ??
                                    '';
                                String status = '1';
                                String type = 'awareness';
                                if (getAcceptRejectData
                                    ?.data?.awareness?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                acceptData(id, status, type, userType);

                                getAcceptRejectData?.data?.awareness
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(
                                    Colors.green),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.awareness?[index].id
                                    .toString() ??
                                    '';
                                String status = '2';
                                String type = 'awareness';
                                if (getAcceptRejectData
                                    ?.data?.awareness?[index].pharmaId ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                acceptData(id, status, type, userType);
                                rejectData(id, status, type, userType);
                                getAcceptRejectData?.data?.awareness
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red),
                              ),
                              child: const Text(
                                'Reject',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card5(data, int index) {
    //final date = DateTime.parse(data.date ?? '2023-03-30 16:36:03');
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${data.name.toString().capitalizeFirst}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return InteractiveViewer(
                          panEnabled: false, // Set it to false
                          boundaryMargin: EdgeInsets.all(100),
                          minScale: 0.5,
                          maxScale: 2,
                          child: Image.network(
                            '${data.image}',
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AppNetworkImage(
                          image: '${data.image}',
                          height: 80,
                          width: 120,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 180,
                        child: Text(
                          'Title:${data.name}',
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )),
                    const SizedBox(height: 5),
                    Text(
                      'Description:${data.shortDescription}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF3E4095)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.products?[index].id
                                    .toString() ??
                                    '';
                                String status = '1';
                                String type = 'products';
                                if (getAcceptRejectData
                                    ?.data?.products?[index].id ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                acceptData(id, status, type, userType);

                                getAcceptRejectData?.data?.products
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(
                                    Colors.green),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 25,
                          child: ElevatedButton(
                              onPressed: () {
                                String? userType;
                                String id = getAcceptRejectData
                                    ?.data?.products?[index].id
                                    .toString() ??
                                    '';
                                String status = '2';
                                String type = 'products';
                                if (getAcceptRejectData
                                    ?.data?.products?[index].id ==
                                    null) {
                                  userType = '1';
                                } else {
                                  userType = '2';
                                }
                                acceptData(id, status, type, userType);
                                rejectData(id, status, type, userType);
                                getAcceptRejectData?.data?.products
                                    ?.removeAt(index);
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.red),
                              ),
                              child: const Text(
                                'Reject',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card6(Doctor? data, int index) {
    //final date = DateTime.parse(data.date ?? '2023-03-30 16:36:03');
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  data!.title.toString() == "null" || data!.title == null
                      ? Container()
                      : Text(
                    '${data!.title.toString().capitalizeFirst}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    '${data!.name.toString().capitalizeFirst}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // width: 180,
                          child: Text(
                            'Title: ${data.title}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )), SizedBox(
                        // width: 180,
                          child: Text(
                            'Name: ${data.name}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.docDigree == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'Doctor Degree: ${data.docDigree}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.mobile == null
                          ? Container()
                          : SizedBox(
                        // width: 180,
                          child: Text(
                            'Mobile No: ${data.mobile}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.email == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'Email Id: ${data.email}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.gender == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'Gender: ${data.gender}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.stateId == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'State: ${data.stateId}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.cityId == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'City: ${data.cityId}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.areaId == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'Area: ${data.areaId}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 25,
                            child: ElevatedButton(
                                onPressed: () {
                                  String? userType;
                                  String id = getAcceptRejectData
                                      ?.data?.doctor?[index].id
                                      .toString() ??
                                      '';
                                  String status = '1';
                                  String type = 'doctor';
                                  // if (getAcceptRejectData
                                  //         ?.data?.products?[index].id ==
                                  //     null) {
                                  userType = '1';
                                  // } else {
                                  //  userType = '2';
                                  // }
                                  acceptData(id, status, type, userType);

                                  getAcceptRejectData?.data?.doctor
                                      ?.removeAt(index);
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll<Color>(
                                      Colors.green),
                                ),
                                child: const Text(
                                  'Active',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 25,
                            child: ElevatedButton(
                                onPressed: () {
                                  String? userType;
                                  String id = getAcceptRejectData
                                      ?.data?.doctor?[index].id
                                      .toString() ??
                                      '';
                                  String status = '2';
                                  String type = 'doctor';
                                  // if (getAcceptRejectData
                                  //         ?.data?.products?[index].id ==
                                  //     null) {
                                  userType = '1';
                                  // } else {
                                  //   userType = '2';
                                  // }
                                  acceptData(id, status, type, userType);
                                  rejectData(id, status, type, userType);
                                  getAcceptRejectData?.data?.doctor
                                      ?.removeAt(index);
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll<Color>(
                                      Colors.red),
                                ),
                                child: const Text(
                                  'Deactive',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget card7(Pharma? data, int index) {
    //final date = DateTime.parse(data.date ?? '2023-03-30 16:36:03');
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
              height: 30,
              decoration: const BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(11),
                      topRight: Radius.circular(11))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  data!.title.toString() == "null" || data!.title == null
                      ? Container()
                      : Text(
                    '${data!.title.toString().capitalizeFirst}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    '${data!.name.toString().capitalizeFirst}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // width: 180,
                          child: Text(
                            'Title: ${data.title.toString().capitalizeFirst}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )), SizedBox(
                        // width: 180,
                          child: Text(
                            'Name: ${data.name.toString().capitalizeFirst}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      data.docDigree == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'Doctor Degree: ${data.docDigree}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.mobile == null
                          ? Container()
                          : SizedBox(
                        // width: 180,
                          child: Text(
                            'Mobile No: ${data.mobile}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.email == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'Email Id: ${data.email}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.gender == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'Gender: ${data.gender}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.stateId == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'State: ${data.stateId}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.cityId == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'City: ${data.cityId}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      data.areaId == null
                          ? Container()
                          : SizedBox(
                        //  width: 180,
                          child: Text(
                            'Area: ${data.areaId}',
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 25,
                            child: ElevatedButton(
                                onPressed: () {
                                  String? userType;
                                  String id = getAcceptRejectData
                                      ?.data?.pharma?[index].id
                                      .toString() ??
                                      '';
                                  String status = '1';
                                  String type = 'pharma';
                                  // if (getAcceptRejectData
                                  //         ?.data?.products?[index].id ==
                                  //     null) {
                                  userType = '1';
                                  // } else {
                                  //   userType = '2';
                                  // }
                                  acceptData(id, status, type, userType);

                                  getAcceptRejectData?.data?.pharma
                                      ?.removeAt(index);
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll<Color>(
                                      Colors.green),
                                ),
                                child: const Text(
                                  'Active',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 25,
                            child: ElevatedButton(
                                onPressed: () {
                                  String? userType;
                                  String id = getAcceptRejectData
                                      ?.data?.pharma?[index].id
                                      .toString() ??
                                      '';
                                  String status = '2';
                                  String type = 'pharma';
                                  // if (getAcceptRejectData
                                  //         ?.data?.products?[index].id ==
                                  //     null) {
                                  userType = '1';
                                  // } else {
                                  //   userType = '2';
                                  // }
                                  acceptData(id, status, type, userType);
                                  rejectData(id, status, type, userType);
                                  getAcceptRejectData?.data?.pharma
                                      ?.removeAt(index);
                                },
                                style: const ButtonStyle(
                                  backgroundColor:
                                  MaterialStatePropertyAll<Color>(
                                      Colors.red),
                                ),
                                child: const Text(
                                  'Deactive',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  rejectData(String id, String status, String type, String userType) async {
    setState(() {});
    var request = http.MultipartRequest('POST',
        Uri.parse('https://drplusapp.in/admin/app/v1/api/accept_reject'));
    request.fields.addAll(
        {'id': id, 'status': status, 'type': type, 'user_type': userType});

    print('__________${request.fields}_____________');
    print('__________${request.url}_____________');

    http.StreamedResponse response = await request.send();

    print('__________${response.statusCode}_____________');

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      Fluttertoast.showToast(
          msg: "Successfully Rejected ...!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Rejected ...!  ')));
      setState(() {});
    } else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  acceptData(String id, String status, String type, String userType) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://drplusapp.in/admin/app/v1/api/accept_reject'));
    request.fields.addAll(
        {'id': id, 'status': status, 'type': type, 'user_type': userType});
    print('parameter_________accept____${request.fields}');
    // print('__________${request.fields}_____________');
    print('__________${request.url}_____________');
    http.StreamedResponse response = await request.send();
    print('__________${response.statusCode}_____________');
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {});
      Fluttertoast.showToast(
          msg: "Successfully Accepted ...!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      // Fluttertoast.showToast(
      //
      //     msg: 'Successfully Accepted ...!');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Accepted ...!  ')));
    } else {
      print(response.reasonPhrase);
      setState(() {});
    }
  }

  getAcceptRejectDataList() async {
    var request = http.Request('GET',
        Uri.parse('https://drplusapp.in/admin/app/v1/api/inactive_lists'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final response2 = await response.stream.bytesToString();
      log('__________${response2}_____________');

      final finalResult = GetAcceptRejectData.fromJson(jsonDecode(response2));

      setState(() {
        getAcceptRejectData = finalResult;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {});
    }
  }
}

/*
SizedBox(
height: 50,
width: MediaQuery.of(context).size.width,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: <Widget>[
Expanded(
child: ListView.builder(
scrollDirection: Axis.horizontal,
physics: NeverScrollableScrollPhysics(),
itemCount: 4,
itemBuilder: (BuildContext context, int index) {
return Container(
width: MediaQuery.of(context).size.width/5.1,
height: 100,
color: Colors.blue,
margin: EdgeInsets.all(10),
);
},
),
),
],
),
)*/
