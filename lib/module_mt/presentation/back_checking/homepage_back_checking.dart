import 'package:flutter/material.dart';
import 'package:hero/module_mt/presentation/common/widgets/page_loading_mt.dart';

class HPBackChecking extends StatefulWidget {
  const HPBackChecking({Key? key}) : super(key: key);

  @override
  _HPBackCheckingState createState() => _HPBackCheckingState();
}

class _HPBackCheckingState extends State<HPBackChecking> {
  @override
  Widget build(BuildContext context) {
    return const LoadingNungguMT('Terjadi kesalahan');
  }
}
