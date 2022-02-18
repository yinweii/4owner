import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/model/expense_model.dart';
import 'package:owner_app/provider/expense_provider.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  TextEditingController _nameExpense = TextEditingController();
  TextEditingController _priceExpense = TextEditingController();
  TextEditingController _noteExpense = TextEditingController();
  DateTime dateSelect = DateTime.now();
  void _onSubmit() async {
    var newExpense = ExpenseModel(
      id: MinId.getId(),
      name: _nameExpense.text,
      price: double.parse(_priceExpense.text),
      note: _noteExpense.text,
      date: DateFormat('MM-yyyy').format(dateSelect),
    );

    await context.read<Expense>().addExpense(newExpense).then((value) {
      cleanForm();
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Expense>().getAllExpense();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Khoản chi',
          style: AppTextStyles.defaultBoldAppBar,
        ),
        actions: [
          IconButton(
            onPressed: () => showDialogService(context, MinId.getId()),
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      dateSelect =
                          DateTime(dateSelect.year, dateSelect.month - 1);

                      ;
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Text(
                  '${DateFormat('MM-yyyy').format(dateSelect)}',
                  style: AppTextStyles.defaultBold,
                ),
                IconButton(
                  onPressed: _onCheckNext(dateSelect)
                      ? () {
                          setState(() {
                            dateSelect =
                                DateTime(dateSelect.year, dateSelect.month + 1);
                            ;
                          });
                        }
                      : null,
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
            _buildBody(
              month: DateFormat('MM-yyyy').format(dateSelect),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody({required String month}) {
    var listExpense = context.read<Expense>().getExpenseByMonth(month: month);
    return context.watch<Expense>().showLoading
        ? circularProgress()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: listExpense.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: AppColors.primary,
                    ),
                    title: Text(listExpense[index].name ?? ''),
                    subtitle: Text(
                      Utils.convertPrice(listExpense[index].price),
                    ),
                  ),
                ),
              );
            },
          );
  }

  bool _onCheckNext(DateTime currentDate) {
    if (DateFormat('MM-yyyy')
        .format(currentDate)
        .contains(DateFormat('MM-yyyy').format(DateTime.now()))) {
      return false;
    }
    return true;
  }

  void showDialogService(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              actions: [
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Thêm khoản chi",
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: _nameExpense,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Tên khoản chi'),
                      ),
                      TextField(
                        controller: _priceExpense,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Giá'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _noteExpense,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Note'),
                      ),
                      const Divider(
                        height: 10,
                      ),
                      const Divider(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.red,
                            ),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: _onSubmit,
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                            ),
                            child: const Text('Save'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void cleanForm() {
    _nameExpense.clear();
    _noteExpense.clear();
    _priceExpense.clear();
  }
}
