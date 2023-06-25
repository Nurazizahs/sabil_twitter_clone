class AppwriteConstants {
  static const String databaseId = '6453c102c098ffd56351';
  static const String projectId = '642a3ffc02bb21fe54cc';
  static const String endPoint = 'https://baas.pasarjepara.com/v1';
  
  static const String imagesBucket = '648ff53b3987fa4b6762';
  static const String usersCollection = '647f6df177efc81d3129';
  static const String tweetsCollection = '648ff5f2434d1ac9f919';
  // static const String usersCollection = '647f6df177efc81d3129';

    static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}