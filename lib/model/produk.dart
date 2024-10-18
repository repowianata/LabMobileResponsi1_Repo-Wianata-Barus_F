class Produk {
  int? id;
  String? food_item;
  int? calories;
  int? fat_content;
  Produk({this.id, this.food_item, this.calories, this.fat_content});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        food_item: obj['food_item'],
        calories: obj['calories'],
        fat_content: obj['fat_content']);
  }
}
