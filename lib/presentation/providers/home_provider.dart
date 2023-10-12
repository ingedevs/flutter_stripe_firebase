import 'package:fl_stripe/config/constants.dart';
import 'package:fl_stripe/config/routes.dart';
import 'package:fl_stripe/presentation/pages/success_page.dart';
import 'package:fl_stripe/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  final Ref ref;

  HomeNotifier(this.ref) : super(HomeState()) {
    _initialize();
  }

  void _initialize() async {
    Stripe.publishableKey = stripePublishableKey;
    await Stripe.instance.applySettings();
  }

  void onChangeCard(CardFieldInputDetails? value) {
    state = state.copyWith(card: value);
  }

  Future<void> onSubmit() async {
    state = state.copyWith(status: FormStatus.submitting);
    await Future.delayed(const Duration(seconds: 1));

    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      final response = await StripeService.createPaymentIntent(
        paymentMethodId: paymentMethod.id,
        amount: state.product['price'],
        currency: state.product['currency'],
      );

      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: response.clientSecret ?? '',
        data: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(),
          ),
        ),
      );

      if (paymentIntent.status != PaymentIntentsStatus.Succeeded) {
        state = state.copyWith(status: FormStatus.failure);
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(content: Text('Payment failed')),
        );
        return;
      }

      state = state.copyWith(status: FormStatus.success);
      await Future.delayed(const Duration(seconds: 1), () {
        ref.read(controllerProvider).clear();
        navigatorKey.currentContext!.push(SuccessPage.routePath);
      });
      //-
    } on StripeException catch (e) {
      state = state.copyWith(status: FormStatus.failure);
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text(e.error.message ?? 'Something went wrong')),
      );
    } catch (e) {
      state = state.copyWith(status: FormStatus.failure);
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    } finally {
      await Future.delayed(const Duration(seconds: 1), () {
        state = state.copyWith(status: FormStatus.initial);
      });
    }
  }
}

class HomeState {
  final CardFieldInputDetails? card;
  final FormStatus status;

  Map<String, dynamic> product = {
    'name': 'Logitech M100 Mouse',
    'price': 1000,
    'currency': 'mxn',
  };

  HomeState({
    this.card,
    this.status = FormStatus.initial,
  });

  HomeState copyWith({
    CardFieldInputDetails? card,
    FormStatus? status,
  }) {
    return HomeState(
      card: card ?? this.card,
      status: status ?? this.status,
    );
  }
}

enum FormStatus { initial, submitting, success, failure }

final controllerProvider = Provider<CardEditController>((ref) {
  return CardEditController();
});
