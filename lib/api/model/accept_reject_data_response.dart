import 'dart:convert';

class GetAcceptRejectData {
  bool? error;
  String? message;
  Data? data;

  GetAcceptRejectData({this.error, this.message, this.data});

  GetAcceptRejectData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<News>? news;
  List<Webinar>? webinar;
  List<Event>? event;
  List<Editorial>? editorial;
  List<Awareness>? awareness;
  List<Products>? products;
  List<Pharma>? pharma;
  List<Doctor>? doctor;

  Data(
      {this.news,
      this.webinar,
      this.event,
      this.editorial,
      this.awareness,
      this.doctor,
      this.pharma});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(new News.fromJson(v));
      });
    }
    if (json['webinar'] != null) {
      webinar = <Webinar>[];
      json['webinar'].forEach((v) {
        webinar!.add(new Webinar.fromJson(v));
      });
    }
    if (json['event'] != null) {
      event = <Event>[];
      json['event'].forEach((v) {
        event!.add(new Event.fromJson(v));
      });
    }
    if (json['editorial'] != null) {
      editorial = <Editorial>[];
      json['editorial'].forEach((v) {
        editorial!.add(new Editorial.fromJson(v));
      });
    }
    if (json['awareness'] != null) {
      awareness = <Awareness>[];
      json['awareness'].forEach((v) {
        awareness!.add(new Awareness.fromJson(v));
      });
    }

    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['pharma'] != null) {
      pharma = <Pharma>[];
      json['pharma'].forEach((v) {
        pharma!.add(new Pharma.fromJson(v));
      });
    }
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add(new Doctor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news!.map((v) => v.toJson()).toList();
    }
    if (this.webinar != null) {
      data['webinar'] = this.webinar!.map((v) => v.toJson()).toList();
    }
    if (this.event != null) {
      data['event'] = this.event!.map((v) => v.toJson()).toList();
    }
    if (this.editorial != null) {
      data['editorial'] = this.editorial!.map((v) => v.toJson()).toList();
    }
    if (this.awareness != null) {
      data['awareness'] = this.awareness!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.pharma != null) {
      data['pharma'] = this.pharma!.map((v) => v.toJson()).toList();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? id;
  String? name;
  String? title;
  String? description;
  String? image;
  String? doctorId;
  String? status;
  String? date;
  Null? endDate;
  Null? time;
  Null? endTime;
  String? pharmaId;

  News(
      {this.id,
      this.title,
      this.name,
      this.description,
      this.image,
      this.doctorId,
      this.status,
      this.date,
      this.endDate,
      this.time,
      this.endTime,
      this.pharmaId});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    doctorId = json['doctor_id'];
    status = json['status'];
    date = json['date'];
    endDate = json['end date'];
    time = json['time'];
    endTime = json['end time'];
    pharmaId = json['pharma_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['doctor_id'] = this.doctorId;
    data['status'] = this.status;
    data['date'] = this.date;
    data['end date'] = this.endDate;
    data['time'] = this.time;
    data['end time'] = this.endTime;
    data['pharma_id'] = this.pharmaId;
    return data;
  }
}

class Webinar {
  String? id;
  String? name;
  String? topic;
  String? speaker;
  String? moderator;
  String? title;
  String? fromTime;
  String? toTime;
  String? startDate;
  String? endDate;
  String? description;
  String? link;
  String? image;
  String? doctorId;
  String? status;
  String? date;
  String? pharmaId;

  Webinar(
      {this.id,
      this.title,
      this.name,
      this.topic,
      this.speaker,
      this.moderator,
      this.fromTime,
      this.toTime,
      this.startDate,
      this.endDate,
      this.description,
      this.link,
      this.image,
      this.doctorId,
      this.status,
      this.date,
      this.pharmaId});

  Webinar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    topic = json['topic'];
    speaker = json['speaker'];
    moderator = json['moderator'];
    title = json['title'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    link = json['link'];
    image = json['image'];
    doctorId = json['doctor_id'];
    status = json['status'];
    date = json['date'];
    endDate = json['end date'];
    pharmaId = json['pharma_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['link'] = this.link;
    data['image'] = this.image;
    data['doctor_id'] = this.doctorId;
    data['status'] = this.status;
    data['date'] = this.date;
    data['end date'] = this.endDate;
    data['pharma_id'] = this.pharmaId;
    return data;
  }
}

class Event {
  String? name;
  String? id;
  String? title;
  String? mobile;
  String? startDate;
  String? endDate;
  String? designation;
  String? status;
  String? description;
  String? link;
  String? address;
  String? date;
  String? image;
  String? doctorId;
  String? pharmaId;

  Event(
      {this.name,
      this.id,
      this.title,
      this.mobile,
      this.startDate,
      this.endDate,
      this.designation,
      this.status,
      this.description,
      this.link,
      this.address,
      this.date,
      this.image,
      this.doctorId,
      this.pharmaId});

  Event.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    title = json['title'];
    mobile = json['mobile'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    designation = json['designation'];
    status = json['status'];
    description = json['description'];
    link = json['link'];
    address = json['address'];
    date = json['date'];
    image = json['image'];
    doctorId = json['doctor_id'];
    pharmaId = json['pharma_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['title'] = this.title;
    data['mobile'] = this.mobile;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['designation'] = this.designation;
    data['status'] = this.status;
    data['description'] = this.description;
    data['link'] = this.link;
    data['address'] = this.address;
    data['date'] = this.date;
    data['image'] = this.image;
    data['doctor_id'] = this.doctorId;
    data['pharma_id'] = this.pharmaId;
    return data;
  }
}

class Products {
  Products({
    String? name,
    String? id,
    dynamic productIdentity,
    String? categoryId,
    String? sellerId,
    String? tax,
    String? rowOrder,
    String? type,
    dynamic stockType,
    String? shortDescription,
    String? dosage,
    String? rxInfo,
    String? indication,
    String? slug,
    String? indicator,
    String? codAllowed,
    String? downloadAllowed,
    String? downloadType,
    String? downloadLink,
    String? minimumOrderQuantity,
    String? quantityStepSize,
    dynamic totalAllowedQuantity,
    String? isPricesInclusiveTax,
    String? isReturnable,
    String? isCancelable,
    String? cancelableTill,
    String? image,
    String? otherImages,
    String? videoType,
    String? video,
    String? tags,
    String? warrantyPeriod,
    String? guaranteePeriod,
    dynamic madeIn,
    String? hsnCode,
    dynamic brand,
    dynamic sku,
    dynamic typeOfProduct,
    dynamic stock,
    dynamic availability,
    String? rating,
    String? noOfRatings,
    dynamic description,
    String? deliverableType,
    dynamic deliverableZipcodes,
    String? status,
    String? dateAdded,
  }) {
    _name = name;
    _id = id;
    _productIdentity = productIdentity;
    _categoryId = categoryId;
    _sellerId = sellerId;
    _tax = tax;
    _rowOrder = rowOrder;
    _type = type;
    _stockType = stockType;
    _shortDescription = shortDescription;
    _dosage = dosage;
    _rxInfo = rxInfo;
    _indication = indication;
    _slug = slug;
    _indicator = indicator;
    _codAllowed = codAllowed;
    _downloadAllowed = downloadAllowed;
    _downloadType = downloadType;
    _downloadLink = downloadLink;
    _minimumOrderQuantity = minimumOrderQuantity;
    _quantityStepSize = quantityStepSize;
    _totalAllowedQuantity = totalAllowedQuantity;
    _isPricesInclusiveTax = isPricesInclusiveTax;
    _isReturnable = isReturnable;
    _isCancelable = isCancelable;
    _cancelableTill = cancelableTill;
    _image = image;
    _otherImages = otherImages;
    _videoType = videoType;
    _video = video;
    _tags = tags;
    _warrantyPeriod = warrantyPeriod;
    _guaranteePeriod = guaranteePeriod;
    _madeIn = madeIn;
    _hsnCode = hsnCode;
    _brand = brand;
    _sku = sku;
    _typeOfProduct = typeOfProduct;
    _stock = stock;
    _availability = availability;
    _rating = rating;
    _noOfRatings = noOfRatings;
    _description = description;
    _deliverableType = deliverableType;
    _deliverableZipcodes = deliverableZipcodes;
    _status = status;
    _dateAdded = dateAdded;
  }

  Products.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _productIdentity = json['product_identity'];
    _categoryId = json['category_id'];
    _sellerId = json['seller_id'];
    _tax = json['tax'];
    _rowOrder = json['row_order'];
    _type = json['type'];
    _stockType = json['stock_type'];
    _shortDescription = json['short_description'];
    _dosage = json['dosage'];
    _rxInfo = json['rx_info'];
    _indication = json['indication'];
    _slug = json['slug'];
    _indicator = json['indicator'];
    _codAllowed = json['cod_allowed'];
    _downloadAllowed = json['download_allowed'];
    _downloadType = json['download_type'];
    _downloadLink = json['download_link'];
    _minimumOrderQuantity = json['minimum_order_quantity'];
    _quantityStepSize = json['quantity_step_size'];
    _totalAllowedQuantity = json['total_allowed_quantity'];
    _isPricesInclusiveTax = json['is_prices_inclusive_tax'];
    _isReturnable = json['is_returnable'];
    _isCancelable = json['is_cancelable'];
    _cancelableTill = json['cancelable_till'];
    _image = json['image'];
    _otherImages = json['other_images'];
    _videoType = json['video_type'];
    _video = json['video'];
    _tags = json['tags'];
    _warrantyPeriod = json['warranty_period'];
    _guaranteePeriod = json['guarantee_period'];
    _madeIn = json['made_in'];
    _hsnCode = json['hsn_code'];
    _brand = json['brand'];
    _sku = json['sku'];
    _typeOfProduct = json['type_of_product'];
    _stock = json['stock'];
    _availability = json['availability'];
    _rating = json['rating'];
    _noOfRatings = json['no_of_ratings'];
    _description = json['description'];
    _deliverableType = json['deliverable_type'];
    _deliverableZipcodes = json['deliverable_zipcodes'];
    _status = json['status'];
    _dateAdded = json['date_added'];
  }
  String? _name;
  String? _id;
  dynamic _productIdentity;
  String? _categoryId;
  String? _sellerId;
  String? _tax;
  String? _rowOrder;
  String? _type;
  dynamic _stockType;
  String? _shortDescription;
  String? _dosage;
  String? _rxInfo;
  String? _indication;
  String? _slug;
  String? _indicator;
  String? _codAllowed;
  String? _downloadAllowed;
  String? _downloadType;
  String? _downloadLink;
  String? _minimumOrderQuantity;
  String? _quantityStepSize;
  dynamic _totalAllowedQuantity;
  String? _isPricesInclusiveTax;
  String? _isReturnable;
  String? _isCancelable;
  String? _cancelableTill;
  String? _image;
  String? _otherImages;
  String? _videoType;
  String? _video;
  String? _tags;
  String? _warrantyPeriod;
  String? _guaranteePeriod;
  dynamic _madeIn;
  String? _hsnCode;
  dynamic _brand;
  dynamic _sku;
  dynamic _typeOfProduct;
  dynamic _stock;
  dynamic _availability;
  String? _rating;
  String? _noOfRatings;
  dynamic _description;
  String? _deliverableType;
  dynamic _deliverableZipcodes;
  String? _status;
  String? _dateAdded;
  Products copyWith({
    String? name,
    String? id,
    dynamic productIdentity,
    String? categoryId,
    String? sellerId,
    String? tax,
    String? rowOrder,
    String? type,
    dynamic stockType,
    String? shortDescription,
    String? dosage,
    String? rxInfo,
    String? indication,
    String? slug,
    String? indicator,
    String? codAllowed,
    String? downloadAllowed,
    String? downloadType,
    String? downloadLink,
    String? minimumOrderQuantity,
    String? quantityStepSize,
    dynamic totalAllowedQuantity,
    String? isPricesInclusiveTax,
    String? isReturnable,
    String? isCancelable,
    String? cancelableTill,
    String? image,
    String? otherImages,
    String? videoType,
    String? video,
    String? tags,
    String? warrantyPeriod,
    String? guaranteePeriod,
    dynamic madeIn,
    String? hsnCode,
    dynamic brand,
    dynamic sku,
    dynamic typeOfProduct,
    dynamic stock,
    dynamic availability,
    String? rating,
    String? noOfRatings,
    dynamic description,
    String? deliverableType,
    dynamic deliverableZipcodes,
    String? status,
    String? dateAdded,
  }) =>
      Products(
        name: name ?? _name,
        id: id ?? _id,
        productIdentity: productIdentity ?? _productIdentity,
        categoryId: categoryId ?? _categoryId,
        sellerId: sellerId ?? _sellerId,
        tax: tax ?? _tax,
        rowOrder: rowOrder ?? _rowOrder,
        type: type ?? _type,
        stockType: stockType ?? _stockType,
        shortDescription: shortDescription ?? _shortDescription,
        dosage: dosage ?? _dosage,
        rxInfo: rxInfo ?? _rxInfo,
        indication: indication ?? _indication,
        slug: slug ?? _slug,
        indicator: indicator ?? _indicator,
        codAllowed: codAllowed ?? _codAllowed,
        downloadAllowed: downloadAllowed ?? _downloadAllowed,
        downloadType: downloadType ?? _downloadType,
        downloadLink: downloadLink ?? _downloadLink,
        minimumOrderQuantity: minimumOrderQuantity ?? _minimumOrderQuantity,
        quantityStepSize: quantityStepSize ?? _quantityStepSize,
        totalAllowedQuantity: totalAllowedQuantity ?? _totalAllowedQuantity,
        isPricesInclusiveTax: isPricesInclusiveTax ?? _isPricesInclusiveTax,
        isReturnable: isReturnable ?? _isReturnable,
        isCancelable: isCancelable ?? _isCancelable,
        cancelableTill: cancelableTill ?? _cancelableTill,
        image: image ?? _image,
        otherImages: otherImages ?? _otherImages,
        videoType: videoType ?? _videoType,
        video: video ?? _video,
        tags: tags ?? _tags,
        warrantyPeriod: warrantyPeriod ?? _warrantyPeriod,
        guaranteePeriod: guaranteePeriod ?? _guaranteePeriod,
        madeIn: madeIn ?? _madeIn,
        hsnCode: hsnCode ?? _hsnCode,
        brand: brand ?? _brand,
        sku: sku ?? _sku,
        typeOfProduct: typeOfProduct ?? _typeOfProduct,
        stock: stock ?? _stock,
        availability: availability ?? _availability,
        rating: rating ?? _rating,
        noOfRatings: noOfRatings ?? _noOfRatings,
        description: description ?? _description,
        deliverableType: deliverableType ?? _deliverableType,
        deliverableZipcodes: deliverableZipcodes ?? _deliverableZipcodes,
        status: status ?? _status,
        dateAdded: dateAdded ?? _dateAdded,
      );
  String? get name => _name;
  String? get id => _id;
  dynamic get productIdentity => _productIdentity;
  String? get categoryId => _categoryId;
  String? get sellerId => _sellerId;
  String? get tax => _tax;
  String? get rowOrder => _rowOrder;
  String? get type => _type;
  dynamic get stockType => _stockType;
  String? get shortDescription => _shortDescription;
  String? get dosage => _dosage;
  String? get rxInfo => _rxInfo;
  String? get indication => _indication;
  String? get slug => _slug;
  String? get indicator => _indicator;
  String? get codAllowed => _codAllowed;
  String? get downloadAllowed => _downloadAllowed;
  String? get downloadType => _downloadType;
  String? get downloadLink => _downloadLink;
  String? get minimumOrderQuantity => _minimumOrderQuantity;
  String? get quantityStepSize => _quantityStepSize;
  dynamic get totalAllowedQuantity => _totalAllowedQuantity;
  String? get isPricesInclusiveTax => _isPricesInclusiveTax;
  String? get isReturnable => _isReturnable;
  String? get isCancelable => _isCancelable;
  String? get cancelableTill => _cancelableTill;
  String? get image => _image;
  String? get otherImages => _otherImages;
  String? get videoType => _videoType;
  String? get video => _video;
  String? get tags => _tags;
  String? get warrantyPeriod => _warrantyPeriod;
  String? get guaranteePeriod => _guaranteePeriod;
  dynamic get madeIn => _madeIn;
  String? get hsnCode => _hsnCode;
  dynamic get brand => _brand;
  dynamic get sku => _sku;
  dynamic get typeOfProduct => _typeOfProduct;
  dynamic get stock => _stock;
  dynamic get availability => _availability;
  String? get rating => _rating;
  String? get noOfRatings => _noOfRatings;
  dynamic get description => _description;
  String? get deliverableType => _deliverableType;
  dynamic get deliverableZipcodes => _deliverableZipcodes;
  String? get status => _status;
  String? get dateAdded => _dateAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['product_identity'] = _productIdentity;
    map['category_id'] = _categoryId;
    map['seller_id'] = _sellerId;
    map['tax'] = _tax;
    map['row_order'] = _rowOrder;
    map['type'] = _type;
    map['stock_type'] = _stockType;
    map['short_description'] = _shortDescription;
    map['dosage'] = _dosage;
    map['rx_info'] = _rxInfo;
    map['indication'] = _indication;
    map['slug'] = _slug;
    map['indicator'] = _indicator;
    map['cod_allowed'] = _codAllowed;
    map['download_allowed'] = _downloadAllowed;
    map['download_type'] = _downloadType;
    map['download_link'] = _downloadLink;
    map['minimum_order_quantity'] = _minimumOrderQuantity;
    map['quantity_step_size'] = _quantityStepSize;
    map['total_allowed_quantity'] = _totalAllowedQuantity;
    map['is_prices_inclusive_tax'] = _isPricesInclusiveTax;
    map['is_returnable'] = _isReturnable;
    map['is_cancelable'] = _isCancelable;
    map['cancelable_till'] = _cancelableTill;
    map['image'] = _image;
    map['other_images'] = _otherImages;
    map['video_type'] = _videoType;
    map['video'] = _video;
    map['tags'] = _tags;
    map['warranty_period'] = _warrantyPeriod;
    map['guarantee_period'] = _guaranteePeriod;
    map['made_in'] = _madeIn;
    map['hsn_code'] = _hsnCode;
    map['brand'] = _brand;
    map['sku'] = _sku;
    map['type_of_product'] = _typeOfProduct;
    map['stock'] = _stock;
    map['availability'] = _availability;
    map['rating'] = _rating;
    map['no_of_ratings'] = _noOfRatings;
    map['description'] = _description;
    map['deliverable_type'] = _deliverableType;
    map['deliverable_zipcodes'] = _deliverableZipcodes;
    map['status'] = _status;
    map['date_added'] = _dateAdded;
    return map;
  }
}

class Editorial {
  String? id;
  String? name;
  String? title;
  String? awareInput;
  String? awareLanguage;
  String? description;
  String? date;
  String? image;
  String? doctorId;
  String? status;
  String? pharmaId;

  Editorial(
      {this.id,
      this.name,
      this.title,
      this.awareInput,
      this.awareLanguage,
      this.description,
      this.date,
      this.image,
      this.doctorId,
      this.status,
      this.pharmaId});

  Editorial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    awareInput = json['aware_input'];
    awareLanguage = json['aware_language'];
    description = json['description'];
    date = json['date'];
    image = json['image'];
    doctorId = json['doctor_id'];
    status = json['status'];
    pharmaId = json['pharma_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['aware_input'] = this.awareInput;
    data['aware_language'] = this.awareLanguage;
    data['description'] = this.description;
    data['date'] = this.date;
    data['image'] = this.image;
    data['doctor_id'] = this.doctorId;
    data['status'] = this.status;
    data['pharma_id'] = this.pharmaId;
    return data;
  }
}

class Awareness {
  String? id;
  String? name;
  String? title;
  String? awareInput;
  String? awareLanguage;
  String? date;
  String? image;
  String? doctorId;
  String? status;
  String? pharmaId;

  Awareness(
      {this.id,
      this.name,
      this.title,
      this.awareInput,
      this.awareLanguage,
      this.date,
      this.image,
      this.doctorId,
      this.status,
      this.pharmaId});

  Awareness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    awareInput = json['aware_input'];
    awareLanguage = json['aware_language'];
    date = json['date'];
    image = json['image'];
    doctorId = json['doctor_id'];
    status = json['status'];
    pharmaId = json['pharma_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['aware_input'] = this.awareInput;
    data['aware_language'] = this.awareLanguage;
    data['date'] = this.date;
    data['image'] = this.image;
    data['doctor_id'] = this.doctorId;
    data['status'] = this.status;
    data['pharma_id'] = this.pharmaId;
    return data;
  }
}

class Pharma {
  String? id;
  String? title;
  String? name;
  String? mobile;
  String? email;
  String? docDigree;
  String? gender;
  String? stateId;
  String? cityId;
  String? areaId;

  Pharma({
    required this.id,
    required this.title,
    required this.name,
    required this.mobile,
    required this.email,
    required this.docDigree,
    required this.gender,
    required this.stateId,
    required this.cityId,
    required this.areaId,
  });

  factory Pharma.fromJson(Map<String, dynamic> json) => Pharma(
         id: json["id"],
        title: json["title"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        docDigree: json["doc_digree"],
        gender: json["gender"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        areaId: json["area_id"],
      );

  Map<String, dynamic> toJson() => {
         "id":id,
        "title": title,
        "name": name,
        "mobile": mobile,
        "email": email,
        "doc_digree": docDigree,
        "gender": gender,
        "state_id": stateId,
        "city_id": cityId,
        "area_id": areaId,
      };
}

class Doctor {
  String? id;
  String? title;
  String? name;
  String? mobile;
  String? email;
  String? docDigree;
  String? gender;
  String? stateId;
  String? cityId;
  String? areaId;

  Doctor({
    this.id,
    this.title,
    this.name,
    this.mobile,
    this.email,
    this.docDigree,
    this.gender,
    this.stateId,
    this.cityId,
    this.areaId,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
         id: json["id"],
        title: json["title"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        docDigree: json["doc_digree"],
        gender: json["gender"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        areaId: json["area_id"],
      );

  Map<String, dynamic> toJson() => {
         "id": id,
        "title": title,
        "name": name,
        "mobile": mobile,
        "email": email,
        "doc_digree": docDigree,
        "gender": gender,
        "state_id": stateId,
        "city_id": cityId,
        "area_id": areaId,
      };
}
