// here we can see the detail of our wheels that it is handed over to hirer or not

import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/views/account/booked_wheels/components/booking_placed_details.dart';
import 'package:getanywheels/views/account/booked_wheels/components/booking_status.dart';

//importing below package for date
import 'package:intl/intl.dart' as intl;

class BookingsDetails extends StatelessWidget {
  final dynamic data;

  const BookingsDetails({this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Booking Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ///ICONS.....
        
              //this below confirmation is from user when he placed booking
              bookingStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Booking Placed",
                  showDone: data['booking_placed']),
              //this below confirmation is from agency or individual....
              bookingStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Booking Confirmed",
                  showDone: data['booking_confirmed']),
              //this will active when wheels is hired by hirer
              bookingStatus(
                  color: Colors.green,
                  icon: Icons.car_rental,
                  title: "Wheel Hired",
                  showDone: data['wheel_hiried']),
        
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  bookingPlacedDetails(
                    d1: data['booking_code'],
                    d2: data['hiring_method'],
                    title1: "Booking Code",
                    title2: "Hiring Method",
                  ),
                  bookingPlacedDetails(
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format((data['booking_date'].toDate())),
                    d2: data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method",
                  ),
                  bookingPlacedDetails(
                    d1: "Unpaid Yet!",
                    d2: "Booking Placed",
                    title1: "Payment Status",
                    title2: "Booking Status",
                  ),
        
                  ///this row is for hirer address...
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Hirer Address".text.fontFamily(bold).make(),
                            "${data['booking_by_name']}".text.make(),
                            "${data['booking_by_email']}".text.make(),
                            "${data['booking_by_address']}".text.make(),
                            "${data['booking_by_city']}".text.make(),
                            "${data['booking_by_state']}".text.make(),
                            "${data['booking_by_phone']}".text.make(),
                            "${data['booking_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              20.heightBox,
              ///BOOKED Wheels detail screen
              "Booked Wheels".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['bookings'].length, (index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bookingPlacedDetails(
                      title1: data['bookings'][index]['title'],
                      title2: data['bookings'][index]['wprice'],
                      d1:  "${data['bookings'][index]['days']} day",
                      d2:  "Refundable",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: 30,
                        height: 10,
                        color: Color(data['bookings'][index]['color']),
                      ),
                    ),
                    const Divider(),
                    
                    ],
                  );
                }).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,

            ],
          ),
        ),
      ),
    );
  }
}
