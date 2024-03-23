import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilWidget {
  static Widget buildLoading({
    Color? colorIcon,
  }) =>
      CupertinoActivityIndicator(
        color: colorIcon,
      );

  // static Widget buildShimmerLoading() {
  //   const padding = AppDimens.defaultPadding;
  //   return Container(
  //     width: double.infinity,
  //     padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       children: <Widget>[
  //         Expanded(
  //           child: Shimmer.fromColors(
  //             baseColor: Colors.grey.shade400,
  //             highlightColor: Colors.grey.shade100,
  //             enabled: true,
  //             child: ListView.separated(
  //               itemBuilder: (context, index) => Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   Container(
  //                     width: double.infinity,
  //                     height: 24.0,
  //                     decoration: const BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.all(
  //                         Radius.circular(10),
  //                       ),
  //                     ),
  //                   ),
  //                   sizedBox10,
  //                   Row(
  //                     children: [
  //                       Expanded(
  //                         child: Container(
  //                           height: 16.0,
  //                           decoration: const BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.all(
  //                               Radius.circular(10),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(
  //                         width: 30,
  //                       ),
  //                       Expanded(
  //                         child: Container(
  //                           height: 16.0,
  //                           decoration: const BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.all(
  //                               Radius.circular(10),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   sizedBox10,
  //                 ],
  //               ),
  //               separatorBuilder: (context, index) => const Divider(
  //                 height: 15,
  //               ),
  //               itemCount: 10,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
