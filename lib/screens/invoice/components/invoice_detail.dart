import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/model/invoice_model.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:provider/provider.dart';

class InvoiceDetail extends StatefulWidget {
  final String? id;
  const InvoiceDetail({Key? key, this.id}) : super(key: key);

  @override
  _InvoiceDetailState createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {
  InvoiceModel? invoice;
  @override
  void initState() {
    super.initState();
    invoice = context.read<Invoice>().findInvoiceById(widget.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Số hóa đơn:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15),
                  Text(
                    '#${invoice?.id}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(DateFormat('MM-yyyy').format(invoice!.invoiceDate!)),
              Divider(thickness: 1),
              Text('Người nộp'),
              _buildRow('${invoice?.name} ', ' ${invoice?.roomName}'),
              Divider(thickness: 1),
              _buildRow('Tiền phòng', '${invoice?.roomCost}'),
              _buildRow(
                  'Điện(Số cũ: ${invoice?.electUse?.lastNumber} , Số mới: ${invoice?.electUse?.currentNumber}) ',
                  ' ${invoice?.priceEclect}'),
              _buildRow(
                  'Nước(Số cũ: ${invoice?.waterUse?.lastNumber} , Số mới: ${invoice?.waterUse?.currentNumber}) ',
                  ' ${invoice?.waterCost}'),
              _buildRow('Tiền phạt', '${invoice?.punishPrice}'),
              _buildRow('Giảm giá', '${invoice?.discount}'),
              _buildRow('Dịch vụ khác', '${invoice?.priceMoreService}'),
              Divider(),
              _buildRow('Tổng', '${invoice?.totalAmount}'),
            ],
          ),
        ),
      ),
    );
  }

  _buildRow(String? title, String? desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          Text(
            desc ?? '',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
