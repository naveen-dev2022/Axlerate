/*class CreateInvoiceInputModel {
  String? companyID;
  String? invoiceDate;
  String? duedate;
  String? billedByID;
  String? billedToID;
  List<Items>? items;

  CreateInvoiceInputModel(
      {this.companyID, this.invoiceDate, this.duedate, this.billedByID, this.billedToID, this.items});

  CreateInvoiceInputModel.fromJson(Map<String, dynamic> json) {
    companyID = json['companyID'];
    invoiceDate = json['invoiceDate'];
    duedate = json['duedate'];
    billedByID = json['billedByID'];
    billedToID = json['billedToID'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['companyID'] = companyID;
    data['invoiceDate'] = invoiceDate;
    data['duedate'] = duedate;
    data['billedByID'] = billedByID;
    data['billedToID'] = billedToID;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'companyID': companyID,
      'invoiceDate': invoiceDate,
      'duedate': duedate,
      'billedByID': billedByID,
      'billedToID': billedToID,
      'items': items!.map((x) => x.toMap()).toList(),
    };
  }
}

class Items {
  String? name;
  String? gstRate;
  String? quantity;
  String? rate;
  String? amount;
  String? cgst;
  String? sgst;
  String? total;

  Items({this.name, this.gstRate, this.quantity, this.rate, this.amount, this.cgst, this.sgst, this.total});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gstRate = json['gstRate'];
    quantity = json['quantity'];
    rate = json['rate'];
    amount = json['amount'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gstRate'] = gstRate;
    data['quantity'] = quantity;
    data['rate'] = rate;
    data['amount'] = amount;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['total'] = total;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gstRate': gstRate,
      'quantity': quantity,
      'rate': rate,
      'amount': amount,
      'cgst': cgst,
      'sgst': sgst,
      'total': total,
    };
  }
}*/

class CreateInvoiceInputModel {
  String? userId;
  String? businessLogo;
  String? invoiceNo;
  String? invoiceDate;
  String? duedate;
  String? billedById;
  String? billedToId;
  ShippedFrom? shippedFrom;
  ShippedFrom? shippedTo;
  TransportDetails? transportDetails;
  List<Products>? products;
  String? amount;
  String? sgst;
  String? cgst;
  String? itemWiseDiscount;
  String? discountOnTotal;
  String? total;
  List<String>? addTermsCondition;
  String? note;
  String? addAttachment;
  String? addSignature;
  List<AddAdditionalInfo>? addAdditionalInfo;
  AddContactDetails? addContactDetails;
  String? invoiceRepeat;
  String? nextRepeatDate;
  String? options;

  CreateInvoiceInputModel(
      {this.userId,
      this.businessLogo,
      this.invoiceNo,
      this.invoiceDate,
      this.duedate,
      this.billedById,
      this.billedToId,
      this.shippedFrom,
      this.shippedTo,
      this.transportDetails,
      this.products,
      this.amount,
      this.sgst,
      this.cgst,
      this.itemWiseDiscount,
      this.discountOnTotal,
      this.total,
      this.addTermsCondition,
      this.note,
      this.addAttachment,
      this.addSignature,
      this.addAdditionalInfo,
      this.addContactDetails,
      this.invoiceRepeat,
      this.nextRepeatDate,
      this.options});

  CreateInvoiceInputModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    businessLogo = json['businessLogo'];
    invoiceNo = json['invoiceNo'];
    invoiceDate = json['invoiceDate'];
    duedate = json['duedate'];
    billedById = json['billedById'];
    billedToId = json['billedToId'];
    shippedFrom = json['shippedFrom'] != null ? ShippedFrom.fromJson(json['shippedFrom']) : null;
    shippedTo = json['shippedTo'] != null ? ShippedFrom.fromJson(json['shippedTo']) : null;
    transportDetails = json['transportDetails'] != null ? TransportDetails.fromJson(json['transportDetails']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    amount = json['amount'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    itemWiseDiscount = json['itemWiseDiscount'];
    discountOnTotal = json['discountOnTotal'];
    total = json['total'];
    addTermsCondition = json['addTerms&Condition'].cast<String>();
    note = json['note'];
    addAttachment = json['addAttachment'];
    addSignature = json['addSignature'];
    if (json['addAdditionalInfo'] != null) {
      addAdditionalInfo = <AddAdditionalInfo>[];
      json['addAdditionalInfo'].forEach((v) {
        addAdditionalInfo!.add(AddAdditionalInfo.fromJson(v));
      });
    }
    addContactDetails =
        json['addContactDetails'] != null ? AddContactDetails.fromJson(json['addContactDetails']) : null;
    invoiceRepeat = json['invoiceRepeat'];
    nextRepeatDate = json['nextRepeatDate'];
    options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['businessLogo'] = businessLogo;
    data['invoiceNo'] = invoiceNo;
    data['invoiceDate'] = invoiceDate;
    data['duedate'] = duedate;
    data['billedById'] = billedById;
    data['billedToId'] = billedToId;
    if (shippedFrom != null) {
      data['shippedFrom'] = shippedFrom!.toJson();
    }
    if (shippedTo != null) {
      data['shippedTo'] = shippedTo!.toJson();
    }
    if (transportDetails != null) {
      data['transportDetails'] = transportDetails!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['amount'] = amount;
    data['sgst'] = sgst;
    data['cgst'] = cgst;
    data['itemWiseDiscount'] = itemWiseDiscount;
    data['discountOnTotal'] = discountOnTotal;
    data['total'] = total;
    data['addTerms&Condition'] = addTermsCondition;
    data['note'] = note;
    data['addAttachment'] = addAttachment;
    data['addSignature'] = addSignature;
    if (addAdditionalInfo != null) {
      data['addAdditionalInfo'] = addAdditionalInfo!.map((v) => v.toJson()).toList();
    }
    if (addContactDetails != null) {
      data['addContactDetails'] = addContactDetails!.toJson();
    }
    data['invoiceRepeat'] = invoiceRepeat;
    data['nextRepeatDate'] = nextRepeatDate;
    data['options'] = options;
    return data;
  }
}

class ShippedFrom {
  String? businessName;
  String? country;
  String? address;
  String? city;
  String? pincode;
  String? state;
  String? gstIn;

  ShippedFrom({this.businessName, this.country, this.address, this.city, this.pincode, this.state, this.gstIn});

  ShippedFrom.fromJson(Map<String, dynamic> json) {
    businessName = json['businessName'];
    country = json['country'];
    address = json['address'];
    city = json['city'];
    pincode = json['pincode'];
    state = json['state'];
    gstIn = json['gstIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['businessName'] = businessName;
    data['country'] = country;
    data['address'] = address;
    data['city'] = city;
    data['pincode'] = pincode;
    data['state'] = state;
    data['gstIn'] = gstIn;
    return data;
  }
}

class TransportDetails {
  String? challanNo;
  String? challanDate;
  String? transportName;
  String? shippingNote;
  String? extraInformation;

  TransportDetails({this.challanNo, this.challanDate, this.transportName, this.shippingNote, this.extraInformation});

  TransportDetails.fromJson(Map<String, dynamic> json) {
    challanNo = json['challanNo'];
    challanDate = json['challanDate'];
    transportName = json['transportName'];
    shippingNote = json['shippingNote'];
    extraInformation = json['extraInformation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['challanNo'] = challanNo;
    data['challanDate'] = challanDate;
    data['transportName'] = transportName;
    data['shippingNote'] = shippingNote;
    data['extraInformation'] = extraInformation;
    return data;
  }
}

class Products {
  String? item;
  String? hSNSAC;
  String? gstRate;
  String? quantity;
  String? rate;
  String? amount;
  String? cgst;
  String? sgst;
  String? total;
  String? discription;
  String? thumbnail;

  Products(
      {this.item,
      this.hSNSAC,
      this.gstRate,
      this.quantity,
      this.rate,
      this.amount,
      this.cgst,
      this.sgst,
      this.total,
      this.discription,
      this.thumbnail});

  Products.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    hSNSAC = json['HSN/SAC'];
    gstRate = json['gstRate'];
    quantity = json['quantity'];
    rate = json['rate'];
    amount = json['amount'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    total = json['total'];
    discription = json['discription'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = item;
    data['HSN/SAC'] = hSNSAC;
    data['gstRate'] = gstRate;
    data['quantity'] = quantity;
    data['rate'] = rate;
    data['amount'] = amount;
    data['cgst'] = cgst;
    data['sgst'] = sgst;
    data['total'] = total;
    data['discription'] = discription;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

class AddAdditionalInfo {
  String? fieldName;
  String? value;

  AddAdditionalInfo({this.fieldName, this.value});

  AddAdditionalInfo.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldName'] = fieldName;
    data['value'] = value;
    return data;
  }
}

class AddContactDetails {
  String? email;
  String? phone;

  AddContactDetails({this.email, this.phone});

  AddContactDetails.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
