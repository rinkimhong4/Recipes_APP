import 'dart:convert';

AboutUsModels aboutUsModelsFromJson(String str) =>
    AboutUsModels.fromJson(json.decode(str));

class AboutUsModels {
  About? about;
  Mission? mission;
  Features? features;
  Mission? whyChooseUs;

  AboutUsModels({this.about, this.mission, this.features, this.whyChooseUs});

  factory AboutUsModels.fromJson(Map<String, dynamic> json) => AboutUsModels(
    about: json["about"] != null ? About.fromJson(json["about"]) : null,
    mission: json["mission"] != null ? Mission.fromJson(json["mission"]) : null,
    features:
        json["features"] != null ? Features.fromJson(json["features"]) : null,
    whyChooseUs:
        json["whyChooseUs"] != null
            ? Mission.fromJson(json["whyChooseUs"])
            : null,
  );
}

class About {
  String? title;
  List<String>? description;

  About({this.title, this.description});

  factory About.fromJson(Map<String, dynamic> json) => About(
    title: json["title"],
    description:
        json["description"] != null
            ? List<String>.from(json["description"].map((x) => x.toString()))
            : null,
  );
}

class Features {
  String? title;
  List<Item>? items;

  Features({this.title, this.items});

  factory Features.fromJson(Map<String, dynamic> json) => Features(
    title: json["title"],
    items:
        json["items"] != null
            ? List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
            : null,
  );
}

class Item {
  String? name;
  dynamic description;

  Item({this.name, this.description});

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(name: json["name"], description: json["description"]);

  Map<String, dynamic> toJson() => {"name": name, "description": description};
}

class Mission {
  String? title;
  String? description;

  Mission({this.title, this.description});

  factory Mission.fromJson(Map<String, dynamic> json) =>
      Mission(title: json["title"], description: json["description"]);

  Map<String, dynamic> toJson() => {"title": title, "description": description};
}
