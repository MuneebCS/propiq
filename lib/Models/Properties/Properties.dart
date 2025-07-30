class Property {
  final int id;
  final Address address;
  final Location location;
  final int beds;
  final int baths;
  final int sqft;
  final int arv;
  final String status;
  final double score;
  final String classification;
  final int lastSalePrice;
  final DateTime lastSaleDate;
  final Seller seller;
  late final bool? revealed;
  final String? sellerNotes;
  final bool? exclusive;
  final String? exclusiveTime;
  final int? revealCount;

  Property({
    required this.id,
    required this.address,
    required this.location,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.arv,
    required this.status,
    required this.score,
    required this.classification,
    required this.lastSalePrice,
    required this.lastSaleDate,
    required this.seller,
    this.revealed,
    this.sellerNotes,
    this.exclusive,
    this.exclusiveTime,
    this.revealCount,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json['id'],
    address: Address.fromJson(json['address']),
    location: Location.fromJson(json['location']),
    beds: json['beds'],
    baths: json['baths'],
    sqft: json['sqft'],
    arv: json['arv'],
    status: json['status'],
    score: json['score'].toDouble(),
    classification: json['classification'],
    lastSalePrice: json['lastSalePrice'],
    lastSaleDate: DateTime.parse(json['lastSaleDate']),
    seller: Seller.fromJson(json['seller']),
    revealed: json['revealed'],
    sellerNotes: json['sellerNotes'],
    exclusive: json['exclusive'],
    exclusiveTime: json['exclusiveTime'],
    revealCount: json['revealCount'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'address': address.toJson(),
    'location': location.toJson(),
    'beds': beds,
    'baths': baths,
    'sqft': sqft,
    'arv': arv,
    'status': status,
    'score': score,
    'classification': classification,
    'lastSalePrice': lastSalePrice,
    'lastSaleDate': lastSaleDate.toIso8601String(),
    'seller': seller.toJson(),
    'revealed': revealed,
    'sellerNotes': sellerNotes,
    'exclusive': exclusive,
    'exclusiveTime': exclusiveTime,
    'revealCount': revealCount,
  };
}

class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'],
    city: json['city'],
    state: json['state'],
    zipCode: json['zipCode'],
    country: json['country'],
  );

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'state': state,
    'zipCode': zipCode,
    'country': country,
  };
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json['latitude'],
    longitude: json['longitude'],
  );

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
  };
}

class Seller {
  final int id;
  final String name;
  final String email;
  final List<String> phones;

  Seller({
    required this.id,
    required this.name,
    required this.email,
    required this.phones,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phones: List<String>.from(json['phones']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phones': phones,
  };
}
