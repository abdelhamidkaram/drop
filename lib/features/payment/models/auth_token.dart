
class PaymentAuthToken {
  PaymentProfile? profile;
  String? token;

  PaymentAuthToken({this.profile, this.token});

  PaymentAuthToken.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new PaymentProfile.fromJson(json['profile']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class PaymentProfile {
  int? id;
  PaymentUser? user;
  String? createdAt;
  bool? active;
  String? profileType;
  List<String>? phones;
  List<String>? companyEmails;
  String? companyName;
  String? state;
  String? country;
  String? city;
  String? postalCode;
  String? street;
  bool? emailNotification;
  String? orderRetrievalEndpoint;
  String? deliveryUpdateEndpoint;
  String? logoUrl;
  int? failedAttempts;
  String? password;
  List? customExportColumns;
  String? awbBanner;
  String? emailBanner;
  String? commercialRegistrationName;
  int? taxNumber;
  String? deliveryStatusCallback;
  String? merchantExternalLink;

  PaymentProfile(
      {this.id,
        this.user,
        this.createdAt,
        this.active,
        this.profileType,
        this.phones,
        this.companyEmails,
        this.companyName,
        this.state,
        this.country,
        this.city,
        this.postalCode,
        this.street,
        this.emailNotification,
        this.orderRetrievalEndpoint,
        this.deliveryUpdateEndpoint,
        this.logoUrl,
        this.failedAttempts,
        this.password,
        this.customExportColumns,
        this.awbBanner,
        this.emailBanner,
        this.commercialRegistrationName,
        this.taxNumber,
        this.deliveryStatusCallback,
        this.merchantExternalLink});

  PaymentProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new PaymentUser.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    active = json['active'];
    profileType = json['profile_type'];
    phones = json['phones'].cast<String>();
    companyEmails = json['company_emails'].cast<String>();
    companyName = json['company_name'];
    state = json['state'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    street = json['street'];
    emailNotification = json['email_notification'];
    orderRetrievalEndpoint = json['order_retrieval_endpoint'];
    deliveryUpdateEndpoint = json['delivery_update_endpoint'];
    logoUrl = json['logo_url'];
    failedAttempts = json['failed_attempts'];
    customExportColumns =json['custom_export_columns'] ;
    password = json['password'];
    awbBanner = json['awb_banner'];
    emailBanner = json['email_banner'];
    commercialRegistrationName = json['commercial_registration_name'];
    taxNumber = json['tax_number'];
    deliveryStatusCallback = json['delivery_status_callback'];
    merchantExternalLink = json['merchant_external_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['active'] = this.active;
    data['profile_type'] = this.profileType;
    data['phones'] = this.phones;
    data['company_emails'] = this.companyEmails;
    data['company_name'] = this.companyName;
    data['state'] = this.state;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['street'] = this.street;
    data['email_notification'] = this.emailNotification;
    data['order_retrieval_endpoint'] = this.orderRetrievalEndpoint;
    data['delivery_update_endpoint'] = this.deliveryUpdateEndpoint;
    data['logo_url'] = this.logoUrl;
    data['failed_attempts'] = this.failedAttempts;
    data['password'] = this.password;
    if (this.customExportColumns != null) {
      data['custom_export_columns'] =
          this.customExportColumns!.map((v) => v.toJson()).toList();
    }
    data['awb_banner'] = this.awbBanner;
    data['email_banner'] = this.emailBanner;
    data['commercial_registration_name'] = this.commercialRegistrationName;
    data['tax_number'] = this.taxNumber;
    data['delivery_status_callback'] = this.deliveryStatusCallback;
    data['merchant_external_link'] = this.merchantExternalLink;
    return data;
  }
}

class PaymentUser {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? dateJoined;
  String? email;
  bool? isActive;
  bool? isStaff;
  bool? isSuperuser;
  String? lastLogin;
  List<Null>? groups;
  List<int>? userPermissions;

  PaymentUser(
      {this.id,
        this.username,
        this.firstName,
        this.lastName,
        this.dateJoined,
        this.email,
        this.isActive,
        this.isStaff,
        this.isSuperuser,
        this.lastLogin,
        this.groups,
        this.userPermissions});

  PaymentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateJoined = json['date_joined'];
    email = json['email'];
    isActive = json['is_active'];
    isStaff = json['is_staff'];
    isSuperuser = json['is_superuser'];
    groups = json['groups'];
    userPermissions = json['user_permissions'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['date_joined'] = this.dateJoined;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['is_staff'] = this.isStaff;
    data['is_superuser'] = this.isSuperuser;
    data['last_login'] = this.lastLogin;
    data['groups']=this.groups;
    data['user_permissions'] = this.userPermissions;
    return data;
  }
}

