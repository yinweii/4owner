import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:min_id/min_id.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/components/footer_button.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/app_colors.dart';
import 'package:owner_app/constants/app_text.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/model/invoice_model.dart';
import 'package:owner_app/model/more_service_model.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:owner_app/model/service_models.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/screens/invoice/components/service_item.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({Key? key}) : super(key: key);

  @override
  _AddInvoiceState createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  CustomerModel? customerUser;
  final _formKey = GlobalKey<FormState>();

  //Electricity controller
  TextEditingController _controllerElectLast = TextEditingController();
  TextEditingController _controllerElectCurent = TextEditingController();
  TextEditingController _controllerElectPrice = TextEditingController();

  //water
  TextEditingController _controllerWaterLast = TextEditingController();
  TextEditingController _controllerWaterCurent = TextEditingController();
  TextEditingController _controllerWaterPrice = TextEditingController();

  //service
  TextEditingController _serviceName = TextEditingController();
  TextEditingController _servicePrice = TextEditingController();
  TextEditingController _serviceNote = TextEditingController();

  //toal amount
  TextEditingController _tienPhat = TextEditingController();
  TextEditingController _giamGia = TextEditingController();

  double? amount;
  double? amountWater;

  //controller
  TextEditingController _priceController = TextEditingController();

  String? selectedValue = null;
  DateTime? selectedFirstDate;
  DateTime? selectedSecondDate;
  DateTime? _selectedDate;

  RoomModel? roomModel;
  List<MoreServiceModel> moreService = [];
  // List<MoreServiceModel> moreService() {
  //   list = context.watch<MoreService>().moreServiceList;
  //   print('LIST: ${list.toString()}');
  //   return list ?? [];
  // }

  Future<void> getCustommer() async {
    await context.read<Customer>().getListCustomer();
    //await context.read<RoomProvider>().getRoom();
  }

  // get date
  void _selectDate(bool isFirstDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null &&
        (picked != selectedFirstDate || picked != selectedSecondDate))
      setState(() {
        isFirstDate ? selectedFirstDate = picked : selectedSecondDate = picked;
      });
  }

  void _selectMonth() async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: _selectedDate ?? DateTime.now(),
      locale: Locale("vi"),
    ).then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //_priceController.addListener();
    getCustommer();

    //add listener eclectric controller
    _controllerElectLast.addListener(_totalElectric);
    _controllerElectCurent.addListener(_totalElectric);
    _controllerElectPrice.addListener(_totalElectric);

    //add listener water controller
    _controllerWaterLast.addListener(_amountWater);
    _controllerWaterCurent.addListener(_amountWater);
    _controllerWaterPrice.addListener(_amountWater);
  }

  void _amountWater() {
    var last = _controllerWaterLast.text;
    var current = _controllerWaterCurent.text;
    var price = _controllerWaterPrice.text;
    amountWater =
        (double.parse(current) - double.parse(last)) * double.parse(price);
  }

  void _totalElectric() {
    var last = _controllerElectLast.text;
    var current = _controllerElectCurent.text;
    var price = _controllerElectPrice.text;
    amount = (double.parse(current) - double.parse(last)) * double.parse(price);
  }

  //all total service
  // gan
  double allServiceget = 0.0;
  double? allService() {
    //var all = 0.0;
    var otherService = context.watch<MoreService>().getTotal();
    allServiceget = (amountWater ?? 0) + (amount ?? 0) + (otherService ?? 0);
    return allServiceget;
  }

//total room
  double totalRoonget = 0.0;
  double? totalRoon() {
    //var toal = 0.0;
    totalRoonget = (allService() ?? 0) +
        (double.parse(
            _priceController.text.isNotEmpty ? _priceController.text : '0'));
    return totalRoonget;
  }

//all pay
  double? allPayget = 0.0;
  double? allPay() {
    //var x = 0.0;
    allPayget = (totalRoon() ?? 0) +
        (double.parse(_tienPhat.text.isNotEmpty ? _tienPhat.text : '0')) -
        (double.parse(_giamGia.text.isNotEmpty ? _giamGia.text : '0'));
    return allPayget;
  }

  void addMoreSevice() {
    var newService = MoreServiceModel(
      id: MinId.getId(),
      name: _serviceName.text,
      note: _serviceNote.text,
      price: double.parse(_servicePrice.text),
    );
    context.read<MoreService>().addNewService(newService);
  }

  double? nn;

  void _submitInvoice() async {
    if (_formKey.currentState!.validate()) {
      var newInvoice = InvoiceModel(
        id: MinId.getId(),
        idCustomer: selectedValue ?? '',
        idRoom: roomModel?.id ?? '',
        roomName: roomModel?.roomname ?? '',
        name: customerUser?.name ?? '',
        invoiceDate: _selectedDate,
        dateFrom: selectedFirstDate,
        dateTo: selectedSecondDate,
        roomCost: roomModel?.price,
        electUse: ElectModel(
          lastNumber: double.parse(_controllerElectLast.text),
          currentNumber: double.parse(_controllerElectCurent.text),
          unitPrice: double.parse(_controllerElectPrice.text),
        ),
        priceEclect: amount,
        waterUse: WaterModel(
          lastNumber: double.parse(_controllerWaterLast.text),
          currentNumber: double.parse(_controllerWaterCurent.text),
          unitPrice: double.parse(_controllerWaterPrice.text),
        ),
        waterCost: amountWater,
        moreService: moreService,
        priceMoreService: nn,
        total: totalRoonget, //totalRoon(),
        punishPrice:
            _tienPhat.text.isNotEmpty ? double.parse(_tienPhat.text) : 0,
        totalAmount: allPayget, //allPay(),
        discount: _giamGia.text.isNotEmpty ? double.parse(_giamGia.text) : 0,
        isPayment: false,
      );
      context.read<Invoice>().addInvoice(newInvoice);
      print(newInvoice.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    moreService = context.watch<MoreService>().moreServiceList;
    //print('LIST MORESERVICE: ${moreService.toString()}');
    nn = context.watch<MoreService>().total;

    return Scaffold(
      appBar: AppBar(),
      body: context.watch<Customer>().showLoading
          ? Center(
              child: circularProgress(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader('Thông tin'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          children: [
                            _buildLable('Người thuê'),
                            DropdownButtonFormField(
                              validator: (value) =>
                                  value == null ? "Chọn người thuê " : null,
                              //dropdownColor: Colors.blueAccent,
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  customerUser = context
                                      .read<Customer>()
                                      .getCustomerByID(selectedValue!);
                                  roomModel = context
                                      .read<RoomProvider>()
                                      .findRoomById(customerUser?.idroom ?? '');
                                });
                              },
                              items: context
                                  .read<Customer>()
                                  .listCustomer
                                  .map((CustomerModel customer) {
                                return DropdownMenuItem<String>(
                                  value: customer.id,
                                  child: Text(customer.name ?? ''),
                                );
                              }).toList(),
                            ),
                            _buildLable('Hoá đơn tháng'),
                            SizedBox(height: 6),
                            Container(
                              height: 40,
                              //width: Utils.sizeWidth(context) * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${_selectedDate != null ? DateFormat('MM-yyyy').format(_selectedDate!) : 'Hoá đơn tháng'} ",
                                    ),
                                    GestureDetector(
                                      onTap: _selectMonth,
                                      child: Icon(Icons.date_range_outlined),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            _buildLable('Thời hạn'),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSelectDate(true),
                                _buildSelectDate(false),
                              ],
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildHeader('Tiền phòng'),
                      SizedBox(height: 20),
                      Container(
                        height: 48,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Text(
                          Utils.convertPrice(roomModel?.price),
                          style: AppTextStyles.defaultBold.copyWith(
                            fontSize: AppTextStyles.fontSize_24,
                          ),
                        )),
                      ),
                      SizedBox(height: 20),
                      _buildHeader('Dịch vụ'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          children: [
                            SizedBox(height: 6),
                            BuildCard(
                              controllerLast: _controllerElectLast,
                              controllerCurent: _controllerElectCurent,
                              controllerPrice: _controllerElectPrice,
                              amount: amount,
                              name: 'Điện',
                            ),
                            BuildCard(
                              controllerLast: _controllerWaterLast,
                              controllerCurent: _controllerWaterCurent,
                              controllerPrice: _controllerWaterPrice,
                              amount: amountWater,
                              name: 'Nước',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Dịch vụ khác: ${context.watch<MoreService>().total}'),
                          IconButton(
                            onPressed: () {
                              showDialogService(context, '');
                            },
                            icon: Icon(Icons.add_box_outlined),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          moreService.length != 0
                              ? Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: moreService.length,
                                    itemBuilder: (ctx, index) {
                                      return Card(
                                          margin: EdgeInsets.all(8),
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(moreService[index].name ??
                                                    ''),
                                                Text(
                                                    "${moreService[index].price ?? ''}"),
                                              ],
                                            ),
                                          ));
                                    },
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      _buildHeader('Tổng hợp'),
                      SizedBox(height: 20),
                      _buildRowTotal(
                          'Tiền phòng',
                          double.parse(_priceController.text.isNotEmpty
                              ? _priceController.text
                              : '0')),
                      SizedBox(height: 10),
                      _buildRowTotal('Dịch vụ', allService()),
                      SizedBox(height: 10),
                      _buildRowTotal('Tổng', totalRoon()),
                      SizedBox(height: 10),
                      _buildOther('Tien Phat', _tienPhat),
                      SizedBox(height: 10),
                      _buildOther('Giảm giá', _giamGia),
                      SizedBox(height: 10),
                      _buildRowTotal('Tổng thanh toán', allPay()),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 35, horizontal: 8),
                        child: SizedBox(
                          width: Utils.sizeWidth(context),
                          height: 50,
                          child: FooterButton(
                            label: 'Lập hóa đơn',
                            onPressed: _submitInvoice,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
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
                        "Thêm dịch vụ",
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
                        controller: _serviceName,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Tên dịch vụ'),
                      ),
                      TextField(
                        controller: _servicePrice,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Giá'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _serviceNote,
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
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.red,
                            ),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              addMoreSevice();
                              Navigator.of(context).pop();
                              _servicePrice.clear();
                              _serviceName.clear();
                              _serviceNote.clear();
                            },
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

  Widget _buildOther(String name, TextEditingController controllerOther) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Container(
          height: 30,
          width: 120,
          child: TextField(
            controller: controllerOther,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildRowTotal(String name, double? totalAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text('${totalAmount}vnd'),
      ],
    );
  }

  Widget _buildLable(String title) {
    return Row(
      children: [
        Text(title),
        SizedBox(width: 5),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildSelectDate(bool isFirst) {
    return Container(
      height: 40,
      width: Utils.sizeWidth(context) * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isFirst
                ? Text(
                    "${selectedFirstDate != null ? DateFormat('dd-MM-yyyy').format(selectedFirstDate!) : 'Từ ngày'} ",
                  )
                : Text(
                    "${selectedSecondDate != null ? DateFormat('dd-MM-yyyy').format(selectedSecondDate!) : 'Đến ngày'} ",
                  ),
            GestureDetector(
              onTap: () => isFirst ? _selectDate(true) : _selectDate(false),
              child: Icon(Icons.date_range_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      width: Utils.sizeWidth(context),
      height: 35,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style:
              TextStyle(color: AppColors.white2, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerElectLast.dispose();
    _controllerElectCurent.dispose();
    _controllerElectPrice.dispose();

    //disponse
    _controllerWaterLast.dispose();
    _controllerWaterCurent.dispose();
    _controllerWaterPrice.dispose();
    //
  }
}
