class CategoryModal {
  String label;
  String id;
  String image;

  CategoryModal({required this.id, required this.image, required this.label});

  static List<CategoryModal> getCategoriesList() {
    return [
      CategoryModal(
        id: "general",
        image: "assets/images/general.png",
        label: "General",
      ),
      CategoryModal(
        id: "business",
        image: "assets/images/busniess.png",
        label: "Business",
      ),
      CategoryModal(
        id: "sports",
        image: "assets/images/sport.png",
        label: "Sports",
      ),
      CategoryModal(
        id: "technology",
        image: "assets/images/technology.png",
        label: "Technology",
      ),
      CategoryModal(
        id: "entertainment",
        image: "assets/images/entertaimant.png",
        label: "Entertainment",
      ),
      CategoryModal(
        id: "health",
        image: "assets/images/health.png",
        label: "Health",
      ),
      CategoryModal(
        id: "science",
        image: "assets/images/science.png",
        label: "Science",
      ),
    ];
  }
}
