class PaymentOrderRegistration {
  int? id;
  String? createdAt;
  bool? deliveryNeeded;
  Merchant? merchant;
  var collector;
  int? amountCents;
  var shippingData;
  var shippingDetails;
  String? currency;
  bool? isPaymentLocked;
  bool? isReturn;
  bool? isCancel;
  bool? isReturned;
  bool? isCanceled;
  String? merchantOrderId;
  String? walletNotification;
  int? paidAmountCents;
  bool? notifyUserWithEmail;
  List? items;
  String? orderUrl;
  int? commissionFees;
  int? deliveryFeesCents;
  int? deliveryVatCents;
  String? paymentMethod;
  String? merchantStaffTag;
  String? apiSource;
  String? pickupData;
  List? deliveryStatus;
  String? token;
  String? url;

  PaymentOrderRegistration({this.id, this.createdAt, this.deliveryNeeded, this.merchant, this.collector, this.amountCents, this.shippingData, this.shippingDetails, this.currency, this.isPaymentLocked, this.isReturn, this.isCancel, this.isReturned, this.isCanceled, this.merchantOrderId, this.walletNotification, this.paidAmountCents, this.notifyUserWithEmail, this.items, this.orderUrl, this.commissionFees, this.deliveryFeesCents, this.deliveryVatCents, this.paymentMethod, this.merchantStaffTag, this.apiSource, this.pickupData, this.deliveryStatus, this.token, this.url});

  PaymentOrderRegistration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    deliveryNeeded = json['delivery_needed'];
    merchant = json['merchant'] != null ? new Merchant.fromJson(json['merchant']) : null;
    collector = json['collector'];
    amountCents = json['amount_cents'];
    shippingData = json['shipping_data'] ;
    shippingDetails = json['shipping_details'];
    currency = json['currency'];
    isPaymentLocked = json['is_payment_locked'];
    isReturn = json['is_return'];
    isCancel = json['is_cancel'];
    isReturned = json['is_returned'];
    isCanceled = json['is_canceled'];
    merchantOrderId = json['merchant_order_id'];
    walletNotification = json['wallet_notification'];
    paidAmountCents = json['paid_amount_cents'];
    notifyUserWithEmail = json['notify_user_with_email'];
    items = json['items'];
    orderUrl = json['order_url'];
    commissionFees = json['commission_fees'];
    deliveryFeesCents = json['delivery_fees_cents'];
    deliveryVatCents = json['delivery_vat_cents'];
    paymentMethod = json['payment_method'];
    merchantStaffTag = json['merchant_staff_tag'];
    apiSource = json['api_source'];
    pickupData = json['pickup_data'];
    deliveryStatus = json['delivery_status'];
    token = json['token'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['delivery_needed'] = this.deliveryNeeded;
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    data['collector'] = this.collector;
    data['amount_cents'] = this.amountCents;
    if (this.shippingData != null) {
      data['shipping_data'] = this.shippingData!.toJson();
    }
    if (this.shippingDetails != null) {
      data['shipping_details'] = this.shippingDetails!.toJson();
    }
    data['currency'] = this.currency;
    data['is_payment_locked'] = this.isPaymentLocked;
    data['is_return'] = this.isReturn;
    data['is_cancel'] = this.isCancel;
    data['is_returned'] = this.isReturned;
    data['is_canceled'] = this.isCanceled;
    data['merchant_order_id'] = this.merchantOrderId;
    data['wallet_notification'] = this.walletNotification;
    data['paid_amount_cents'] = this.paidAmountCents;
    data['notify_user_with_email'] = this.notifyUserWithEmail;
    data['items'] = this.items;
    data['order_url'] = this.orderUrl;
    data['commission_fees'] = this.commissionFees;
    data['delivery_fees_cents'] = this.deliveryFeesCents;
    data['delivery_vat_cents'] = this.deliveryVatCents;
    data['payment_method'] = this.paymentMethod;
    data['merchant_staff_tag'] = this.merchantStaffTag;
    data['api_source'] = this.apiSource;
    data['pickup_data'] = this.pickupData;
    data['delivery_status']=this.deliveryStatus;
    data['token'] = this.token;
    data['url'] = this.url;
    return data;
  }
}
class Merchant {
  int? id;
  String? createdAt;
  List<String>? phones;
  List<String>? companyEmails;
  String? companyName;
  String? state;
  String? country;
  String? city;
  String? postalCode;
  String? street;

  Merchant({this.id, this.createdAt, this.phones, this.companyEmails, this.companyName, this.state, this.country, this.city, this.postalCode, this.street});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    phones = json['phones'].cast<String>();
    companyEmails = json['company_emails'].cast<String>();
    companyName = json['company_name'];
    state = json['state'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['phones'] = this.phones;
    data['company_emails'] = this.companyEmails;
    data['company_name'] = this.companyName;
    data['state'] = this.state;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['street'] = this.street;
    return data;
  }
}


