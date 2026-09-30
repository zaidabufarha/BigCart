import 'package:big_cart/core/card_brand.dart';
import 'package:big_cart/core/colors.dart';
import 'package:big_cart/core/widgets/lock_icon.dart';
import 'package:big_cart/core/expiry_date_formatter.dart';
import 'package:big_cart/core/fonts.dart';
import 'package:big_cart/core/validators.dart';
import 'package:big_cart/core/widgets/green_gradient_button.dart';
import 'package:big_cart/core/widgets/phone_field.dart';
import 'package:big_cart/features/account/domain/entities/address.dart';
import 'package:big_cart/features/account/domain/entities/credit_card.dart';
import 'package:big_cart/features/account/domain/entities/order.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cards_cubit.dart';
import 'package:big_cart/features/account/presentation/cubit/cubit/cubit/address_cubit.dart';
import 'package:big_cart/features/account/presentation/widgets/big_vertical_progress_indicator.dart';
import 'package:big_cart/features/buy/domain/entities/cart_item.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/cart_cubit.dart';
import 'package:big_cart/features/buy/presentation/cubit/cubit/checkout_cubit.dart';
import 'package:big_cart/features/buy/presentation/pages/order_success_page.dart';
import 'package:big_cart/features/buy/presentation/widgets/payment_card.dart';
import 'package:big_cart/features/buy/presentation/widgets/shipping_method_card.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ShippingPage extends StatefulWidget {
  final List<CartItem> list;
  const ShippingPage(this.list, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShippingPageState();
  }
}

class _ShippingPageState extends State<ShippingPage> {
  int step = 1;

  bool saveCard = false;

  final formKey = GlobalKey<FormState>();

  String selectedShippingMethod = 'Standard Delivery';

  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController addressEmailController = TextEditingController();
  final TextEditingController addressPhoneController = TextEditingController();
  // the full international number from PhoneField, for a new address
  String newAddressPhone = '';
  final TextEditingController addressStreetController =
      TextEditingController(); //bad name
  final TextEditingController addressZipController = TextEditingController();
  final TextEditingController addressCityController = TextEditingController();

  String addressCountry = 'Country';
  bool addressSave = false;

  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  bool creditCardSave = false;

  Address? selectedAddress;
  bool isNewAddress = false;

  CreditCard? selectedCreditCard;
  bool isNewCard = false;

  late Address address;
  late CreditCard creditCard;
  late Order order;

  @override
  void initState() {
    super.initState();
    context.read<AddressCubit>().attemptGetAddressesCubit();
    context.read<CardsCubit>().attemptGetCreditCards();
  }

  @override
  void dispose() {
    addressNameController.dispose();
    addressEmailController.dispose();
    addressPhoneController.dispose();
    addressStreetController.dispose();
    addressZipController.dispose();
    addressCityController.dispose();

    cardNameController.dispose();
    cardNumberController.dispose();
    cardExpiryController.dispose();
    cardCvvController.dispose();
    super.dispose();
  }

  void _populateAddress(Address addr) {
    setState(() {
      selectedAddress = addr;
      isNewAddress = false;
      addressNameController.text = addr.name;
      addressPhoneController.text = addr.phone;
      addressStreetController.text = addr.street;
      addressZipController.text = addr.zipCode;
      addressCityController.text = addr.city;
      addressCountry = addr.country.isNotEmpty ? addr.country : 'Country';
      addressSave = addr.isDefault;
    });
  }

  void _clearAddress() {
    setState(() {
      selectedAddress = null;
      isNewAddress = true;
      addressNameController.clear();
      addressEmailController.clear();
      addressPhoneController.clear();
      newAddressPhone = '';
      addressStreetController.clear();
      addressZipController.clear();
      addressCityController.clear();
      addressCountry = 'Country';
      addressSave = false;
    });
  }

  void _populateCard(CreditCard card) {
    setState(() {
      selectedCreditCard = card;
      isNewCard = false;
      cardNameController.text = card.cardHolderName;
      cardNumberController.text = '**** **** **** ${card.last4}';
      cardExpiryController.text = card.expiryDate;
      // a CVV is never stored, so a saved card has none to show
      cardCvvController.clear();
      creditCardSave = card.isDefault;
    });
  }

  void _clearCard() {
    setState(() {
      selectedCreditCard = null;
      isNewCard = true;
      cardNameController.clear();
      cardNumberController.clear();
      cardExpiryController.clear();
      cardCvvController.clear();
      creditCardSave = false;
    });
  }

  // Both lists load when checkout opens, while the shipping step is showing,
  // so the address and card steps also apply them when they come on screen,
  // not only when the load finishes. Default picked, or the form open when
  // there's nothing saved.
  void _applyAddresses(List<Address> addresses) {
    if (selectedAddress != null || isNewAddress) return;
    if (addresses.isEmpty) {
      _clearAddress();
    } else {
      _populateAddress(
        addresses.firstWhere((a) => a.isDefault, orElse: () => addresses.first),
      );
    }
  }

  void _applyCards(List<CreditCard> cards) {
    if (selectedCreditCard != null || isNewCard) return;
    if (cards.isEmpty) {
      _clearCard();
    } else {
      _populateCard(
        cards.firstWhere((c) => c.isDefault, orElse: () => cards.first),
      );
    }
  }

  void _enterStep() {
    if (step == 2) {
      context.read<AddressCubit>().state.whenOrNull(loaded: _applyAddresses);
    } else if (step == 3) {
      context.read<CardsCubit>().state.whenOrNull(loaded: _applyCards);
    }
  }

  // Only cards are wired up, so say so instead of doing nothing, like the
  // verify page does for the SMS code
  void _paymentNotAvailable(String method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$method isn't available yet"),
        content: Text(
          '$method checkout is a placeholder and not implemented. Pay with a credit card to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// A saved address or card fills its fields read-only; grey text makes it
  /// clear those are its details, not something to type into.
  TextStyle? _savedDetailStyle(bool isNew) => isNew
      ? null
      : Fonts.paragraphRegular().copyWith(color: AppColors.textSecondary);

  @override
  Widget build(BuildContext context) {
    // Neither a saved one picked nor the new form open (the list may still be
    // loading): the field checks all skip, so stop here instead of going on empty
    bool nothingChosen(bool hasSaved, bool isNew, String what) {
      if (hasSaved || isNew) return false;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Choose or add $what first')));
      return true;
    }

    void onClick() {
      if (step == 2 &&
          nothingChosen(selectedAddress != null, isNewAddress, 'an address')) {
        return;
      }
      if (step == 3 &&
          nothingChosen(selectedCreditCard != null, isNewCard, 'a card')) {
        return;
      }
      setState(() {
        if (step == 2) {
          bool isValid = formKey.currentState!.validate();
          if (isValid) {
            formKey.currentState!.save();
            if (selectedAddress != null && !isNewAddress) {
              address = selectedAddress!;
            } else {
              address = Address(
                name: addressNameController.text,
                street: addressStreetController.text,
                city: addressCityController.text,
                country: addressCountry,
                phone: newAddressPhone,
                zipCode: addressZipController.text,
                isDefault: addressSave,
              );
            }
            step++;
          }
        } else if (step == 3) {
          bool isValid = formKey.currentState!.validate();
          if (isValid) {
            formKey.currentState!.save();
            if (selectedCreditCard != null && !isNewCard) {
              creditCard = selectedCreditCard!;
            } else {
              final cleanNum = cardNumberController.text.replaceAll(' ', '');
              final last4 = cleanNum.length >= 4
                  ? cleanNum.substring(cleanNum.length - 4)
                  : cleanNum;
              creditCard = CreditCard(
                cardHolderName: cardNameController.text,
                last4: last4,
                expiryDate: cardExpiryController.text,
                isDefault: creditCardSave,
                processor: brandFromCardNumber(cleanNum),
              );
            }
            order = Order(
              orderItem: widget.list,
              datePlaced: DateTime.now(),
              address: address,
              creditCard: creditCard,
              shippingMethod: selectedShippingMethod,
            );
            context.read<CheckoutCubit>().attemptCheckOut(order);
          }
        } else {
          step++; //for step 1
        }
      });
      _enterStep();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text(
          'Add Address',
          style: Fonts.titleBold(size: 20),
        ),
      ),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: Fonts.paragraphMedium().copyWith(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            },
            orderPlaced: (order) {
              // the server emptied the cart with the order
              context.read<CartCubit>().attemptGetCart();
              // drop the cart and checkout, keep home underneath
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => OrderSuccessPage(order),
                ),
                (route) => route.isFirst,
              );
            },
          );
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        BigVerticalProgressIndicator(
                          isActive: true,
                          isFirst: true,
                          number: 1,
                          label: 'DELIVERY',
                          isComplete: (step == 1) ? false : true,
                        ),
                        BigVerticalProgressIndicator(
                          isActive: (step >= 2),
                          isFirst: false,
                          number: 2,
                          label: 'ADDRESS',
                          isComplete: (step > 2) ? true : false,
                        ),
                        BigVerticalProgressIndicator(
                          isActive: (step > 2),
                          isFirst: false,
                          number: 3,
                          label: 'PAYMENT',
                          isComplete: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: (step == 1)
                            ? Column(
                                spacing: 10.h,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedShippingMethod =
                                            'Standard Delivery';
                                      });
                                    },
                                    child: ShippingMethodCard(
                                      isSelected:
                                          (selectedShippingMethod ==
                                          'Standard Delivery'),
                                      price: 3,
                                      title: 'Standard Delivery',
                                      description:
                                          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedShippingMethod =
                                            'Next Day Delivery';
                                      });
                                    },
                                    child: ShippingMethodCard(
                                      isSelected:
                                          (selectedShippingMethod ==
                                          'Next Day Delivery'),
                                      price: 3,
                                      title: 'Next Day Delivery',
                                      description:
                                          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedShippingMethod =
                                            'Nominated Delivery';
                                      });
                                    },
                                    child: ShippingMethodCard(
                                      isSelected:
                                          (selectedShippingMethod ==
                                          'Nominated Delivery'),
                                      price: 3,
                                      title: 'Nominated Delivery',
                                      description:
                                          'Order will be delivered between 3 - 4 business days straights to your doorstep.',
                                    ),
                                  ),
                                ],
                              )
                            : (step == 2)
                            ? Column(
                                spacing: 5.h,
                                children: [
                                  BlocConsumer<AddressCubit, AddressState>(
                                    listener: (context, state) {
                                      state.whenOrNull(
                                        loaded: _applyAddresses,
                                      );
                                    },
                                    builder: (context, state) {
                                      final addresses = state.maybeWhen(
                                        loaded: (list) => list,
                                        orElse: () => <Address>[],
                                      );
                                      return DropdownButtonFormField<Address?>(
                                        key: ValueKey(
                                          selectedAddress?.id ??
                                              (isNewAddress ? 'new' : 'none'),
                                        ),
                                        initialValue: selectedAddress,
                                        isExpanded: true,
                                        hint: Text(
                                          'Select Saved Address',
                                          style: Fonts.paragraphRegular(),
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor:
                                              AppColors.backgroundPrimary,
                                          prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: AppColors.textSecondary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        items: [
                                          ...addresses.map(
                                            (
                                              addr,
                                            ) => DropdownMenuItem<Address?>(
                                              value: addr,
                                              child: Text(
                                                '${addr.name} - ${addr.street}, ${addr.city}',
                                                style: Fonts.paragraphRegular(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem<Address?>(
                                            value: null,
                                            child: Text(
                                              '+ Add New Address',
                                              style: Fonts.paragraphRegular()
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryDark,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                        onChanged: (Address? value) {
                                          if (value == null) {
                                            _clearAddress();
                                          } else {
                                            _populateAddress(value);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                  TextFormField(
                                    controller: addressNameController,
                                    readOnly: !isNewAddress,
                                    style: _savedDetailStyle(isNewAddress),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'Russel Austin',
                                        style: Fonts.paragraphRegular(),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (!isNewAddress) return null;
                                      if (value == null || value.isEmpty) {
                                        return 'Cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: addressEmailController,
                                    readOnly: !isNewAddress,
                                    style: _savedDetailStyle(isNewAddress),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.mail_outline,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'Email address',
                                        style: Fonts.paragraphRegular(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) => isNewAddress
                                        ? validateEmail(value)
                                        : null,
                                  ),
                                  // a new address picks a country and gets
                                  // checked; a saved one just shows its number
                                  if (isNewAddress)
                                    PhoneField(
                                      onChanged: (number) =>
                                          newAddressPhone = number,
                                    )
                                  else
                                    TextFormField(
                                      controller: addressPhoneController,
                                      readOnly: true,
                                      style: _savedDetailStyle(false),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.backgroundPrimary,
                                        prefixIcon: Icon(
                                          Icons.phone_outlined,
                                          color: AppColors.textSecondary,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        hint: Text(
                                          'Phone number',
                                          style: Fonts.paragraphRegular(),
                                        ),
                                      ),
                                    ),
                                  TextFormField(
                                    controller: addressStreetController,
                                    readOnly: !isNewAddress,
                                    style: _savedDetailStyle(isNewAddress),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.location_on_outlined,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'Address',
                                        style: Fonts.paragraphRegular(),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (!isNewAddress) return null;
                                      if (value == null || value.isEmpty) {
                                        return 'Cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: addressZipController,
                                    readOnly: !isNewAddress,
                                    style: _savedDetailStyle(isNewAddress),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.pin_outlined,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'Zip code',
                                        style: Fonts.paragraphRegular(),
                                      ),
                                    ),
                                    validator: (value) => isNewAddress
                                        ? validateZip(value)
                                        : null,
                                  ),
                                  TextFormField(
                                    controller: addressCityController,
                                    readOnly: !isNewAddress,
                                    style: _savedDetailStyle(isNewAddress),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.map_outlined,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'City',
                                        style: Fonts.paragraphRegular(),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (!isNewAddress) return null;
                                      if (value == null ||
                                          value.isEmpty ||
                                          addressCountry == 'Country') {
                                        return 'City and country cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  InkWell(
                                    onTap: isNewAddress
                                        ? () {
                                            showCountryPicker(
                                              context: context,
                                              showPhoneCode: false,
                                              onSelect: (Country country) {
                                                setState(() {
                                                  addressCountry = country.name;
                                                });
                                              },
                                            );
                                          }
                                        : null,
                                    child: Container(
                                      width: double.infinity,
                                      color: AppColors.backgroundPrimary,
                                      padding: EdgeInsets.all(10),
                                      height: 56.h,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            spacing: 12.w,
                                            children: [
                                              Icon(
                                                Icons.language,
                                                color: AppColors.textSecondary,
                                              ),
                                              Text(
                                                addressCountry,
                                                style:
                                                    _savedDetailStyle(
                                                      isNewAddress,
                                                    ) ??
                                                    Fonts.paragraphRegular(),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: AppColors.textSecondary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Transform.scale(
                                          alignment: Alignment.centerLeft,
                                          scale: 0.8,
                                          child: SwitchListTile(
                                            value: addressSave,
                                            title: Text(
                                              'Set as default',
                                              style: Fonts.titleBold(),
                                            ),
                                            contentPadding: EdgeInsets.all(0),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            thumbColor: WidgetStateProperty.all(
                                              Colors.white,
                                            ),
                                            trackColor: WidgetStateProperty.all(
                                              (addressSave)
                                                  ? AppColors.primaryDark
                                                  : AppColors.textSecondary,
                                            ),
                                            dense: true,
                                            visualDensity:
                                                VisualDensity.compact,
                                            trackOutlineColor:
                                                WidgetStateColor.transparent,
                                            onChanged: (isDefault) {
                                              setState(() {
                                                addressSave = isDefault;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                spacing: 8.h,
                                children: [
                                  BlocConsumer<CardsCubit, CardsState>(
                                    listener: (context, state) {
                                      state.whenOrNull(
                                        loaded: _applyCards,
                                      );
                                    },
                                    builder: (context, state) {
                                      final cards = state.maybeWhen(
                                        loaded: (list) => list,
                                        orElse: () => <CreditCard>[],
                                      );
                                      return DropdownButtonFormField<
                                        CreditCard?
                                      >(
                                        key: ValueKey(
                                          selectedCreditCard?.id ??
                                              (isNewCard ? 'new' : 'none'),
                                        ),
                                        initialValue: selectedCreditCard,
                                        isExpanded: true,
                                        isDense: true,
                                        hint: Text(
                                          'Select Saved Card',
                                          style: Fonts.paragraphRegular(),
                                        ),
                                        decoration: InputDecoration(
                                          // compact, so the pay button fits
                                          // without scrolling
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                          ),
                                          filled: true,
                                          fillColor:
                                              AppColors.backgroundPrimary,
                                          prefixIcon: Icon(
                                            Icons.credit_card_outlined,
                                            color: AppColors.textSecondary,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        items: [
                                          ...cards.map(
                                            (
                                              card,
                                            ) => DropdownMenuItem<CreditCard?>(
                                              value: card,
                                              child: Text(
                                                '${card.processor.name.toUpperCase()} (**** ${card.last4}) - ${card.cardHolderName}',
                                                style: Fonts.paragraphRegular(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem<CreditCard?>(
                                            value: null,
                                            child: Text(
                                              '+ Add New Card',
                                              style: Fonts.paragraphRegular()
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryDark,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                        onChanged: (CreditCard? value) {
                                          if (value == null) {
                                            _clearCard();
                                          } else {
                                            _populateCard(value);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                  // three squares spread evenly across the
                                  // width; cards are the only method that works
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        PaymentCard(
                                          path: 'assets/paypal_grey.svg',
                                          text: 'Paypal',
                                          onTap: () =>
                                              _paymentNotAvailable('PayPal'),
                                        ),
                                        PaymentCard(
                                          path: 'assets/card_grey.svg',
                                          text: 'Credit Card',
                                          selected: true,
                                          onTap: () {},
                                        ),
                                        PaymentCard(
                                          path: 'assets/apple_grey.svg',
                                          text: 'Apple Pay',
                                          onTap: () =>
                                              _paymentNotAvailable('Apple Pay'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/card_picture.png',
                                  ),
                                  TextFormField(
                                    controller: cardNameController,
                                    readOnly: !isNewCard,
                                    style: _savedDetailStyle(isNewCard),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'Russel Austin',
                                        style: Fonts.paragraphRegular(),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (!isNewCard) return null;
                                      if (value == null || value.isEmpty) {
                                        return 'Cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    controller: cardNumberController,
                                    readOnly: !isNewCard,
                                    style: _savedDetailStyle(isNewCard),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.backgroundPrimary,
                                      prefixIcon: Icon(
                                        Icons.credit_card_outlined,
                                        color: AppColors.textSecondary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hint: Text(
                                        'XXXX XXXX XXXX 5678',
                                        style: Fonts.paragraphRegular(),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) => isNewCard
                                        ? validateCardNumber(value)
                                        : null,
                                  ),
                                  Row(
                                    spacing: 10.w,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: cardExpiryController,
                                          readOnly: !isNewCard,
                                          style: _savedDetailStyle(isNewCard),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            ExpiryDateFormatter(),
                                          ],
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                AppColors.backgroundPrimary,
                                            prefixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: AppColors.textSecondary,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                            ),
                                            hint: Text(
                                              'MM/YY',
                                              style: Fonts.paragraphRegular(),
                                            ),
                                          ),
                                          validator: (value) => isNewCard
                                              ? validateExpiry(value)
                                              : null,
                                        ),
                                      ),
                                      // only for a new card: nothing is
                                      // stored to show for a saved one
                                      if (isNewCard)
                                        Expanded(
                                          child: TextFormField(
                                            controller: cardCvvController,
                                            readOnly: !isNewCard,
                                            style: _savedDetailStyle(isNewCard),
                                            keyboardType:
                                                TextInputType.numberWithOptions(),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor:
                                                  AppColors.backgroundPrimary,
                                              prefixIcon: const LockIcon(
                                                color: AppColors.textSecondary,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                              ),
                                              hint: Text(
                                                '908',
                                                style: Fonts.paragraphRegular(),
                                              ),
                                            ),
                                            validator: (value) => isNewCard
                                                ? validateCvv(value)
                                                : null,
                                          ),
                                        ),
                                    ],
                                  ),
                                  // a compact switch row rather than a full
                                  // list tile, so the pay button stays in view
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Row(
                                      spacing: 10.w,
                                      children: [
                                        SizedBox(
                                          width: 44.w,
                                          height: 26.h,
                                          child: FittedBox(
                                            child: Switch(
                                              value: creditCardSave,
                                              thumbColor:
                                                  WidgetStateProperty.all(
                                                    Colors.white,
                                                  ),
                                              trackColor:
                                                  WidgetStateProperty.all(
                                                    (creditCardSave)
                                                        ? AppColors.primaryDark
                                                        : AppColors
                                                              .textSecondary,
                                                  ),
                                              trackOutlineColor:
                                                  WidgetStateColor.transparent,
                                              onChanged: (save) {
                                                setState(() {
                                                  creditCardSave = save;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Set as default',
                                          style: Fonts.titleBold(size: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 8.h, 20, 20),
                child: GreenGradientButton(
                  onClick,
                  (step == 3) ? 'Make a payment' : 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
