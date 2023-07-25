import 'package:flutter/material.dart';
import 'package:google_otp_verification/util.dart';
import 'package:otp/otp.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerifyOTPPage(),
    );
  }
}

class VerifyOTPPage extends StatefulWidget {
  @override
  _VerifyOTPPageState createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  final TextEditingController _otpController = TextEditingController();

  bool _isOTPVerified = false;

  // final _secret = 'E5VRBBJUGUSL6VP2';
  final _secret = 'O3TZSQP6MWYWYMKLGEHOBULZB772RJDB';
  String get _otpRegistration => 'otpauth://totp/test-company?algorithm=SHA256&digits=6&secret=$_secret&issuer=test-company';

  void _verifyOTP() {
    String inputOTP = _otpController.text.trim();
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    print(StringGenerators.generate());

    var generatedCode = OTP.generateTOTPCodeString(
      _secret,
      currentTime,
      isGoogle: true,
    );

    print(generatedCode);

    final isValid = OTP.constantTimeVerification(generatedCode, inputOTP);

    setState(() {
      _isOTPVerified = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Authenticator 2FA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: PrettyQr(
                typeNumber: 7,
                size: 200,
                data: _otpRegistration,
                errorCorrectLevel: QrErrorCorrectLevel.M,
                roundEdges: true,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: const Text('Verify OTP'),
            ),
            const SizedBox(height: 20),
            _isOTPVerified
                ? const Text(
                    'OTP Verified!',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
