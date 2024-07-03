import 'package:dio/dio.dart';
import 'package:event_management/constants/colors.dart';
import 'package:event_management/constants/images.dart';
import 'package:event_management/model/event.dart';
import 'package:event_management/utils/helper.dart';
import 'package:event_management/view/review.dart';
import 'package:event_management/view/reviews.dart';
import 'package:event_management/view/tickets.dart';
import 'package:event_management/widgets/feedback/feedback_message.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    Container container = Container(
      height: 10,
      width: 2,
      color: ProjectColors.greyColor,
    );

    final double width = MediaQuery.sizeOf(context).width;
    double averageRating = calculateAverageRating(eventModel.reviews!);

    Future<void> attendEvent(BuildContext context) async {
      try {
        final response = await Dio().post(
          'http://192.168.1.109:8000/api/events/${eventModel.id}/attend',
          data: {
            'ticket_type': 'Regular',
            'price': 200,
            'payment_status': 'Paid',
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${GetStorage().read('token')}',
            },
          ),
        );

        if (response.statusCode == 201) {
          FeedbackMessage.showSnackBar(
              context, 'You have successfully attended the event.');
        } else {
          FeedbackMessage.showSnackBar(context, 'Failed to attend the event.');
        }
      } catch (e) {
        print("$e");
        FeedbackMessage.showSnackBar(
            context, "You have already attended this event");
      }
    }

    return Scaffold(
      bottomSheet: Container(
        height: 50.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ProjectColors.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                attendEvent(context);
              },
              child: const Text(
                'Attend Event',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            container,
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewView(eventModel: eventModel),
                  ),
                );
              },
              child: const Text(
                'Review Event',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: AssetImage(
                      // eventModel.image!,
                      images[0]),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            color: ProjectColors.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      SizedBox(width: width * 0.2),
                      Text(
                        'Event Details',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      SizedBox(width: width * 0.2),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          averageRating.toStringAsFixed(1),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: ProjectColors.primaryColor,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventModel.title!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                        const Divider(
                          color: ProjectColors.greyColor,
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllEventTickets(
                                      eventModel: eventModel,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Tickets: ${eventModel.tickets!.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllReviewSView(
                                      eventModel: eventModel,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Reviews: ${eventModel.reviews!.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: ProjectColors.primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        eventModel.venue!,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                      ),
                      const SizedBox(width: 10.0),
                      container,
                      const SizedBox(width: 10.0),
                      const Icon(
                        Icons.access_time,
                        color: ProjectColors.primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        eventModel.time!,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                      ),
                      const SizedBox(width: 10.0),
                      container,
                      const SizedBox(width: 10.0),
                      const Icon(
                        Icons.calendar_today,
                        color: ProjectColors.primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        formatDate(eventModel.date!),
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Divider(
                    color: ProjectColors.greyColor,
                  ),
                  Text(
                    eventModel.description!,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
