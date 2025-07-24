import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';

import 'package:qr_meetapp/features/qr_scanner/qr_result_screen.dart';
import 'package:qr_meetapp/data/services/qr_service.dart';

/// QR Scanner Screen
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Future<void> _processQrCode(String code) async {
    if (_isProcessing) return;
    setState(() {
      _isProcessing = true;
      _isScanning = false;
    });
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final qrData = await _qrService.processQR(code);
      if (!mounted) return;
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => QRResultScreen(qrData: qrData),
        ),
      );
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _isScanning = true;
      });
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: Text('Manual entry failed: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
  final QRService _qrService = QRService();
  final MobileScannerController _controller = MobileScannerController();
  bool _isScanning = true;
  bool _flashEnabled = false;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: Icon(_flashEnabled ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              setState(() {
                _flashEnabled = !_flashEnabled;
              });
              _controller.toggleTorch();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // QR Scanner view
          MobileScanner(
            controller: _controller,
            onDetect: (capture) async {
              if (_isProcessing) return;
              
              final barcode = capture.barcodes.firstOrNull;
              if (barcode?.rawValue == null) return;
              
              setState(() {
                _isProcessing = true;
                _isScanning = false;
              });
              
              // Get context references before async call
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              
              try {
                final qrData = await _qrService.processQR(barcode!.rawValue!);
                if (!mounted) return;
                
                navigator.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => QRResultScreen(qrData: qrData),
                  ),
                );
              } catch (e) {
                setState(() {
                  _isProcessing = false;
                  _isScanning = true;
                });
                
                // Show error
                if (mounted) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('Scan failed: ${e.toString()}'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
          ),
          
          // Scanner overlay
          if (_isScanning) _buildScannerOverlay(),
          
          // Manual entry option
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () async {
                  final manualCode = await showDialog<String>(
                    context: context,
                    builder: (context) {
                      String input = '';
                      return AlertDialog(
                        title: const Text('Enter Code Manually'),
                        content: TextField(
                          autofocus: true,
                          decoration: const InputDecoration(hintText: 'Enter code'),
                          onChanged: (value) => input = value,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(input),
                            child: const Text('Submit'),
                          ),
                        ],
                      );
                    },
                  );
                  if (manualCode != null && manualCode.isNotEmpty) {
                    // Handle manual code as you would a scanned QR code
                    _processQrCode(manualCode);
                  }
                },
                child: const Text(
                  'Enter Code Manually',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return CustomPaint(
      painter: _ScannerOverlayPainter(),
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Position QR code within frame',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(height: 32),
              if (_isProcessing)
                const CircularProgressIndicator(color: AppColors.primary)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Custom painter for scanner overlay
class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerWidth = width / 2;
    final centerHeight = height / 2;
    
    // Draw a semi-transparent overlay
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    
    // Draw the overlay with a hole in the center
    final path = Path()
      ..addRect(Rect.fromLTRB(0, 0, width, height))
      ..addRect(Rect.fromCenter(
        center: Offset(centerWidth, centerHeight),
        width: 250,
        height: 250,
      ))
      ..fillType = PathFillType.evenOdd;
    
    canvas.drawPath(path, paint);
    
    // Draw corner indicators
    final cornerPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    
    const cornerSize = 30;
    const centerRectSize = 250;
    
    // Top left corner
    canvas.drawLine(
      Offset(centerWidth - centerRectSize / 2, centerHeight - centerRectSize / 2),
      Offset(centerWidth - centerRectSize / 2 + cornerSize, centerHeight - centerRectSize / 2),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(centerWidth - centerRectSize / 2, centerHeight - centerRectSize / 2),
      Offset(centerWidth - centerRectSize / 2, centerHeight - centerRectSize / 2 + cornerSize),
      cornerPaint,
    );
    
    // Top right corner
    canvas.drawLine(
      Offset(centerWidth + centerRectSize / 2, centerHeight - centerRectSize / 2),
      Offset(centerWidth + centerRectSize / 2 - cornerSize, centerHeight - centerRectSize / 2),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(centerWidth + centerRectSize / 2, centerHeight - centerRectSize / 2),
      Offset(centerWidth + centerRectSize / 2, centerHeight - centerRectSize / 2 + cornerSize),
      cornerPaint,
    );
    
    // Bottom left corner
    canvas.drawLine(
      Offset(centerWidth - centerRectSize / 2, centerHeight + centerRectSize / 2),
      Offset(centerWidth - centerRectSize / 2 + cornerSize, centerHeight + centerRectSize / 2),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(centerWidth - centerRectSize / 2, centerHeight + centerRectSize / 2),
      Offset(centerWidth - centerRectSize / 2, centerHeight + centerRectSize / 2 - cornerSize),
      cornerPaint,
    );
    
    // Bottom right corner
    canvas.drawLine(
      Offset(centerWidth + centerRectSize / 2, centerHeight + centerRectSize / 2),
      Offset(centerWidth + centerRectSize / 2 - cornerSize, centerHeight + centerRectSize / 2),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(centerWidth + centerRectSize / 2, centerHeight + centerRectSize / 2),
      Offset(centerWidth + centerRectSize / 2, centerHeight + centerRectSize / 2 - cornerSize),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}