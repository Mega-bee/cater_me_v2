import 'package:cater_me_v2/generated/l10n.dart';
import 'package:cater_me_v2/module_credits/request/create_credit_request.dart';
import 'package:cater_me_v2/module_credits/ui/widget/create_credit_sheet.dart';
import 'package:cater_me_v2/module_home/ui/widget/custom_action_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../abstracts/states/state.dart';
import '../../state_manager/payment_state_manager.dart';

@injectable
class PaymentMethodScreen extends StatefulWidget {
  final PaymentCubit cubit;

  const PaymentMethodScreen(
    this.cubit,
  );

  @override
  State<PaymentMethodScreen> createState() => PaymentMethodScreenState();
}

class PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getCredits(this);
  }

  createCredit(CreateCreditRequest request) {
    widget.cubit.createCredit(this, request);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select payment method'),
      ),
      body: BlocBuilder<PaymentCubit, States>(
        bloc: widget.cubit,
        builder: (context, state) {
          return state.getUI(context);
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(30, 1, 30, 1),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius:
              BorderRadius.all(  Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text('Pay now' , style: TextStyle(color: Colors.white),),
              Text('1000 SAR',style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
            ],),
          )),
      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
