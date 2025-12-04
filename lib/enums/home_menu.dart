import 'dart:ui';

enum HomeMenu {
  // Top menu
  sendMoney(title: 'Send Money', icon: 'assets/images/send_money.jpg'),
  mobileRecharge(title: 'Mobile Recharge', icon: 'assets/images/mobile_recharge.jpg'),
  cashOut(title: 'Cash Out', icon: 'assets/images/cash_out.jpg'),
  makePayment(title: 'Make Payment', icon: 'assets/images/make_payment.jpg'),
  addMoney(title: 'Add Money', icon: 'assets/images/add_money.jpg'),
  payBill(title: 'Pay Bill', icon: 'assets/images/pay_bill.jpg'),
  savings(title: 'Savings', icon: 'assets/images/savings.jpg'),
  loan(title: 'Loan', icon: 'assets/images/loan.jpg'),
  tickets(title: 'Insurance', icon: 'assets/images/insurance.jpg'),
  bkashToBank(title: 'bKash to Bank', icon: 'assets/images/bkash_to_bank.jpg'),
  educationFee(title: 'Education Fee', icon: 'assets/images/education_fee.jpg'),
  microfinance(title: 'Microfinance', icon: 'assets/images/microfinance.jpg'),
  toll(title: 'Toll', icon: 'assets/images/toll.jpg'),
  requestMoney(title: 'Request Money', icon: 'assets/images/request_money.jpg'),
  remittance(title: 'Remittance', icon: 'assets/images/remittance.jpg'),
  donation(title: 'Donation', icon: 'assets/images/donation.jpg'),

  // Quick Features
  myOffers(title: 'My Offers', icon: 'assets/images/my_offers.jpg', color: Color(0xFFFEF6EB)),
  coupons(title: 'Coupons', icon: 'assets/images/coupons.jpg', color: Color(0xFFEFF8F7)),
  rewards(title: 'Rewards', icon: 'assets/images/rewards.jpg', color: Color(0xFFFAFCEF)),

  // Suggestions
  btcl(title: 'BTCL', icon: 'assets/images/btcl.jpg'),
  akash(title: 'Akash DTH', icon: 'assets/images/akash.jpg'),
  ajkelDeal(title: 'Ajker Deal', icon: 'assets/images/ajkerdeal.jpg'),
  daraz(title: 'Daraz', icon: 'assets/images/daraz.jpg'),
  styline(title: 'Sty Line', icon: 'assets/images/stiline.jpg'),
  metlife(title: 'Metlife', icon: 'assets/images/metlife.jpg');

  final String title;
  final String icon;
  final Color? color;

  const HomeMenu({required this.title, required this.icon, this.color});
}
