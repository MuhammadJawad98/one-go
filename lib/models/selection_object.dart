class SelectionObject {
  String id = '';
  String title = '';
  String titleAr = '';
  String value = '';
  String others = '';
  String image = '';
  String? minPrice;
  String? maxPrice;
  bool isSelected = false;
  bool isActive = false;
  dynamic data;

  SelectionObject({
    this.id = '',
    this.title = '',
    this.titleAr = '',
    this.value = '',
    this.image = '',
    this.isSelected = false,
    this.others = '',
    this.isActive = false,
    this.data,
    this.minPrice,
    this.maxPrice,
  });
}
