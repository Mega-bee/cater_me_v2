import 'package:cater_me_v2/module_credits/request/create_credit_request.dart';
import 'package:cater_me_v2/module_credits/ui/widget/create_credit_sheet.dart';
import 'package:cater_me_v2/module_payments/request/payment_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tip_dialog/tip_dialog.dart';
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
  int? orderId;

  @override
  void initState() {
    super.initState();
    widget.cubit.getCredits(this);
  }

  createCredit(CreateCreditRequest request) {
    widget.cubit.createCredit(this, request);
  }
  requestPayment(PaymentTypeRequest request) {
    print(orderId);
    request.orderId = orderId;
    widget.cubit.paymentRequest(this, request);
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
    var args = ModalRoute.of(context)?.settings.arguments;
    if(args != null && args is int){
      orderId = args;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Select payment method'),
        actions: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return  CreateCreditSheet(createCredit: (request){
                      Navigator.pop(context);
                      widget.cubit.createCredit(this, request);
                    },);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
                  isScrollControlled: true,
                  elevation: 5);
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 25),
              child: Icon(Icons.add_comment),
            ),
          )
        ],
      ),
      body: BlocBuilder<PaymentCubit, States>(
        bloc: widget.cubit,
        builder: (context, state) {
          return Stack(
            children: [
              state.getUI(context),
              TipDialogContainer(
                  duration: const Duration(seconds: 2),
                  outsideTouchable: true,
                  onOutsideTouch: (Widget tipDialog) {
                    if (tipDialog is TipDialog &&
                        tipDialog.type == TipDialogType.LOADING) {
                      TipDialogHelper.dismiss();
                    }
                  })
            ],
          );
        },
      ),
    );
  }
}
