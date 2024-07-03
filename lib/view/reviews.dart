import 'package:dio/dio.dart';
import 'package:event_management/widgets/feedback/feedback_message.dart';
import 'package:flutter/material.dart';
import 'package:event_management/constants/colors.dart';
import 'package:event_management/model/event.dart';
import 'package:event_management/widgets/app_bar.dart';
import 'package:get_storage/get_storage.dart';

class AllReviewSView extends StatefulWidget {
  const AllReviewSView({
    super.key,
    this.eventModel,
  });
  final EventModel? eventModel;

  @override
  State<AllReviewSView> createState() => _AllReviewSViewState();
}

class _AllReviewSViewState extends State<AllReviewSView> {
  late List<Reviews> reviews;

  @override
  void initState() {
    super.initState();
    reviews = widget.eventModel?.reviews ?? [];
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      Dio dio = Dio();

      Response response = await dio.get(
        'http://192.168.1.109:8000/api/events/${widget.eventModel?.id}/reviews',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${GetStorage().read('token')}',
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          reviews = (response.data as List)
              .map((reviewJson) => Reviews.fromJson(reviewJson))
              .toList();
        });
      } else {
        FeedbackMessage.showSnackBar(
            context, "Failed to fetch reviews. Please try again later.");
      }
    } catch (e) {
      FeedbackMessage.showSnackBar(
          context, "You have reviewed this event already");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CommonAppBar(
          titleText: 'All Reviews',
          backgroundColor: ProjectColors.whiteColor,
          context: context,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.eventModel?.reviews?.length ?? 0,
        itemBuilder: (context, index) {
          final Reviews? review = widget.eventModel?.reviews?[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ProjectColors.whiteColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: ProjectColors.greyColor.withOpacity(0.5),
                    blurRadius: 5.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.person),
                // title: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       review?.user?.name ?? 'Unknown User',
                //       style: Theme.of(context).textTheme.displaySmall!.copyWith(
                //             color: ProjectColors.blackColor,
                //             fontSize: 12,
                //           ),
                //     ),
                //     SizedBox(width: MediaQuery.sizeOf(context).width * 0.1),
                //     Text(
                //       review?.rating.toString() ?? '0',
                //     ),
                //   ],
                // ),
                title: Text(
                  review?.comment ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: ProjectColors.blackColor,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
