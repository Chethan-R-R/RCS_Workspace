import 'package:flutter/material.dart';
import 'package:utilities/extensions/extension_load_asset_image.dart';
import '../app_colors.dart';
import '../app_images.dart';
import '../network_utility/app_connectivity.dart';
import '../strings.dart';
import '../text_size.dart';
import 'common_widgets.dart';
import 'rcs_text_widget.dart';

class RcsPaginatedListView extends StatelessWidget {
  RcsPaginatedListView(
      {super.key,
      this.padding,
      required this.itemLength,
      required this.isPaginationEnded,
      this.numberOfLoadingCards = 4,
      required this.itemBuilder,
      this.shimmerCardHeight = 100,
      this.shimmerCardRadius = 16,
      required this.onPageEnd,
      required this.onRefresh, this.isTvScrollBarRequired=false});
  bool isTvScrollBarRequired;
  int itemLength;
  bool isPaginationEnded;
  int numberOfLoadingCards;
  Widget Function(BuildContext context, int index) itemBuilder;
  void Function() onPageEnd;
  Future<void> Function() onRefresh;
  int shimmerCardHeight;
  int shimmerCardRadius;
  int margin = 6;
  EdgeInsets? padding;

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showLoading = ValueNotifier<bool>(
      false); //to display loading shimmer as soon as user clicks retry

  @override
  Widget build(BuildContext context) {
    int itemCount =
        isPaginationEnded ? itemLength : itemLength + numberOfLoadingCards;
    return NotificationListener<ScrollNotification>(
      child: RefreshIndicator(
        color: AppColors.loginGradientBottom,
        onRefresh: onRefresh,
        child: UI.esScrollBar(
          isTvScrollRequired: isTvScrollBarRequired,
          controller: _scrollController,
          padding: padding,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
           controller: _scrollController,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index < itemLength) {
                return itemBuilder(context, index);
              } else if (AppConnectivity().isConnected) {
                return UI.singleCardShimmer(
                    height: shimmerCardHeight,
                    borderRadius: shimmerCardRadius,
                    margin: margin);
              } else if (index == itemLength) {
                /*   AppConnectivity().addToConnectionRetryQueue((){
                  _showLoading.value = true;
                  onPageEnd();
                });*/
                return paginationNoNetworkView();
              } else
                return SizedBox.shrink();
            },
          ),
        ),
      ),
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent -
                  ((Space.sp(shimmerCardHeight) + (Space.sp(margin) * 2)) *
                      (numberOfLoadingCards))) {
            if (AppConnectivity().isConnected && !isPaginationEnded) {
              onPageEnd();
            }
            return true;
          }
        }
        return true;
      },
    );
  }

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
        valueListenable: _showLoading,
        builder: (context, value, child) => value
            ? UI.singleCardShimmer(
                height: shimmerCardHeight,
                borderRadius: shimmerCardRadius,
                margin: margin)
            : commonCardView(Row(
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
                        height: Space.sp(12),
                      ),
                      UI.updatedFilledTextButtonWithMinWidth(
                        Strings.appRetryText,
                        () {
                          if (AppConnectivity().isConnected) {
                            _showLoading.value = true;
                            onPageEnd();
                          }
                        },
                      ),
                    ],
                  ))
                ],
              )),
      );
}
