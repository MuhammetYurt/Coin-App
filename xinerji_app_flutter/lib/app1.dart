import 'package:flutter/material.dart';
import 'package:xinerji_app_flutter/app2.dart';
import 'package:xinerji_app_flutter/main.dart';
import 'package:provider/provider.dart';

class CoinApp extends StatefulWidget {
  const CoinApp({super.key});
  @override
  State<CoinApp> createState() => _CoinAppState();
}

class _CoinAppState extends State<CoinApp> {
  final String _title = 'Coin App';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(_title),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.pink, Colors.blue],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CoinApp2()),
                );
              },
              child: const Text('Detail'),
              style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 191, 108, 206)),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bu uygulmanın tüm hakları Muhammet Yurt\'a aittir.'),
                  ),
                );
              },
              child: const Text('SnackBar'),
              style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 74, 128, 171)),
            ),
            IconButton(
              onPressed: () {
                themeProvider.toggleTheme();
              },
              icon: themeProvider.currentTheme == ThemeData.light()
                  ? const Icon(
                      Icons.dark_mode_outlined,
                      color: Colors.black,
                      size: 35,
                    )
                  : const Icon(
                      Icons.wb_sunny,
                      color: Colors.yellow,
                      size: 35,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
