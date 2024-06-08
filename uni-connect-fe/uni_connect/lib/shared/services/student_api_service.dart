
import '../../models/request/student_request.dart';

class StudentApiService {


    static String? _apiVersion;
    static String? _controllerMethod;

    static String? _baseUrl;
    static String? _appName;

    void setVersion(String version) {
    _apiVersion = version;
    }

    void setMethod(String method) {
    _controllerMethod = method;
    }

    void setBaseUrl(String url) {
    _baseUrl = url;
    }

    void setAppName(String app) {
    _appName = app;
    }

    String build() {
      if (_apiVersion == null || _controllerMethod == null || _baseUrl == null || _appName == null) {
      throw Exception("API version, controller method, base URL, and app name must be specified");
        }
        final url = '$_baseUrl/$_appName/$_apiVersion/$_controllerMethod';
      return url;
    }

    String buildUrl(String appName, String baseUrl, String version, String method) {
        setAppName(appName);
        setBaseUrl(baseUrl);
        setVersion(version);
        setMethod(method);
        return build();
    }

    Map<String,String> getHeaders(){
      return {
      'Access-Control-Allow-Origin': '*',
      'Content-Type':'application/json'
      };
    }



    /// Body - SignUp - method - Student SignUp Request
    StudentSignupRequest getBodySignUpMethod(String email, String password,String fullName,String studentDepartement){

      StudentSignupRequest studentRequest = StudentSignupRequest(email: email, passwordHash: password, fullName: fullName, departement: studentDepartement);
      return studentRequest;
    }


    /// Body - SignIn - method - Student SignIn Request
    StudentSigninRequest getBodySignInMethod(String email, String password, String selectedDepartement) {
      StudentSigninRequest studentRequest = StudentSigninRequest(email: email, passwordHash: password, department: selectedDepartement);
      return studentRequest;
    }
}


