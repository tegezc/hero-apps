import 'package:flutter/material.dart';

import 'login/inputcodeverification.dart';
import 'login/resetpassword.dart';
import 'model/distribusi/datapembeli.dart';
import 'model/pjp.dart';
import 'model/promotion/promotion.dart';
import 'modul_sales/sf_main.dart';
import 'modulapp/camera/recordvideo/pagerecordvideo.dart';
import 'modulapp/camera/pagetakephoto.dart';
import 'modulapp/camera/previewphoto.dart';
import 'modulapp/camera/previewphotoupload.dart';
import 'modulapp/camera/previewvideo.dart';
import 'modulapp/coverage/clockin/mapcloclin.dart';
import 'modulapp/coverage/clockin/menusales.dart';
import 'modulapp/coverage/distribution/daftarproductdistribusi.dart';
import 'modulapp/coverage/distribution/homepembeliandistribusi.dart';
import 'modulapp/coverage/distribution/pembayaran/pembayarandistribusi.dart';
import 'modulapp/coverage/distribution/pembelianitem/pembelian_item.dart';
import 'modulapp/coverage/location/editoroutlet.dart';
import 'modulapp/coverage/marketaudit/ds/uidsmarketaudit.dart';
import 'modulapp/coverage/marketaudit/sf/hpsurvey.dart';
import 'modulapp/coverage/merchandising/homemerchandising.dart';
import 'modulapp/coverage/pagesuccess.dart';
import 'modulapp/coverage/promotion/hppromotion.dart';
import 'modulapp/coverage/retur/hpretur.dart';
import 'modulapp/coverage/retur/retureditor.dart';

class HoreRoute {
  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeControllpage.routeName:
        {
          final HomeControllpageParam? args =
              settings.arguments as HomeControllpageParam?;
          return _buildRoute(
              settings,
              HomeControllpage(
                statelogin: args,
              ));
        }
      case ResetPassword.routeName:
        return _buildRoute(settings, const ResetPassword());
      case InputCodeVerification.routeName:
        return _buildRoute(settings, const InputCodeVerification());
      case MapClockIn.routeName:
        final Pjp? args = settings.arguments as Pjp?;
        return _buildRoute(settings, MapClockIn(args));
      case MenuSales.routeName:
        final Pjp? args = settings.arguments as Pjp?;
        return _buildRoute(settings, MenuSales(args));
      case DaftarProductDistribusi.routeName:
        final Pjp? item = settings.arguments as Pjp?;
        return _buildRoute(settings, DaftarProductDistribusi(item));
      case PembelianItem.routeName:
        {
          final ItemTransaksi? args = settings.arguments as ItemTransaksi?;
          return _buildRoute(settings, PembelianItem(args));
        }
      case PembayaranDistribusi.routeName:
        {
          final ParamPembayaran? paramPembayaran =
              settings.arguments as ParamPembayaran?;
          return _buildRoute(settings, PembayaranDistribusi(paramPembayaran));
        }
      case PageSuccess.routeName:
        {
          final param = settings.arguments;
          return _buildRoute(settings, PageSuccess(param as PageSuccessParam?));
        }
      case HomePembelianDistribusi.routeName:
        {
          final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, HomePembelianDistribusi(item));
        }
      case HomeMerchandising.routeName:
        {
          final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, HomeMerchandising(item));
        }
      case HomePagePromotion.routeName:
        {
          final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, HomePagePromotion(item));
        }
      case HomePageRetur.routeName:
        {
          return _buildRoute(settings, const HomePageRetur());
        }
      case ReturEditor.routeName:
        {
          return _buildRoute(settings, ReturEditor());
        }
      case EditorOutlet.routeName:
        {
          final String? item = settings.arguments as String?;
          return _buildRoute(settings, EditorOutlet(item));
        }
      case CameraView.routeName:
        {
          final ParamPreviewPhoto? item =
              settings.arguments as ParamPreviewPhoto?;
          return _buildRoute(settings, CameraView(item));
        }
      case PreviewPhotoWithUpload.routeName:
        {
          final ParamPreviewPhoto? item =
              settings.arguments as ParamPreviewPhoto?;
          return _buildRoute(settings, PreviewPhotoWithUpload(item));
        }

      case PreviewPhoto.routeName:
        {
          final ParamPreviewPhoto? item =
              settings.arguments as ParamPreviewPhoto?;
          return _buildRoute(settings, PreviewPhoto(item));
        }
      case HomeSurvey.routeName:
        {
          final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, HomeSurvey(item));
        }
      case CoverageMarketAudit.routeName:
        {
          //final Pjp? item = settings.arguments as Pjp?;
          return _buildRoute(settings, const CoverageMarketAudit());
        }
      case PageTakeVideo.routeName:
        {
          final Promotion? item = settings.arguments as Promotion?;
          return _buildRoute(settings, PageTakeVideo(item));
        }
      case PreviewVideoUpload.routeName:
        {
          final ParamPreviewVideo? item =
              settings.arguments as ParamPreviewVideo?;
          return _buildRoute(settings, PreviewVideoUpload(item));
        }
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
