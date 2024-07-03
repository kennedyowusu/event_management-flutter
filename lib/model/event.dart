class EventModel {
  int? id;
  String? title;
  String? description;
  String? date;
  String? time;
  String? venue;
  int? organizerId;
  int? capacity;
  String? createdAt;
  String? updatedAt;
  List<Attendees>? attendees;
  List<Tickets>? tickets;
  List<Reviews>? reviews;

  EventModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.venue,
    this.organizerId,
    this.capacity,
    this.createdAt,
    this.updatedAt,
    this.attendees,
    this.tickets,
    this.reviews,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    venue = json['venue'];
    organizerId = json['organizer_id'];
    capacity = json['capacity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(Attendees.fromJson(v));
      });
    }
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(Tickets.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['time'] = time;
    data['venue'] = venue;
    data['organizer_id'] = organizerId;
    data['capacity'] = capacity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (attendees != null) {
      data['attendees'] = attendees!.map((v) => v.toJson()).toList();
    }
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendees {
  int? id;
  String? name;
  String? email;
  String? role;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Attendees({
    this.id,
    this.name,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  Attendees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? eventId;
  int? userId;

  Pivot({this.eventId, this.userId});

  Pivot.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['user_id'] = userId;
    return data;
  }
}

class Tickets {
  int? id;
  int? eventId;
  int? userId;
  String? ticketType;
  String? price;
  String? bookingDate;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  UserModel? user;
  EventModel? event;

  Tickets({
    this.id,
    this.eventId,
    this.userId,
    this.ticketType,
    this.price,
    this.bookingDate,
    this.paymentStatus,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.event,
  });

  Tickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    userId = json['user_id'];
    ticketType = json['ticket_type'];
    price = json['price'];
    bookingDate = json['booking_date'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    event = json['event'] != null ? EventModel.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_id'] = eventId;
    data['user_id'] = userId;
    data['ticket_type'] = ticketType;
    data['price'] = price;
    data['booking_date'] = bookingDate;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (event != null) {
      data['event'] = event!.toJson();
    }
    return data;
  }
}

class Reviews {
  int? id;
  int? eventId;
  int? userId;
  String? comment;
  int? rating;
  String? createdAt;
  String? updatedAt;
  UserModel? user;
  EventModel? event;

  Reviews({
    this.id,
    this.eventId,
    this.userId,
    this.comment,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.event,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    userId = json['user_id'];
    comment = json['comment'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    event = json['event'] != null ? EventModel.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_id'] = eventId;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['rating'] = rating;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (event != null) {
      data['event'] = event!.toJson();
    }
    return data;
  }
}

class UserResponseModel {
  UserModel? user;
  String? token;

  UserResponseModel({this.user, this.token});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserModel {
  int? id;
  String? name;
  String? email;
  String? role;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
