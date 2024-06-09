// events_list.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'event.dart';

class EventsList extends StatelessWidget {
  final List<nEvent> events;

  const EventsList({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          Color eventColor;
          var sizedBoxAttribute;
          var sizedBoxStatus;

          // Determine the color based on the event status
          switch (events[index].kStatus.toUpperCase()) {
            case 'ALFA':
              eventColor = const Color(0xffF468B7);
              sizedBoxAttribute = 20;
              sizedBoxStatus = 6;
              break;
            case 'HADIR':
              eventColor = const Color(0xff5FD0D3);
              sizedBoxAttribute = 20;
              sizedBoxStatus = 0;
              break;
            case 'IZIN':
              eventColor = const Color(0xffFEC85C);
              sizedBoxAttribute = 20;
              sizedBoxStatus = 6;
              break;
            case 'SAKIT':
              eventColor = const Color(0xff8D7AEE);
              sizedBoxAttribute = 20;
              sizedBoxStatus = 0;
              break;
            default:
              eventColor = Colors.grey;
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border:
                  Border.all(color: eventColor), // Use event color for border
              borderRadius: BorderRadius.circular(12),
              color: eventColor
                  .withOpacity(0.1), // Light background color based on status
            ),
            child: ListTile(
              title: Row(
                children: [
                  SizedBox(
                    width: sizedBoxStatus,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      events[index].kStatus,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: eventColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sizedBoxStatus,
                  ),
                  Container(
                    width: 5,
                    height: 30,
                    decoration: BoxDecoration(
                      color: eventColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  SizedBox(
                    width: sizedBoxAttribute,
                  ),
                  Text(
                    "${events[index].kTime}",
                    style: TextStyle(color: eventColor),
                  ),
                  SizedBox(
                    width: sizedBoxAttribute,
                  ),
                  Center(
                    child: Row (
                      children: [
                        Text(
                          events[index].kSubject,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: eventColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
