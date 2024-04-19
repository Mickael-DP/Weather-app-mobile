// Data model pour agreger les parties pertinentes de la réponse de l'API open weather map
class GroupedWeather {
  int min;
  int max;
  String description;
  String icon;
  String day;

  // Ctor
  GroupedWeather(this.min, this.max, this.description, this.icon, this.day);
}
