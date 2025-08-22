
/*
    // ESC/POS commands to print a simple receipt
    //  String receipt = '';
    //
    //  receipt += '\x1B\x61\x01';
    //
    //  // Print shop name
    //  receipt += '${homeProvider.configDetails.receiptHeader}\n'; //Fresh House
    //
    //  // Encode the Arabic string to UTF-8
    // //  List<int> encodedBytes = utf8.encode(homeProvider.configDetails.receiptHeader);
    // // // Print the encoded bytes (for debugging purposes)
    // //  print(encodedBytes);
    // //  // Convert the list of bytes to a string representation
    // //  String encodedString = encodedBytes.join(',');
    // //  receipt += '$encodedString\n'; //Fresh House
    //
    //
    //
    //  // Set text alignment to left
    //  receipt += '\x1B\x61\x01';
    //
    //  // Print order details
    //  receipt += 'Order # ${finalOrderModel.receipt.first.orderId}\n';
    //  receipt += 'Customer: ${finalOrderModel.receipt.first.customer}\n';
    //  receipt += 'Served by: ${finalOrderModel.receipt.first.servedBy}\n';
    //
    //  receipt += '\x1B\x61\x00';
    //  // Print items
    //  receipt += '-----------------------------------------------\n';
    //  receipt += 'Qty   ${splitSentence('Item', 28)}    Price\n';
    //  receipt += '-----------------------------------------------\n';
    //  for (var element in finalOrderModel.receipt.first.product) {
    //    receipt += '${element.quantity}   ${splitSentence(element.name, 28)}    ${element.price} SR\n';
    //  }
    //
    //  // Print subtotal, tax, and total
    //  receipt += '-----------------------------------------------\n';
    //  receipt += '${splitSentence('Subtotal:', 37)} ${finalOrderModel.receipt.first.subtotal} SR\n';
    //  receipt += '${splitSentence('15% Sales VAT:', 37)} ${finalOrderModel.receipt.first.vat} SR\n';
    //  receipt += '${splitSentence('Total:', 37)} ${finalOrderModel.receipt.first.total} SR\n';
    //
    //  // Print payment method
    //  receipt += '-----------------------------------------------\n';
    //  var payment = '';
    //  for (var element in finalOrderModel.receipt.first.paymentMethods) {
    //    payment += '${splitSentence(element.name, 37)} ${element.payment} SR\n';
    //  }
    //  if(payment.isNotEmpty){
    //    receipt += payment;
    //    receipt += '-----------------------------------------------\n';
    //  }
    //  receipt += '\x1B\x61\x01';
    //  receipt += 'Product Count ${finalOrderModel.receipt.first.productsCount}\n';
    //  receipt += '-----------------------------------------------\n';
    //  // Print additional information
    //  if(!homeProvider.selectedSessionModel.isTableManagement){
    //    receipt += '\x1B\x61\x00';
    //    receipt += '${splitSentence('Previous Freshii:', 37)} ${finalOrderModel.receipt.first.previousFreshi}\n';
    //    receipt += '${splitSentence('Total Earned Freshii:', 37)} ${finalOrderModel.receipt.first.earnedFreshi}\n';
    //    receipt += '${splitSentence('Total Freshii:', 37)} ${finalOrderModel.receipt.first.totalFreshi}\n';
    //    receipt += '     \n';
    //  }
    //
    //  receipt += '\x1B\x61\x01';
    //  // Print website and VAT number
    //  receipt += '${homeProvider.configDetails.receiptFooter}\n'; //${finalOrderModel.receipt.first.url}
    //  receipt += 'VAT # ${finalOrderModel.receipt.first.vatNumber}\n';
    //  receipt += '     \n';
    //  // Print QR code
    //  // String qrCodeData = finalOrderModel.receipt.first.orderId;
    //  // String qrCodeCommand = generateQRCode(qrCodeData);
    //  // receipt += qrCodeCommand;
    //
    //  receipt += '      \n';
    //  receipt += '      \n';
    //  receipt += '      \n';
    //  receipt += '      \n';
    //  receipt += '      \n';
    //  receipt += '      \n';
    //  receipt += '      \n';
    //  receipt += '      \n';
    //  String autoCutCommand = '\x1B\x69'; // ESC i (auto-cut)
    //  receipt += autoCutCommand;
    //  // Return the generated receipt
    //  return receipt;
 */
/*
 // Print the encoded bytes (for debugging purposes)
          //  printer.textEncoded(utf8.encode(element.nameAr));

          // printer.setStyles(const PosStyles(codeTable: 'ISO_8859-6'));
          // List<int> textBytesCP864 = latin1.encode(element.nameAr);
          // printer.rawBytes(Uint8List.fromList(textBytesCP864));

//           final arabicText = 'لكن لا بد أن أوضح لك أن كل هذه الأفكار'; // Replace with your actual Arabic text
//
// // Encode the Arabic text with a suitable encoding like windows-1256
//           final encodedText = arabicText.codeUnits.map((code) => code & 0xff).toList();
//
//           printer.row([
//             PosColumn(text: '', width: 2),
//             PosColumn(
//               text: '', // Empty text for spacing
//               width: 8,
//             ),
//             PosColumn(text: '', width: 2),
//           ]);
//
// // Set code page to CP864 (if necessary, depending on your printer)
// // Some printers might handle encoding automatically
// // printer.setStyles(const PosStyles(codeTable: 'CP864'));
//
// // Send the raw bytes of the encoded Arabic text
//           printer.rawBytes(Uint8List.fromList(encodedText));
//
// // Add a separate new line after the Arabic text
//           printer.feed(1); // Move the paper down by one line (optional, adjust as needed)
 */

/*
  Future<void> generateReceipt(FinalOrderModel finalOrderModel) async {
    try{
      var homeProvider = Provider.of<HomeProvider>(NavigationService.navigatorKey.currentState!.context, listen: false);
      PrintLogs.printLog("clicked line 655");

      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();
      final printer = NetworkPrinter(paper, profile);
      PrintLogs.printLog("res: $printer");

      final PosPrintResult res = await printer.connect(selectedDevice.toString(), port: 9100);

      if (res == PosPrintResult.success) {
        final DateTime now = DateTime.now();
        final String formattedDate = DateFormat('yyyy/MM/dd HH:mm:ss').format(now);

        var style = const PosStyles(align: PosAlign.center);
        // Print Arabic text
        // var arabicStyle = const PosStyles(align: PosAlign.right, codeTable: 'CP864');
        // Load and decode the image
        // final ByteData data = await rootBundle.load('assets/images/rabbit_black.jpg');
        final ByteData data = await rootBundle.load(AppAssets.freshHouseLogoBW);
        final Uint8List bytes = data.buffer.asUint8List();
        final imageLib.Image? image = imageLib.decodeImage(bytes);

        // Check if the image is loaded properly
        if (image != null) {
          final imageLib.Image grayscaleImage = imageLib.grayscale(image);
          const int targetWidth = 250;
          final int targetHeight = (image.height * targetWidth / image.width).round(); // Maintain aspect ratio
          final imageLib.Image resizedImage = imageLib.copyResize(grayscaleImage, width: targetWidth, height: targetHeight);
          printer.imageRaster(resizedImage);
        } else {
          PrintLogs.printLog('Failed to load and decode image');
        }
        // printer.hr();

        printer.text('');
        printer.text('It is all about FRESHNESS', styles: style);
        printer.text(finalOrderModel.receipt.first.branchName, styles: style);
        printer.text('Simplified Tax Invoice - ${finalOrderModel.receipt.first.status.capitalize()}', styles: style);
        // Create border around 'Order# ...' text
        // String border = ''.padLeft(orderText.length + 4, '-');
        // printer.text(border, styles: style);
        printer.text('Order# ${finalOrderModel.receipt.first.orderId}', styles: style);
        // printer.text(border, styles: style);
        // printer.text('Order# ${finalOrderModel.receipt.first.orderId}', styles: style);
        printer.text('Printed At: $formattedDate', styles: const PosStyles(align: PosAlign.center));
        String solidLine = String.fromCharCodes(List.filled(48, 196)); // 196 is the code for '─' in code page 437
        printer.text(solidLine, styles: const PosStyles(codeTable: 'CP437'));
        // printer.hr();


        printer.text('Customer: ${finalOrderModel.receipt.first.customer}');
        printer.text('Served by: ${finalOrderModel.receipt.first.servedBy}');
        printer.text(solidLine, styles: const PosStyles(codeTable: 'CP437'));
        // printer.hr();

        printer.row([
          PosColumn(text: 'Qty', width: 2),
          PosColumn(text: 'Item', width: 8),
          PosColumn(text: 'Price', width: 2, styles: const PosStyles(align: PosAlign.right)),
        ]);

        for (var element in finalOrderModel.receipt.first.product) {
          printer.row([
            PosColumn(text: element.quantity, width: 2),
            PosColumn(text: element.name, width: 8),
            PosColumn(text: '${element.price} SR', width: 2, styles: const PosStyles(align: PosAlign.right)),
          ]);

          // printer.row([
          //   PosColumn(text: '', width: 2),
          //   PosColumn(text: element.nameAr, width: 8, styles: const PosStyles(codeTable: 'CP864'), containsChinese: true),  // Ensure code page is set for Arabic
          //   PosColumn(text: '', width: 2),
          // ]);

          // Directly use the Arabic string without encoding
          // printer.text(element.nameAr, styles: const PosStyles(align: PosAlign.right, codeTable: 'CP864'));
          // String arabicText = 'مرحبا بكم'; // Replace with your Arabic text
          // List<int> arabicBytes = convertToCP864(arabicText);
          // printer.rawBytes(arabicBytes);
        }

        // printer.hr();
        printer.text(solidLine, styles: const PosStyles(codeTable: 'CP437'));
        printer.row([
          PosColumn(text: 'Subtotal:', width: 8),
          PosColumn(text: '${finalOrderModel.receipt.first.subtotal} SR', width: 4, styles: const PosStyles(align: PosAlign.right)),
        ]);
        // printer.row([
        //   PosColumn(text: 'المجموع الفرعي', width: 8,styles: arabicStyle),
        //   PosColumn(text: '', width: 4, styles: const PosStyles(align: PosAlign.right)),
        // ]);
        printer.row([
          PosColumn(text: '15% Sales VAT:', width: 8),
          PosColumn(text: '${finalOrderModel.receipt.first.vat} SR', width: 4, styles: const PosStyles(align: PosAlign.right)),
        ]);
        // printer.hr();
        printer.text(solidLine, styles: const PosStyles(codeTable: 'CP437'));
        printer.row([
          PosColumn(text: 'Total:', width: 8),
          PosColumn(text: '${finalOrderModel.receipt.first.total} SR', width: 4, styles: const PosStyles(align: PosAlign.right)),
        ]);
        // printer.row([
        //   PosColumn(text: 'المجموع', width: 8,styles: arabicStyle),
        //   PosColumn(text: '', width: 4, styles: const PosStyles(align: PosAlign.right)),
        // ]);

        // printer.hr();
        printer.text(solidLine, styles: const PosStyles(codeTable: 'CP437'));

        if (finalOrderModel.receipt.first.paymentMethods.isNotEmpty) {
          for (var element in finalOrderModel.receipt.first.paymentMethods) {
            printer.row([
              PosColumn(text: element.name, width: 8),
              PosColumn(text: '${element.payment} SR', width: 4, styles: const PosStyles(align: PosAlign.right)),
            ]);
          }
          // printer.hr();
          printer.text(solidLine, styles: const PosStyles(codeTable: 'CP437'));
        }

        printer.text('Product Count ${finalOrderModel.receipt.first.productsCount}');
        // printer.hr();
        printer.text(solidLine, styles: const PosStyles(codeTable: 'CP437'));

        if (!homeProvider.selectedSessionModel.isTableManagement) {
          printer.text('Previous Freshii: ${finalOrderModel.receipt.first.previousFreshi}', styles: const PosStyles(align: PosAlign.left));
          printer.text('Total Earned Freshii: ${finalOrderModel.receipt.first.earnedFreshi}', styles: const PosStyles(align: PosAlign.left));
          printer.text('Total Freshii: ${finalOrderModel.receipt.first.totalFreshi}', styles: const PosStyles(align: PosAlign.left));
        }

        printer.text(homeProvider.configDetails.receiptFooter, styles: const PosStyles(align: PosAlign.center));
        printer.text('VAT # ${finalOrderModel.receipt.first.vatNumber}', styles: const PosStyles(align: PosAlign.center));

        printer.text('', styles: const PosStyles(align: PosAlign.center));

        // Print QR code
        printer.qrcode(finalOrderModel.receipt.first.orderId,size: QRSize.Size8);

        printer.feed(2);
        printer.cut();
        printer.disconnect();
      } else {
        PrintLogs.printLog('Could not connect to printer.');
      }
    }catch(e){
      PrintLogs.printLog("Exception line 725 >>>>>>> $e");
    }

  }

 */

// void testPrint() async {
//   PrintLogs.printLog("clicked line 1220");
//   const PaperSize paper = PaperSize.mm80;
//   final profile = await CapabilityProfile.load();
//   final printer = NetworkPrinter(paper, profile);
//   PrintLogs.printLog("selectedDevice: $selectedDevice");
//   final PosPrintResult res = await printer.connect(selectedDevice, port: 9100); // Replace with actual IP and port
//   PrintLogs.printLog("res >>>>>> $res");
//   if (res == PosPrintResult.success) {
//     PrintLogs.printLog("res >>>>>> PosPrintResult.success");
//     final DateTime now = DateTime.now();
//     final String formattedDate = DateFormat('MM/dd/yyyy H:mm').format(now);
//
//     var style = const PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2);
//
//     ///---------------------- fresh-house logo start -----------------
//     // Load and decode the image
//     final ByteData data = await rootBundle.load(AppAssets.freshHouseLogoBW); // Replace with actual asset path
//     final Uint8List bytes = data.buffer.asUint8List();
//     final imageLib.Image? image = imageLib.decodeImage(bytes);
//
//     // Check if the image is loaded properly
//     if (image != null) {
//       // Convert image to grayscale
//       final imageLib.Image grayscaleImage = imageLib.grayscale(image);
//
//       // Resize image to smaller dimensions (e.g., 144x144)
//       const int targetWidth = 144;
//       final int targetHeight = (image.height * targetWidth / image.width).round(); // Maintain aspect ratio
//       final imageLib.Image resizedImage = imageLib.copyResize(grayscaleImage, width: targetWidth, height: targetHeight);
//
//       // Print the image in raster format
//       printer.imageRaster(resizedImage);
//     } else {
//       PrintLogs.printLog('Failed to load and decode image');
//     }
//
//     ///---------------------- fresh-house logo end-----------------
//
//     printer.text('It is all about FRESHNESS', styles: style);
//     printer.text('Branch Name', styles: style);
//     printer.text('Simplified Tax Invoice - Paid', styles: style);
//     printer.text('Order# 123456', styles: style);
//
//     printer.text('Printed At: $formattedDate', styles: const PosStyles(align: PosAlign.center));
//     printer.hr();
//
//     printer.text('Customer: John Doe');
//     printer.text('Served by: Jane Smith');
//     printer.hr();
//
//     printer.row([
//       PosColumn(text: 'Qty', width: 1),
//       PosColumn(text: 'Item', width: 7),
//       PosColumn(text: 'Price', width: 2, styles: const PosStyles(align: PosAlign.right)),
//     ]);
//
//     // Dummy product list
//     List<Map<String, dynamic>> dummyProducts = [
//       {'quantity': '2', 'name': 'Apple', 'price': '2.00'},
//       {'quantity': '1', 'name': 'Banana', 'price': '1.50'},
//       {'quantity': '3', 'name': 'Orange', 'price': '3.00'},
//       {'quantity': '5', 'name': 'Mango', 'price': '5.00'},
//       {'quantity': '4', 'name': 'Grapes', 'price': '4.00'},
//     ];
//
//     for (var element in dummyProducts) {
//       printer.row([
//         PosColumn(text: element['quantity'], width: 1),
//         PosColumn(text: element['name'], width: 7),
//         PosColumn(text: '${element['price']} SR', width: 2, styles: const PosStyles(align: PosAlign.right)),
//       ]);
//     }
//
//     printer.hr();
//     printer.row([
//       PosColumn(text: 'Subtotal:', width: 7),
//       PosColumn(text: '15.50 SR', width: 4, styles: const PosStyles(align: PosAlign.right)),
//     ]);
//     printer.row([
//       PosColumn(text: '15% Sales VAT:', width: 7),
//       PosColumn(text: '2.33 SR', width: 4, styles: const PosStyles(align: PosAlign.right)),
//     ]);
//     printer.row([
//       PosColumn(text: 'Total:', width: 7),
//       PosColumn(text: '17.83 SR', width: 4, styles: const PosStyles(align: PosAlign.right)),
//     ]);
//     printer.hr();
//
//     String dummyPayment = 'Cash 17.83 SR\n';
//     printer.text(dummyPayment);
//     printer.hr();
//
//     printer.text('Product Count 5');
//     printer.hr();
//
//     printer.text('Receipt Footer Message', styles: const PosStyles(align: PosAlign.center));
//
//     // printer.textEncoded(encodeArabicText('المجموع'), styles: const PosStyles(align: PosAlign.center));
//     // Print Arabic text
//     // Uint8List arabicText = encodeArabicText('المجموع');
//     // printer.rawBytes(arabicText);
//
//
//     printer.text('VAT # 123456789', styles: const PosStyles(align: PosAlign.center));
//
//     // Print QR code
//     printer.qrcode('123456');
//
//     printer.feed(2);
//     printer.cut();
//     printer.disconnect();
//   } else {
//     PrintLogs.printLog('Could not connect to printer.');
//   }
// }


// void printSampleReceipt() async {
//   PrintLogs.printLog("clicked line 1032");
//   const PaperSize paper = PaperSize.mm80;
//   final profile = await CapabilityProfile.load();
//   final printer = NetworkPrinter(paper, profile);
//   PrintLogs.printLog("res: $printer");
//   final PosPrintResult res = await printer.connect(selectedDevice.toString(), port: 9100);
//
//   if (res == PosPrintResult.success) {
//     final DateTime now = DateTime.now();
//     final String formattedDate = DateFormat('MM/dd/yyyy H:mm').format(now);
//
//     printer.text(
//       'Awesome POS Receipt',
//       styles: const PosStyles(
//         align: PosAlign.center,
//         height: PosTextSize.size2,
//         width: PosTextSize.size2,
//         bold: true,
//       ),
//     );
//
//     // Load and decode the image
//     final ByteData data = await rootBundle.load('assets/images/rabbit_black.jpg');
//     final Uint8List bytes = data.buffer.asUint8List();
//     final imageLib.Image? image = imageLib.decodeImage(bytes);
//
//     // Check if the image is loaded properly
//     if (image != null) {
//       // Convert image to grayscale
//       final imageLib.Image grayscaleImage = imageLib.grayscale(image);
//
//       // Resize image if necessary (width should be a multiple of 8 for proper printing)
//       final imageLib.Image resizedImage = imageLib.copyResize(grayscaleImage, width: 576);
//       ///nice i will custimze the receipt you need to test it on suncday , it it good?
//       // Print the image in raster format
//       printer.imageRaster(resizedImage);
//     } else {
//       PrintLogs.printLog('Failed to load and decode image');
//     }
//
//     printer.text('123 POS Street',
//         styles: const PosStyles(align: PosAlign.center));
//     printer.text('City, State 12345',
//         styles: const PosStyles(align: PosAlign.center));
//     printer.text('Tel: 123-456-7890',
//         styles: const PosStyles(align: PosAlign.center));
//     printer.text(formattedDate, styles: const PosStyles(align: PosAlign.center));
//     printer.hr();
//
//     printer.row([
//       PosColumn(text: 'Item', width: 6, styles: const PosStyles(bold: true)),
//       PosColumn(text: 'Qty', width: 2, styles: const PosStyles(bold: true)),
//       PosColumn(text: 'Price', width: 2, styles: const PosStyles(bold: true)),
//       PosColumn(text: 'Total', width: 2, styles: const PosStyles(bold: true)),
//     ]);
//
//     printer.row([
//       PosColumn(text: 'Product 1', width: 6),
//       PosColumn(text: '2', width: 2),
//       PosColumn(text: '\$10', width: 2),
//       PosColumn(text: '\$20', width: 2),
//     ]);
//
//     printer.row([
//       PosColumn(text: 'Product 2', width: 6),
//       PosColumn(text: '1', width: 2),
//       PosColumn(text: '\$5', width: 2),
//       PosColumn(text: '\$5', width: 2),
//     ]);
//
//     printer.hr();
//     printer.row([
//       PosColumn(text: 'Subtotal', width: 8),
//       PosColumn(text: '\$25', width: 4),
//     ]);
//     printer.row([
//       PosColumn(text: 'Tax', width: 8),
//       PosColumn(text: '\$2.50', width: 4),
//     ]);
//     printer.hr();
//     printer.row([
//       PosColumn(text: 'Total', width: 8, styles: const PosStyles(bold: true)),
//       PosColumn(text: '\$27.50', width: 4, styles: const PosStyles(bold: true)),
//     ]);
//     printer.hr(ch: '=', linesAfter: 1);
//
//     // try {
//     //   const String qrData = 'example.com';
//     //   const double qrSize = 200;
//     //   final uiImg = await QrPainter(
//     //     data: qrData,
//     //     version: QrVersions.auto,
//     //     gapless: false,
//     //   ).toImageData(qrSize);
//     //   final dir = await getTemporaryDirectory();
//     //   final pathName = '${dir.path}/qr_tmp.png';
//     //   final qrFile = File(pathName);
//     //   final imgFile = await qrFile.writeAsBytes(uiImg.buffer.asUint8List());
//     //   final img = decodeImage(imgFile.readAsBytesSync());
//     //
//     //   printer.image(img);
//     // } catch (e) {
//     //   log(e);
//     // }
//     printer.qrcode('example.com');
//
//     printer.text(
//       'Thank you!',
//       styles: const PosStyles(align: PosAlign.center, bold: true),
//     );
//     printer.feed(2);
//     printer.cut();
//     printer.disconnect();
//   } else {
//     print('Could not connect to printer.');
//   }
// }


// Uint8List encodeArabicText(String text) {
//   // Encode the text using UTF-8 encoding
//   List<int> encodedText = utf8.encode(text);
//   // Convert the encoded text to Uint8List
//   Uint8List uint8ListText = Uint8List.fromList(encodedText);
//   return uint8ListText;
// }
//


/*
String generateReceiptHtml(FinalOrderModel finalOrderModel) {
  StringBuffer htmlBuffer = StringBuffer();

  htmlBuffer.write('''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            padding: 16px;
        }
        .container {
            width: 200px;
            margin: 0 auto;
            padding: 16px;
            background-color: white;
            border: 1px solid #ccc;
        }
        .center {
            text-align: center;
        }
        .bold {
            font-weight: bold;
        }
        .bordered {
            padding: 10px;
            border: 1px solid black;
            display: inline-block;
        }
        .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        .divider {
            border-top: 1px solid black;
            margin: 10px 0;
        }
        .qr-code {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="center">
            <img src="path/to/freshHouseLogo.png" alt="Fresh House Logo" width="100" height="100">
            <p class="bold">It is all about FRESHNESS</p>
            <p class="bold">${finalOrderModel.receipt.first.branchName}</p>
            <p>Simplified Tax Invoice - ${capitalize(finalOrderModel.receipt.first.status)}</p>
            <div class="bordered">
                <p class="bold">Order# ${finalOrderModel.receipt.first.orderId}</p>
            </div>
            <p>Printed At: ${getFormattedDate(DateTime.now())}</p>
            <div class="divider"></div>
            <p>Customer: ${finalOrderModel.receipt.first.customer}</p>
            <p>Served by: ${finalOrderModel.receipt.first.servedBy}</p>
            <div class="divider"></div>
            <div class="row">
                <p class="bold">Qty</p>
                <p class="bold">Item</p>
                <p class="bold">Price</p>
            </div>
            <div class="divider"></div>
  ''');

  finalOrderModel.receipt.first.product.forEach((rowData) {
    htmlBuffer.write('''
            <div>
                <div class="row">
                    <p>${rowData.quantity}</p>
                    <div>
                        <p>${rowData.name}</p>
                        ${rowData.nameAr.isNotEmpty ? '<p style="font-family: \'ArbFONTS\';">${rowData.nameAr}</p>' : ''}
                    </div>
                    <p>${rowData.price} SR</p>
                </div>
                <div class="divider"></div>
            </div>
    ''');
  });

  htmlBuffer.write('''
            <div class="row">
                <p class="bold">Subtotal</p>
                <p>${finalOrderModel.receipt.first.subtotal} SR</p>
            </div>
            <div class="row">
                <p style="font-family: 'ArbFONTS';" class="bold">المجموع الفرعي</p>
                <p></p>
            </div>
            <div class="row">
                <p class="bold">15% Sales VAT</p>
                <p>${finalOrderModel.receipt.first.vat} SR</p>
            </div>
            <div class="divider"></div>
            <div class="row">
                <p class="bold">Total</p>
                <p>${finalOrderModel.receipt.first.total} SR</p>
            </div>
            <div class="row">
                <p style="font-family: 'ArbFONTS';" class="bold">المجموع</p>
                <p></p>
            </div>
  ''');

  if (finalOrderModel.receipt.first.paymentMethods.isNotEmpty) {
    finalOrderModel.receipt.first.paymentMethods.forEach((paymentObj) {
      htmlBuffer.write('''
            <div class="row">
                <p>${paymentObj.name}</p>
                <p>${paymentObj.payment} SR</p>
            </div>
      ''');
    });
  }

  htmlBuffer.write('''
            <div class="divider"></div>
            <p class="center">Products Count ${finalOrderModel.receipt.first.productsCount}</p>
            <div class="divider"></div>
            <div class="row">
                <p>Previous Freshii</p>
                <p>${finalOrderModel.receipt.first.previousFreshi}</p>
            </div>
            <div class="row">
                <p>Total Earned Freshii</p>
                <p>${finalOrderModel.receipt.first.earnedFreshi}</p>
            </div>
            <div class="row">
                <p>Total Freshii</p>
                <p>${finalOrderModel.receipt.first.totalFreshi}</p>
            </div>
            <div class="divider"></div>
            <p class="center">Subscribe online now:<br>www.freshhouse.com.sa</p>
            <p class="center">VAT # ${finalOrderModel.receipt.first.vatNumber}</p>
            <div class="qr-code">
                <img src="https://api.qrserver.com/v1/create-qr-code/?data=${finalOrderModel.receipt.first.orderId}&size=100x100" alt="QR Code">
            </div>
        </div>
    </div>
</body>
</html>
  ''');

  return htmlBuffer.toString();
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();

String getFormattedDate(DateTime dateTime) {
  return "${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
}

// Dummy FinalOrderModel class for illustration. Replace with your actual model class.
class FinalOrderModel {
  List<Receipt> receipt;

  FinalOrderModel({required this.receipt});
}

class Receipt {
  String branchName;
  String status;
  String orderId;
  String customer;
  String servedBy;
  List<Product> product;
  double subtotal;
  double vat;
  double total;
  int productsCount;
  int previousFreshi;
  int earnedFreshi;
  int totalFreshi;
  String vatNumber;
  List<PaymentMethod> paymentMethods;

  Receipt({
    required this.branchName,
    required this.status,
    required this.orderId,
    required this.customer,
    required this.servedBy,
    required this.product,
    required this.subtotal,
    required this.vat,
    required this.total,
    required this.productsCount,
    required this.previousFreshi,
    required this.earnedFreshi,
    required this.totalFreshi,
    required this.vatNumber,
    required this.paymentMethods,
  });
}

class Product {
  String name;
  String nameAr;
  String quantity;
  String price;

  Product({required this.name, required this.nameAr, required this.quantity, required this.price});
}

class PaymentMethod {
  String name;
  String payment;

  PaymentMethod({required this.name, required this.payment});
}
 */

/*
 void testPrint(Receipt receipt)async{
    FinalOrderModel finalOrderModel = FinalOrderModel();
    finalOrderModel.receipt.add(receipt);
  //create image
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/receipt.png';

      // Create the receipt widget
      Widget receiptWidget = buildReceiptWidget(finalOrderModel);

      // Capture the widget to an image
      final image = await screenshotController.captureFromWidget(receiptWidget, delay: const Duration(milliseconds: 100));

      // Save the image to the file system
      final file = File(filePath);
      await file.writeAsBytes(image);
      print('Image saved to $filePath');

      //epson thermal printer
      ///print image
      final profile = await CapabilityProfile.load();
      final printer = NetworkPrinter(PaperSize.mm80, profile);

      // Replace with your printer's IP address and port
      // final PosPrintResult res = await printer.connect(selectedDevice.toString(), port: 9100);
      //
      // if (res == PosPrintResult.success) {
      //   print('Connected to printer');
      //
      //   final bytes = await File(filePath).readAsBytes();
      //   final image = imageLib.decodeImage(bytes);
      //
      //   if (image != null) {
      //     final resizedImage = imageLib.copyResize(image, width: 384); // Adjust width to fit printer
      //
      //     printer.image(resizedImage);
      //     printer.feed(2);
      //     printer.cut();
      //     printer.disconnect();
      //   } else {
      //     print('Error decoding image');
      //   }
      // } else {
      //   print('Could not connect to printer: $res');
      // }

    } catch (e) {
      print('Error generating or sending receipt: $e');
    }


  }

  Widget buildReceiptWidget(FinalOrderModel finalOrderModel) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.freshHouseLogo, width: 100, height: 100),
                const SizedBox(height: 2),
                const CustomText(
                    text: 'It is all about FRESHNESS',
                    textAlign: TextAlign.center,
                    fontSize: 12,
                    height: 1.2),
                const SizedBox(height: 5),
                CustomText(
                    text: finalOrderModel.receipt.first.branchName,
                    textAlign: TextAlign.center,
                    fontSize: 12,
                    height: 1.2),
                const SizedBox(height: 10),
                CustomText(
                    text: 'Simplified Tax Invoice - ${finalOrderModel.receipt.first.status.capitalize()}',
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    height: 1.2),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: CustomText(
                          text: 'Order# ${finalOrderModel.receipt.first.orderId}',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.2),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomText(
                    text: 'Printed At: ${HelperFunctions.getDateTimeString(DateTime.now().toString(), format: 'yyyy/MM/dd HH:mm:ss')}',
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    height: 1.2),
                const Divider(thickness: 1, color: AppColors.blackColor),
                CustomText(
                    text: 'Customer: ${finalOrderModel.receipt.first.customer}',
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    height: 1.2),
                CustomText(
                    text: 'Served by: ${finalOrderModel.receipt.first.servedBy}',
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    height: 1.2),
                const Divider(thickness: 1, color: AppColors.blackColor),
                const Row(children: [
                  CustomText(
                      text: 'Qty',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.2),
                  SizedBox(width: 20),
                  Expanded(
                      child: CustomText(
                          text: 'Item',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 1.2)),
                  SizedBox(width: 5),
                  CustomText(
                      text: 'Price',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.2),
                ]),
                const Divider(thickness: 1, color: AppColors.blackColor),
                for (var rowData
                in finalOrderModel.receipt.first.product)
                  Column(
                    children: [
                      Row(children: [
                        CustomText(
                            text: rowData.quantity,
                            fontSize: 14,
                            height: 1.2),
                        const SizedBox(width: 20),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: rowData.name,
                                    fontSize: 14,
                                    height: 1.2),
                                if (rowData.nameAr.isNotEmpty)
                                  CustomText(
                                      text: rowData.nameAr,
                                      fontSize: 14,
                                      height: 1.2,
                                      fontFamily: 'ArbFONTS'),
                              ],
                            )),
                        const SizedBox(width: 5),
                        CustomText(
                            text: '${rowData.price} SR',
                            fontSize: 14,
                            height: 1.2),
                      ]),
                      const Divider(
                          thickness: 1, color: AppColors.blackColor),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                        text: 'Subtotal',
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                    CustomText(
                        text: '${finalOrderModel.receipt.first.subtotal} SR',
                        height: 1.2),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: 'المجموع الفرعي',
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ArbFONTS',
                        height: 1.2),
                    CustomText(text: '', height: 1.2),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                        text: '15% Sales VAT',
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                    CustomText(
                        text: '${finalOrderModel.receipt.first.vat} SR',
                        height: 1.2),
                  ],
                ),
                const Divider(thickness: 1, color: AppColors.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                        text: 'Total',
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                    CustomText(
                        text: '${finalOrderModel.receipt.first.total} SR',
                        height: 1.2),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: 'المجموع',
                        fontWeight: FontWeight.w600,
                        fontFamily: 'ArbFONTS',
                        height: 1.2),
                    CustomText(text: '', height: 1.2),
                  ],
                ),
                if (finalOrderModel.receipt.first.paymentMethods.isNotEmpty)
                  const SizedBox(height: 10),
                if (finalOrderModel.receipt.first.paymentMethods.isNotEmpty)
                  for (var paymentObj in finalOrderModel.receipt.first.paymentMethods)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: paymentObj.name),
                        CustomText(text: '${paymentObj.payment} SR'),
                      ],
                    ),
                const Divider(thickness: 1, color: AppColors.blackColor),
                CustomText(
                    text: 'Products Count ${finalOrderModel.receipt.first.productsCount}',
                    textAlign: TextAlign.center,
                    height: 1),
                const Divider(thickness: 1, color: AppColors.blackColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: 'Previous Freshii', height: 1),
                    CustomText(
                        text: finalOrderModel.receipt.first.previousFreshi,
                        height: 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: 'Total Earned Freshii', height: 1),
                    CustomText(
                        text: finalOrderModel.receipt.first.earnedFreshi,
                        height: 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: 'Total Freshii', height: 1),
                    CustomText(
                        text: finalOrderModel.receipt.first.totalFreshi,
                        height: 1),
                  ],
                ),
                const Divider(thickness: 1, color: AppColors.blackColor),
                const CustomText(
                    text: 'Subscribe online now:\nwww.freshhouse.com.sa',
                    textAlign: TextAlign.center,
                    height: 1),
                const SizedBox(height: 15),
                CustomText(
                    text: 'VAT # ${finalOrderModel.receipt.first.vatNumber}',
                    textAlign: TextAlign.center,
                    height: 1),
                const SizedBox(height: 10),
                Center(
                  child: QrImageView(
                      data: finalOrderModel.receipt.first.orderId,
                      version: QrVersions.auto,
                      size: 100.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
 */

/*
  Future<void> testPrint(String printerIp, String imageUrl, String text, String arabicText) async {
    final String xmlData = '''
  <?xml version="1.0" encoding="utf-8"?>
  <PrintRequestInfo>
    <ew:ewPosPrint xmlns:ew="http://www.epson-pos.com/schemas/2011/03/eposprint">
      <ew:Text>
        <![CDATA[
          $text
        ]]>
      </ew:Text>
      <ew:Text lang="ar">
        <![CDATA[
          $arabicText
        ]]>
      </ew:Text>
      <ew:Image url="$imageUrl" />
      <ew:Cut type="feed" />
    </ew:ewPosPrint>
  </PrintRequestInfo>
  ''';

    final String printerUrl = 'http://$printerIp:80/cgi-bin/epos/service.cgi?devid=local_printer&timeout=10000';

    try {
      final response = await http.post(
        Uri.parse(printerUrl),
        headers: {
          'Content-Type': 'text/xml; charset=utf-8',
        },
        body: utf8.encode(xmlData),
      );

      if (response.statusCode == 200) {
        print('Print job sent successfully');
      } else {
        print('Failed to send print job: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error sending print job: $e');
    }
  }
 */