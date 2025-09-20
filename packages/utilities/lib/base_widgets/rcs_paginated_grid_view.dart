import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:utilities/extensions/extension_load_asset_image.dart';

import '../app_colors.dart';
import '../app_images.dart';
import '../network_utility/app_connectivity.dart';
import '../strings.dart';
import '../text_size.dart';
import 'common_widgets.dart';
import 'rcs_text_widget.dart';

class RcsPaginatedGridView extends StatelessWidget {
  RcsPaginatedGridView(
      {super.key,
      required this.itemLength,
      required this.isPaginationEnded,
      this.numberOfLoadingCards = 4,
      required this.itemBuilder,
      this.shimmerCardRadius = 16,
      required this.onPageEnd,
      required this.crossAxisSpacing,
      this.mainAxisSpacing = 0,
      required this.childAspectRatio,
      required this.crossAxisCount,
        this.onRefresh,this.padding,this.isTvScrollBarRequired=false});

  bool isTvScrollBarRequired;
  int itemLength;
  bool isPaginationEnded;
  int numberOfLoadingCards;
  Widget Function(BuildContext context, int index) itemBuilder;
  void Function() onPageEnd;
  int shimmerCardRadius;
  int margin = 6;
  int crossAxisCount;
  double childAspectRatio;
  double crossAxisSpacing;
  double mainAxisSpacing;
  Future<void> Function()? onRefresh;
  EdgeInsets? padding;

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showNoNetwork = ValueNotifier<bool>(
      false); //to display loading shimmer as soon as user clicks retry

  @override
  Widget build(BuildContext context) {
    int itemCount =
        isPaginationEnded ? itemLength : itemLength + numberOfLoadingCards;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: LayoutBuilder(
          builder: (context, constraints) {
            final double availableWidth =
                constraints.maxWidth - (crossAxisCount - 1) * crossAxisSpacing;
            final double itemWidth = availableWidth / crossAxisCount;
            final double itemHeight = itemWidth / childAspectRatio;

            return NotificationListener<ScrollNotification>(
              child: RefreshIndicator(
                onRefresh: ()async{
                  if(onRefresh != null){
                    onRefresh!();
                  }
                },
                child: UI.esScrollBar(
                  isTvScrollRequired: isTvScrollBarRequired,
                  controller: _scrollController,
                  padding: padding,
                  child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: itemCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: mainAxisSpacing,
                        childAspectRatio: childAspectRatio,
                        crossAxisSpacing: crossAxisSpacing),
                    itemBuilder: (context, index) {
                      if (index < itemLength) {
                        return itemBuilder(context, index);
                      } else if (AppConnectivity().isConnected) {
                        return singleCardShimmer(shimmerCardRadius, margin);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent -
                          (itemHeight *
                              (numberOfLoadingCards / crossAxisCount))) {
                    if (AppConnectivity().isConnected) {
                      onPageEnd();
                    } else {
                      _showNoNetwork.value = true;
                    }
                    return true;
                  }
                }
                return true;
              },
            );
          },
        )),
        paginationNoNetworkView()
      ],
    );
  }

  Widget singleCardShimmer(int borderRadius, int margin) => Shimmer.fromColors(
        baseColor: AppColors.loginGradientTop.withValues(alpha: 0.5),
        highlightColor: AppColors.loginGradientTop.withOpacity(0.4),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: Space.sp(margin)),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(Space.sp(borderRadius))),
        ),
      );

  Widget commonCardView(Widget child) => Card(
        surfaceTintColor: AppColors.white,
        color: AppColors.white,
        elevation: 6,
        margin: EdgeInsets.symmetric(vertical: Space.sp(6)),
        child: Padding(
          padding: EdgeInsets.all(Space.sp(15)),
          child: child,
        ),
      );

  Widget paginationNoNetworkView() => ValueListenableBuilder(
        valueListenable: _showNoNetwork,
        builder: (context, value, child) => value
            ? commonCardView(Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppImages.appNoInternet.loadAsset(height: Space.sp(90)),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RcsText(
                        Strings.appNoNetworkText,
                        size: TextSize.setSp(12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: Space.sp(10),
                      ),
                      UI.updatedFilledTextButtonWithMinWidth(Strings.appRetryText, () {
                        if (AppConnectivity().isConnected) {
                          _showNoNetwork.value = false;
                          onPageEnd();
                        }
                      },),
                    ],
                  ))
                ],
              ))
            : SizedBox.shrink(),
      );
}
