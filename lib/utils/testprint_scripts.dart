// Future<void> connectSocket(BuildContext context) async{
//   if(selectedPosDevice.isNotEmpty){
//     isPOSDeviceConnected = await _socketManager.connect(selectedPosDevice, 9999);  // Replace with your POS IP and Port
//     notifyListeners();
//     try{
//       _socketManager.socket!.listen(_onDataReceived);
//     }catch(e){
//       PrintLogs.printLog("Exception: $e");
//     }
//   }else{
//     // AppAlerts.showSnackBar(context, AppStrings.appName, 'Please select the pos device first.',statusCode: 1);
//     // AppNavigation.navigateToDiscoverPrinterScreen(context);
//     }
//   }
//
// void _onDataReceived(Uint8List data) {
//   String buffer = '';
//   String response = String.fromCharCodes(data);
//
//   // Append the new data to the buffer
//   buffer += response;
//
//   // Check if the buffer contains the complete message (e.g., by checking for an XML closing tag)
//   if (buffer.contains('</madaTransactionResult>')) {
//     // Process the complete message
//     PrintLogs.printLog('Received from POS: $buffer');
//     // Parse XML
//     _parseXmlResponse(buffer);
//   }
// }
// void _parseXmlResponse(String response) {
//   var context = NavigationService.navigatorKey.currentState!.context;
//   try {
//     final document = xml.XmlDocument.parse(response);
//     final terminalStatusCodeElement = document.findAllElements('TerminalStatusCode').first;
//
//     // Extract the value of TerminalStatusCode
//     final terminalStatusCode = terminalStatusCodeElement.value;
//     PrintLogs.printLog('TerminalStatusCode: $terminalStatusCode');
//     if(terminalStatusCode == '00'){
//       AppAlerts.showSnackBar(context, AppStrings.appName, 'Payment done successfully.');
//     }else{
//       AppAlerts.showSnackBar(context, AppStrings.appName, 'Payment declined.',statusCode: 1);
//     }
//   } catch (e) {
//     PrintLogs.printLog('Error parsing XML response: $e');
//   }
// }
//
// void sendAmountToPosDevice(BuildContext context) async{
//   PrintLogs.printLog("isPOSDeviceConnected : $isPOSDeviceConnected");
//   if (isPOSDeviceConnected) {
//    try{
//      String tempPrice = total.replaceAll(RegExp(r'\.0+$'), '');
//      String formattedPrice = (double.parse(tempPrice) * 100).toInt().toString().padLeft(12, '0');
//      _socketManager.sendPrice("\u{02}05018\u{02}  "+"$formattedPrice'\u{0001}\u{03}2");  // Send the price formatted as a string
//    }catch(e){
//      PrintLogs.printLog("sendPrice exception : $e");
//    }
//   }else{
//     AppAlerts.showSnackBar(context, AppStrings.appName, 'Please select the pos device first.',statusCode: 1);
//     AppNavigation.navigateToDiscoverPrinterScreen(context,isPosSelection: true);
//   }
// }
///---------------------- test print -------------

//   Future<void> printTestReceipt(FinalOrderModel finalOrderModel) async {
//     try {
//       var homeProvider = Provider.of<HomeProvider>(NavigationService.navigatorKey.currentState!.context,listen: false);
//       final DateTime now = DateTime.now();
//       final String formattedDate = DateFormat('yyyy/MM/dd HH:mm:ss').format(now);
//
//       // Load and decode the image
//       final ByteData data = await rootBundle.load(AppAssets.freshHouseLogoBW);
//       final Uint8List bytes = data.buffer.asUint8List();
//       String base64Image = base64Encode(bytes);
//
//       StringBuffer xmlBuffer = StringBuffer();
//
//       xmlBuffer.write('''
// <?xml version="1.0" encoding="utf-8"?>
// <PrintRequestInfo>
//   <ew:ewPosPrint xmlns:ew="http://www.epson-pos.com/schemas/2011/03/eposprint">
//     <ew:Image width="250" height="auto" format="PNG" align="center">$base64Image</ew:Image>
//     <ew:Text align="center">
//       <![CDATA[
//         It is all about FRESHNESS
//         ${finalOrderModel.receipt.first.branchName}
//         Simplified Tax Invoice - ${capitalize(finalOrderModel.receipt.first.status)}
//         Order# ${finalOrderModel.receipt.first.orderId}
//         Printed At: $formattedDate
//       ]]>
//     </ew:Text>
//     <ew:Text align="left">
//       <![CDATA[
//         Customer: ${finalOrderModel.receipt.first.customer}
//         Served by: ${finalOrderModel.receipt.first.servedBy}
//         ----------------------------------------------
//       ]]>
//     </ew:Text>
//     <ew:Text align="left">
//       <![CDATA[
//         Qty       Item                            Price
//         ----------------------------------------------
//     ''');
//
//       for (var element in finalOrderModel.receipt.first.product) {
//         xmlBuffer.write('''
//         ${element.quantity}      ${"${element.name}\n${element.nameAr}"}                 ${element.price} SR
//       ''');
//       }
//
//       xmlBuffer.write('''
//         ----------------------------------------------
//         Subtotal:                            ${finalOrderModel.receipt.first.subtotal} SR
//         المجموع الفرعي
//         15% Sales VAT:                       ${finalOrderModel.receipt.first.vat} SR
//         ----------------------------------------------
//         Total:                               ${finalOrderModel.receipt.first.total} SR
//         المجموع
//     ''');
//
//       if (finalOrderModel.receipt.first.paymentMethods.isNotEmpty) {
//         for (var element in finalOrderModel.receipt.first.paymentMethods) {
//           xmlBuffer.write('''
//           ${element.name}                         ${element.payment} SR
//         ''');
//         }
//         xmlBuffer.write('----------------------------------------------');
//       }
//
//       xmlBuffer.write('''
//         Product Count ${finalOrderModel.receipt.first.productsCount}
//         ----------------------------------------------
//     ''');
//
//       xmlBuffer.write('''
//         Previous Freshii: ${finalOrderModel.receipt.first.previousFreshi}
//         Total Earned Freshii: ${finalOrderModel.receipt.first.earnedFreshi}
//         Total Freshii: ${finalOrderModel.receipt.first.totalFreshi}
//         ${homeProvider.configDetails.receiptFooter}
//         VAT # ${finalOrderModel.receipt.first.vatNumber}
//       ]]>
//     </ew:Text>
//     <ew:QRCode>${finalOrderModel.receipt.first.orderId}</ew:QRCode>
//     <ew:Feed />
//     <ew:Cut type="feed" />
//   </ew:ewPosPrint>
// </PrintRequestInfo>
// ''');
//
//       final String printerUrl = 'http://${selectedDevice.toString()}:80/cgi-bin/epos/service.cgi?devid=local_printer&timeout=10000';
//
//       var result = await ApiManager.post(printerUrl, xmlBuffer.toString());
//       updateOrderCreateLoader(false);
//       PrintLogs.printLog("result api call line 1311: $result");
//
//       // if (response.statusCode == 200) {
//       //   print('Print job sent successfully');
//       // } else {
//       //   print('Failed to send print job: ${response.statusCode}');
//       //   print('Response: ${response.body}');
//       // }
//     } catch (e) {
//       PrintLogs.printLog('Exception: $e');
//     }
//   }

// String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
