abstract class ApiConsumer {
  Future getData(String path, {Map<String, dynamic>? queryParameters});

  Future postData(String path,

      {
        bool isFormData = false ,
        Map<String, dynamic>? body,
        Map<String, dynamic>? queryParameters});

  Future putData(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters});


}
