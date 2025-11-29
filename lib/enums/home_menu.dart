enum HomeMenu {
  //top menu
  sendMoney('Send Money', 'assets/images/send_money.jpg'),
  cashOut('Cash Out', 'assets/images/cash_out.jpg'),
  topUp('Top-up', 'assets/images/mobile_recharge.jpg'),
  payment('Payment', 'assets/images/make_payment.jpg'),
  addMoney('Add Money', 'assets/images/add_money.jpg'),
  payBill('Pay Bill', 'assets/images/pay_bill.jpg'),
  tickets('Tickets', 'assets/images/tickets.jpg'),
  more('More', 'assets/images/more.jpg'),

  //my bKash
  topUps('Evan Emran', 'assets/images/mobile_recharge.jpg'),
  shwapno('Shwapno', 'assets/images/make_payment.jpg'),
  internet('Internet', 'assets/images/pay_bill.jpg'),
  card('Card', 'assets/images/add_money.jpg'),
  account('My Account', 'assets/images/mobile_recharge.jpg'),

  //suggestions
  btcl('BTCL', 'assets/images/btcl.jpg'),
  akash('Akash DTH', 'assets/images/akash.jpg'),
  ajkelDeal('Ajker Deal', 'assets/images/ajkerdeal.jpg'),
  daraz('Daraz', 'assets/images/daraz.jpg'),
  styline('Sty Line', 'assets/images/stiline.jpg'),
  moree('More', 'assets/images/more.jpg');

  final String title;
  final String icon;

  const HomeMenu(this.title, this.icon);
}
