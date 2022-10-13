
 class HomePageResponse {
   HomePageResponse({
     this.ads,
     this.packages,
     this.addons,
     // this.orderSettings,
     this.notificationCount,
   });

   List<Ad>? ads;
   Packages? packages;
   List<Packages>? addons;
   // OrderSettings? orderSettings;
   int? notificationCount;

   factory HomePageResponse.fromJson(Map<String, dynamic> json) => HomePageResponse(
     ads: List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
     packages: Packages.fromJson(json["packages"]),
     addons: List<Packages>.from(json["addons"].map((x) => Packages.fromJson(x))),
     // orderSettings: OrderSettings.fromJson(json["orderSettings"]),
     notificationCount: json["notificationCount"],
   );


 }
 class Ad {
   Ad({
     this.id,
     this.image,
   });

   int? id;
   String? image;

   factory Ad.fromJson(Map<String, dynamic> json) => Ad(
     id: json["id"],
     image: json["image"],
   );

 }

 class Packages {
   Packages({
     this.id,
     this.name,
     this.nameAr,
     this.items,
   });

   int? id;
   String? name;
   String? nameAr;
   List<Item>? items;

   factory Packages.fromJson(Map<String, dynamic> json) => Packages(
     id: json["id"],
     name: json["name"],
     nameAr: json["nameAR"],
     items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
   );

 }

 class Item {
   Item({
     this.id,
     this.image,
     this.imageAr,
     this.title,
     this.titleAr,
     this.description,
     this.descriptionAr,
     this.price,
     this.tax,
     this.isFavorite,
     this.min,
     this.max,
     this.increment,
     this.isShisha,
     this.isSoldPerPackage,
     this.selectedQuantity
   });

   int? id;
   String? image;
   String? imageAr;
   String? title;
   String? titleAr;
   String? description;
   String? descriptionAr;
   int? price;
   int? tax;
   bool? isFavorite;
   int? min;
   int? max;
   int? increment;
   bool? isShisha;
   bool? isSoldPerPackage;
   int? selectedQuantity;


   factory Item.fromJson(Map<String, dynamic> json) => Item(
     id: json["id"],
     image: json["image"],
     imageAr: json["imageAR"],
     title: json["title"],
     titleAr: json["titleAR"],
     description: json["description"],
     descriptionAr: json["descriptionAR"],
     price: json["price"],
     tax: json["tax"],
     isFavorite: json["isFavorite"],
     min: json["min"],
     max: json["max"],
     increment: json["increment"],
     isShisha: json["isShisha"],
     isSoldPerPackage: json["isSoldPerPackage"],

   );

   Map<String, dynamic> toJson() => {
     "id": id,
     "image": image,
     "imageAR": imageAr,
     "title": title,
     "titleAR": titleAr,
     "description": description,
     "descriptionAR": descriptionAr,
     "price": price,
     "tax": tax,
     "isFavorite": isFavorite,
     "min": min,
     "max": max,
     "increment": increment,
     "isShisha": isShisha,
     "isSoldPerPackage": isSoldPerPackage,
   };
 }


 //
 // class OrderSettings {
 //   OrderSettings({
 //     this.isDabberniOn,
 //     this.hoursOfDaberni,
 //     this.tax,
 //     this.numberOfGuests,
 //
 //     this.setupItems,
 //   });
 //
 //   bool? isDabberniOn;
 //   int? hoursOfDaberni;
 //   int? tax;
 //   List<NumberOfGuest>? numberOfGuests;
 //
 //   List<NumberOfGuest> setupItems;
 //
 //   factory OrderSettings.fromJson(Map<String, dynamic> json) => OrderSettings(
 //     isDabberniOn: json["isDabberniOn"],
 //     hoursOfDaberni: json["hoursOfDaberni"],
 //     tax: json["tax"],
 //     numberOfGuests: List<NumberOfGuest>.from(json["numberOfGuests"].map((x) => NumberOfGuest.fromJson(x))),
 //
 //     setupItems: List<NumberOfGuest>.from(json["setupItems"].map((x) => NumberOfGuest.fromJson(x))),
 //   );
 //
 //
 // }
 //
 // class NumberOfGuest {
 //   NumberOfGuest({
 //     this.id,
 //     this.title,
 //     this.titleAr,
 //   });
 //
 //   int? id;
 //   String? title;
 //   String? titleAr;
 //
 //   factory NumberOfGuest.fromJson(Map<String, dynamic> json) => NumberOfGuest(
 //     id: json["id"],
 //     title: json["title"],
 //     titleAr: json["titleAR"],
 //   );
 //
 // }
