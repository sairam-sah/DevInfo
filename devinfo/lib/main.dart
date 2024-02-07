import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'deviceinfo1.dart';

void main()=>runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DevInfo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final DeviceInfoPlugin deviceInfoPlugin =DeviceInfoPlugin();
  Map<String,dynamic>_deviceData=<String,dynamic>{};
  // late String androidDeviceInfo;


  @override
  void initState(){
    initPlatformState();
    super.initState();
    // fetchDeviceDetails();
    }

      FutureOr<void>initPlatformState()async{
      var deviceData =<String,dynamic>{};

      try{
        if(Platform.isAndroid){
        deviceData= _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        }else if(Platform.isIOS){
          deviceData= _readIosBuildData(await deviceInfoPlugin.iosInfo);
        }
      } on PlatformException{
        deviceData=<String,dynamic>{'Error':'Faild to get platform version'};
      }

      if(!mounted)return;

      setState(() {
        _deviceData=deviceData;
      });

    }


    Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

    Map<String, dynamic> _readIosBuildData(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
    
    @override
    Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Device Info '),
              centerTitle: true,
              bottom: const TabBar(tabs: [
                Tab(
                  text: 'Android',
                ),
                Tab(
                  text: 'Internal',
                ),
              ]),
            ),
            body:TabBarView(
              children:[
                DeviceInfo(deviceInfoPlugin: _deviceData['androidDeviceInfo'], deviceInfo: '',),
                // DeviceInfo(deviceInfoPlugin: _deviceData['IosDeviceInfo']),
              ]
              
            )
            ),
            );
            
  }
  }
