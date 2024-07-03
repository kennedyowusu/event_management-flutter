import 'package:event_management/widgets/feedback/feedback_message.dart';
import 'package:flutter/material.dart';
import 'package:event_management/network_helpers/http_service.dart';
import 'package:event_management/model/event.dart';
import 'package:event_management/widgets/app_bar.dart';
import 'package:event_management/widgets/buttons/project_button.dart';
import 'package:event_management/widgets/decorations.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({
    super.key,
    required this.eventModel,
  });

  final EventModel eventModel;

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  final GlobalKey<FormState> reviewKey = GlobalKey<FormState>();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  bool processing = false;

  @override
  void dispose() {
    reviewController.dispose();
    rateController.dispose();
    super.dispose();
  }

  Future<void> submitReview() async {
    setState(() {
      processing = true;
    });

    if (reviewKey.currentState!.validate()) {
      try {
        HttpService httpService = HttpService();

        Map<String, dynamic> reviewData = {
          "comment": reviewController.text.trim(),
          "event_id": widget.eventModel.id,
          "rating": int.parse(rateController.text.trim()),
        };

        Map<String, dynamic> response =
            await httpService.saveReview(reviewData);

        if (response['status'] == "success") {
          Navigator.pop(context);
          // fetchReviews();
        } else {
          setState(() {
            processing = false;
          });

          FeedbackMessage.showSnackBar(
            context,
            response['message'],
          );
        }
      } catch (e) {
        FeedbackMessage.showSnackBar(
          context,
          'An error occurred, please try again!',
        );
      } finally {
        setState(() {
          processing = false;
        });
      }
    } else {
      setState(() {
        processing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          75,
        ),
        child: CommonAppBar(
          titleText: 'Review Event',
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () {
            Navigator.pop(context);
          },
          context: context,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Form(
            key: reviewKey,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "You are reviewing ${widget.eventModel.title!} event",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your rating';
                    }
                    int? rating = int.tryParse(value);
                    if (rating == null || rating < 1 || rating > 5) {
                      return 'Please enter a valid rating between 1 and 5';
                    }
                    return null;
                  },
                  decoration: CustomInputDecorator.textFieldStyle(
                    label: 'Rating',
                    dense: true,
                    maxLines: 1,
                    hint: '4',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: reviewController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your review';
                    }
                    return null;
                  },
                  decoration: CustomInputDecorator.textFieldStyle(
                    label: 'Review',
                    dense: true,
                    maxLines: 5,
                    hint: 'Write your review here',
                  ),
                ),
                const SizedBox(height: 20),
                processing
                    ? const CircularProgressIndicator()
                    : ProjectButton(
                        buttonText: 'Submit',
                        onTap: submitReview,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
