import 'package:fl_stripe/config/constants.dart';
import 'package:fl_stripe/presentation/providers/home_provider.dart';
import 'package:fl_stripe/presentation/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class HomePage extends ConsumerWidget {
  static String routePath = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme;

    final provider = ref.watch(homeProvider);
    final card = provider.card;
    final status = provider.status;
    final product = provider.product;

    Widget buildButton() {
      Widget child = Text(
        'Stripe \$${product['price']} MXN',
        style: const TextStyle(fontSize: 18),
      );
      if (status == FormStatus.submitting) {
        child = const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        );
      }
      if (status == FormStatus.success) {
        child = const Icon(Icons.check, color: Colors.white);
      }
      if (status == FormStatus.failure) {
        child = const Icon(Icons.close, color: Colors.white);
      }
      return CustomFilledButton(
        onPressed: card?.complete ?? false
            ? ref.read(homeProvider.notifier).onSubmit
            : null,
        child: child,
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(defaultPadding),
                  child: Flexible(
                    child: Text(
                      product['name'],
                      style: style.headlineMedium,
                    ),
                  ),
                ),
                SizedBox(height: defaultPadding),
                CardField(
                  controller: ref.read(controllerProvider),
                  onCardChanged: ref.read(homeProvider.notifier).onChangeCard,
                  dangerouslyGetFullCardDetails: true,
                ),
                SizedBox(height: defaultPadding),
                buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
