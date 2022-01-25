import 'package:flutter/material.dart';
import 'package:hero/model/promotion/promotion.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:better_player/better_player.dart';

class ResolutionsPage extends StatefulWidget {
  final Promotion itemPromotion;
  const ResolutionsPage(this.itemPromotion, {Key? key}) : super(key: key);

  @override
  _ResolutionsPageState createState() => _ResolutionsPageState();
}

class _ResolutionsPageState extends State<ResolutionsPage> {
  late BetterPlayerController _betterPlayerController;

  bool _isprogramlocalshowing = false;
  String programlocal = 'PROGRAM LOKAL';
  @override
  void initState() {
    _isprogramlocalshowing = widget.itemPromotion.nama == programlocal;
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      // "http://channelsumbagsel.com/apihore/assets/promotion_video/46_10.mp4",
      widget.itemPromotion.pathVideo!,
      //   resolutions: Constants.exampleResolutionsUrls,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Promotion Video',
      body: Column(children: [
        const SizedBox(height: 8),
        _title(),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(controller: _betterPlayerController),
        ),
      ]),
    );
  }

  Widget _title() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LabelApp.size1(
            '${widget.itemPromotion.nama}',
            bold: true,
          ),
        ),
        _isprogramlocalshowing
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LabelApp.size2(
                  '${widget.itemPromotion.nmlocal}',
                ),
              )
            : Container(),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
