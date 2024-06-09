import 'package:absen/component/event_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:absen/component/event.dart'; // Adjust the import according to your project structure

class OtherCalendar extends StatefulWidget {
  const OtherCalendar({Key? key}) : super(key: key);

  @override
  State<OtherCalendar> createState() => _OtherCalendarState();
}

class _OtherCalendarState extends State<OtherCalendar> {
  late Map<DateTime, List<nEvent>> _events;
  List<nEvent> _selectedEvents = [];
  DateTime? _selectedDay; // Allow _selectedDay to be nullable
  DateTime _focusedDay = DateTime.now();
  late Set<DateTime> _selectableDays;

  @override
  void initState() {
    super.initState();
    _initializeEvents();
    _selectableDays = _events.keys.toSet();
  }

  void _initializeEvents() {
    _events = {
      DateTime.utc(2024, 6, 1): [
        nEvent('ALFA', 'IPA', '12:00'),
        nEvent('HADIR', 'PKN', '13:00'),
      ],
      DateTime.utc(2024, 6, 2): [
        nEvent('HADIR', 'IPA', '12:00'),
      ],
      DateTime.utc(2024, 6, 3): [
        nEvent('IZIN', 'IPA', '12:00'),
      ],
      DateTime.utc(2024, 6, 4): [
        nEvent('SAKIT', 'IPA', '12:00'),
      ],
    };
  }

  List<nEvent> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  // Method to add event to the calendar
  void _addEvent(String title, String description, String time, String guru) {
    setState(() {
      nEvent newEvent = nEvent(title, description, time);
      if (_events[_selectedDay] == null) {
        _events[_selectedDay!] = [newEvent];
      } else {
        _events[_selectedDay!]!.add(newEvent);
      }
      _selectedEvents = _getEventsForDay(_selectedDay!);
      _selectableDays = _events.keys.toSet(); // Update selectable days
    });
  }

  // Custom marker builder to change the color of markers based on event status
  Widget _buildEventsMarker(DateTime date, List<dynamic> events) {
    if (events.isEmpty) return const SizedBox();

    List<Widget> markers = [];
    for (var event in events) {
      Color markerColor;
      switch (event.kStatus.toUpperCase()) {
        case 'ALFA':
          markerColor = const Color(0xffF468B7);
          break;
        case 'HADIR':
          markerColor = const Color(0xff5FD0D3);
          break;
        case 'IZIN':
          markerColor = const Color(0xffFEC85C);
          break;
        case 'SAKIT':
          markerColor = const Color(0xff8D7AEE);
          break;
        default:
          markerColor = Colors.grey;
      }

      markers.add(
        Container(
          decoration: BoxDecoration(
            color: markerColor,
            shape: BoxShape.circle,
          ),
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 0.5),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: markers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Absen ",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              backgroundColor: Colors.white,
              minimumSize: const Size(60, 60),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.zero,
                  topEnd: Radius.zero,
                  bottomStart: Radius.circular(20),
                ),
              ),
            ),
            child: const Center(
              child: Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 0, 141, 218),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 141, 218),
      body: Center(
        child: Column(
          children: [
            // Calendar Control
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // 80% of the screen width
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset:const Offset(0, 8),
                  ),
                ],
              ),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(_focusedDay.year - 10),
                lastDay: DateTime(_focusedDay.year + 10),
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    if (_selectableDays.contains(selectedDay)) {
                      if (_selectedDay == selectedDay) {
                        _selectedDay =
                            null; // Deselect if the same day is selected
                        _selectedEvents = [];
                      } else {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        _selectedEvents = _getEventsForDay(_selectedDay!);
                      }
                    }
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                eventLoader: _getEventsForDay,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  selectedDecoration:const BoxDecoration(
                    color: Color.fromARGB(255, 0, 141, 218),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration:const BoxDecoration(
                    color: Color.fromARGB(255, 53, 114, 239),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle:const  TextStyle(color: Colors.white),
                  defaultTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  todayTextStyle:const TextStyle(color: Colors.white),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 25),
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    return _buildEventsMarker(date, events);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Event Control
            Expanded(
              child: _selectedDay == null
                  ? const SizedBox() // Show nothing if no date is selected
                  : EventsList(events: _selectedEvents),
            ),
          ],
        ),
      ),
    );
  }
}
