import 'package:flutter/material.dart';
import 'package:xinerji_app_flutter/model/coin_model.dart';
import 'package:xinerji_app_flutter/service/coin_service.dart';

class CoinApp2 extends StatefulWidget {
  const CoinApp2({super.key});

  @override
  State<CoinApp2> createState() => _CoinApp2State();
}

class _CoinApp2State extends State<CoinApp2> {
  final String _title = 'Detail';
  bool? isLoading;
  final CoinService _service = CoinService();
  List<CoinModelData?> datas = [];

  @override
  void initState() {
    super.initState();
    _service.fetchDatas().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          datas = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: isLoading == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://assets.coincap.io/assets/icons/${datas[index]?.symbol?.toLowerCase()}@2x.png'),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${datas[index]?.name ?? ''}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('${datas[index]?.symbol ?? ''}', style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('\$${double.parse(datas[index]?.priceUsd ?? '0').toStringAsFixed(6)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  Icon(
                                    double.parse(datas[index]?.changePercent24Hr ?? '0') >= 0
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: double.parse(datas[index]?.changePercent24Hr ?? '0') >= 0
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  Text('${double.parse(datas[index]?.changePercent24Hr ?? '0').toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          color: double.parse(datas[index]?.changePercent24Hr ?? '0') >= 0
                                              ? Colors.green
                                              : Colors.red)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Market Cap: \$${double.parse(datas[index]?.marketCapUsd ?? '0').toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 15)),
                          Text(
                              'Volume (24Hr): \$${double.parse(datas[index]?.volumeUsd24Hr ?? '0').toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
