class CityModel {
    String? formattedAddress;
    String? name;

    CityModel({
        this.formattedAddress,
        this.name,
    });

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        formattedAddress: json["formatted_address"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "formatted_address": formattedAddress,
        "name": name,
    };
}
