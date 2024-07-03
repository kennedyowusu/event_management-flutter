import 'package:event_management/constants/colors.dart';
import 'package:event_management/model/event.dart';
import 'package:event_management/utils/helper.dart';
import 'package:event_management/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AllEventTickets extends StatelessWidget {
  const AllEventTickets({super.key, required this.eventModel});
  final EventModel? eventModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: CommonAppBar(
          titleText: 'Ticket',
          backgroundColor: ProjectColors.whiteColor,
          context: context,
        ),
      ),
      body: ListView.builder(
        itemCount: eventModel?.tickets?.length ?? 0,
        itemBuilder: (context, index) {
          final Tickets? ticket = eventModel?.tickets?[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Text(
                    //       ticket?.user?.name ?? 'Unknown User',
                    //     ),
                    //     const Spacer(),
                    //     Text(
                    //       ticket?.event?.title ?? 'Unknown Event',
                    //     ),
                    //   ],
                    // ),
                    // const Divider(
                    //   color: ProjectColors.greyColor,
                    // ),
                    Row(
                      children: [
                        Text(
                          ticket?.ticketType ?? 'Unknown Type',
                        ),
                        const Spacer(),
                        Text(
                          ticket?.price ?? 'Unknown Price',
                        ),
                      ],
                    ),
                    const Divider(
                      color: ProjectColors.greyColor,
                    ),
                    Row(
                      children: [
                        Text(
                          formatDate(ticket!.bookingDate!),
                        ),
                        const Spacer(),
                        Text(
                          ticket.paymentStatus ?? 'Unknown Status',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
