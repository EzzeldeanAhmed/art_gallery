import 'package:art_gallery/core/helper_functions/build_error_bar.dart';
import 'package:art_gallery/core/models/cart_model.dart';
import 'package:art_gallery/core/models/exhibition_entity.dart';
import 'package:art_gallery/core/models/ticket_entity.dart';
import 'package:art_gallery/core/repos/ticket_repo/ticket_repo.dart';
import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/core/ticket_cubit/ticket_cubit.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CartCheckoutPage extends StatefulWidget {
  CartCheckoutPage({super.key, required this.cartModel});

  CartModel cartModel;
  @override
  _CartCheckoutPageState createState() => _CartCheckoutPageState();
}

Map<String, Map<String, String>> validCardNumbers = {
  '4111 1111 1111 1111': {
    'cvv': '123',
    'expiryDate': '04/28',
    'cardHolderName': 'Ezzeldean Ahmed',
  },
  '2300 0000 0000 0000': {
    'cvv': '123',
    'expiryDate': '04/28',
    'cardHolderName': 'Ezzeldean Ahmed'
  },
  '3400 0000 0000 0009': {
    'cvv': '123',
    'expiryDate': '04/28',
    'cardHolderName': 'Ezzeldean Ahmed',
  },
};

class _CartCheckoutPageState extends State<CartCheckoutPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Color themeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketCubit(getIt.get<TicketRepo>()),
      child: BlocConsumer<TicketCubit, TicketState>(listener: (context, state) {
        if (state is TicketSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SuccessPage(),
            ),
          );
          buildErrorBar(context, 'Ticket booked successfully');
        }
        if (state is TicketFailure) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FailurePage(),
            ),
          );
          buildErrorBar(context, state.errMessage);
        }
      }, builder: (context, state) {
        return _checkoutForm(context);
      }),
    );
  }

  Scaffold _checkoutForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay with Card",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Purchase Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Text("Item: ${widget.exhibition.name} Exhibition Ticket"),
                    // Text("Quantity: ${widget.ticketQuantity}"),
                    // Text("Price: \$${widget.exhibition.ticketPrice}"),
                    // Divider(),
                    // Text(
                    //   "Total: \$${widget.exhibition.ticketPrice * widget.ticketQuantity}",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (CreditCardBrand brand) {},
                obscureCardCvv: false,
                obscureCardNumber: false,
                obscureInitialCardNumber: false,
                isHolderNameVisible: true,
                height: 180,
                width: 300,
              ),
              CreditCardForm(
                formKey: formKey,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (CreditCardModel data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    isCvvFocused = data.isCvvFocused;
                  });
                },
                cardNumberValidator: (String? value) {
                  if (value == null || value.isEmpty || value.length < 19) {
                    return "Enter a valid card number";
                  }
                  return null;
                },
                expiryDateValidator: (String? value) {
                  if (value == null || value.isEmpty
                      // ||              !RegExp(r'^(0[1-9]|1[0-2])\/(\d{2})\$').hasMatch(value)
                      ) {
                    return "Enter a valid expiry date";
                  }
                  return null;
                },
                cardHolderValidator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Enter the cardholder's name";
                  }
                  return null;
                },
                cvvValidator: (String? value) {
                  if (value == null || value.isEmpty || value.length != 3) {
                    return "Enter a valid CVV";
                  }
                  return null;
                },
                themeColor: themeColor,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.red),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (!validCardNumbers.containsKey(cardNumber) ||
                            validCardNumbers[cardNumber]!['cvv'] != cvvCode) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FailurePage(),
                            ),
                          );
                        } else {
                          // var user = getIt.get<AuthRepo>().getSavedUserData();
                          // TicketEntity ticket = TicketEntity(
                          //   exhibitionId: widget.exhibition.id!,
                          //   quantity: widget.ticketQuantity,
                          //   bookedDate: DateTime.now(),
                          //   userId: user.uId,
                          // );
                          // context.read<TicketCubit>().addTicket(ticket: ticket);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Please enter valid card details!")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      backgroundColor: Color(0xff1F5E3B),
                    ),
                    child: Text(
                      "Pay \$",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Successful"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text(
              "Your payment was successful!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}

class FailurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Failed"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red, size: 100),
            SizedBox(height: 20),
            Text(
              "Your payment failed!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }
}
