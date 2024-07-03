import 'package:event_management/utils/helper.dart';
import 'package:event_management/widgets/feedback/feedback_message.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:event_management/constants/colors.dart';
import 'package:event_management/model/event.dart';
import 'package:event_management/widgets/app_bar.dart';
import 'package:get_storage/get_storage.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<EventModel> attendedEvents = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceHistory();
  }

  Future<void> fetchAttendanceHistory() async {
    try {
      final response = await Dio().get(
        'http://192.168.1.109:8000/api/user/attendance-history',
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
          attendedEvents = (response.data as List)
              .map((item) => EventModel.fromJson(item['event']))
              .toList();
        });
      } else {
        print('Failed to fetch attendance history');
        FeedbackMessage.showSnackBar(context,
            "Failed to fetch attendance history. Please try again later.");
      }
    } catch (e) {
      print('Error fetching attendance history: $e');
      FeedbackMessage.showSnackBar(context,
          "Failed to fetch attendance history. Please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: CommonAppBar(
          titleText: 'Attendance History',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () {
            Navigator.pop(context);
          },
          context: context,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: ListView.separated(
          itemCount: attendedEvents.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            EventModel event = attendedEvents[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title ?? 'Event Title',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        formatDate(event.date!),
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                      ),
                      const Spacer(),
                      Text(
                        event.time ?? 'Event Time',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    color: ProjectColors.greyColor,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Thanks for Attending!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
