import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tws/apiService/AppConstant.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchBlog.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchCertificateType.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchClientWorkout.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchClients.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchExerciseByUserId.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchMembers.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchMembership.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchUnits.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchWorkout.dart';
import 'package:tws/apiService/apiResponse/ResponseFetchWorkoutId.dart';
import 'package:tws/apiService/apiResponse/ResponsePlans.dart';
import 'package:tws/apiService/apiResponse/ResponseProfile.dart';
import 'package:tws/apiService/apiResponse/responsefetchtransformation.dart';
import 'package:tws/apiService/diocleint.dart';
import 'package:tws/apiService/sharedprefrence.dart';

import 'apiResponse/ResponseFetchAppointment.dart';
import 'apiResponse/ResponseFetchCertificate.dart';
import 'apiResponse/ResponseFetchChatMessage.dart';
import 'apiResponse/ResponseFetchMealDiet.dart';
import 'apiResponse/ResponseQuestion.dart';

class APIRepository {
  DioClient dioClient;
  String _baseUrl = "http://fitnessapp.frantic.in/";

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(_baseUrl, dio);
  }

  ////////////////// Login Api ////////////////////////////////

  Future loginApi(String phone) async {
    FormData formData = new FormData.fromMap({"phone": phone});
    print(formData.fields);
    try {
      final response = await dioClient.post("AuthApi/login", data: formData);
      return response;
    } catch (e) {
      print("jjjjjjjjjjjjj" + e.toString());
    }
  }

  ////////////////// resend Api ////////////////////////////////

  Future resendApi() async {
    var number = await SharedPrefManager.getPrefrenceString(AppConstant.NUMBER);
    FormData formData = new FormData.fromMap({"phone": number});
    print(formData.fields);
    try {
      final response = await dioClient.post("AuthApi/login", data: formData);
      return response;
    } catch (e) {}
  }

  /////////////////// Verify Otp//////////////////////////////

  Future verifyOtpApi(String phone, String otp) async {
    FormData formData = new FormData.fromMap({"phone": phone, "otp": otp});
    print(formData.fields);
    try {
      final response =
          await dioClient.post("AuthApi/verify_otp", data: formData);
      return response;
    } catch (e) {}
  }

  /////////////////// RegisterApi//////////////////////////////

  Future registerApi(String email, String name) async {
    var phone = await SharedPrefManager.getPrefrenceString(AppConstant.NUMBER);
    FormData formData = new FormData.fromMap(
        {"phone": phone, "email": email, "name": name, "user_type": "TRAINER"});
    print(formData.fields);
    try {
      final response = await dioClient.post("AuthApi/register", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////////add CategoryApi/////////////

  Future addWorkOutApi(
      String categoryName, String description, File filename) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": categoryName,
      "description": description,
      "image": MultipartFile.fromFileSync(filename.path)
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/add_workout", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////////fetchWorkOutApi/////////////

  Future<ResponseFetchWorkOut> fetchWorkOutApi() async {
    ResponseFetchWorkOut responseFetchWorkOut;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });

    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/fetch_workout", data: formData);
      responseFetchWorkOut = ResponseFetchWorkOut.fromJson(response);
      return responseFetchWorkOut;
    } catch (e) {}
  }

  ////////////////////////fetchProfileApi/////////////

  Future<ResponseProfile> fetchProfileApi() async {
    ResponseProfile responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/profile", data: formData);
      responseProfile = ResponseProfile.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ///////////////////////////////add Member Api////////////////////////////////////

  Future addMemberApi(
      String memberName, String experience, String designation) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": memberName,
      "experience": experience,
      "designation": designation
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/add_member", data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////edit Profile Api////////////////////////////////////

  Future editProfileApi(
      File file, String bio, String address, String aadhaarCard) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "image": MultipartFile.fromFileSync(file.path),
      "bio": bio,
      "address": address,
      "aadhaar_card": aadhaarCard
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/edit_profile", data: formData);
      return response;
    } catch (e) {}
  }

  Future editProfileApiImage(
      File file, String bio, String address, String aadhaarCard) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "bio": bio,
      "address": address,
      "aadhaar_card": aadhaarCard
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/edit_profile", data: formData);
      return response;
    } catch (e) {}
  }

  Future privacyStatus(String status) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "privacy_status": status,
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/edit_profile", data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////add Payemnt Details Api////////////////////////////////////

  Future addPaymentDetails(
      File file,
      String paymentType,
      String accountHolderName,
      String bankName,
      String ifsc,
      String branch,
      String upi) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      // "cancelled_cheque_image": MultipartFile.fromFileSync(file.path),
      "payment_type": paymentType,
      // "account_holder_name": accountHolderName,
      // "bank_name": bankName,
      // "ifsc": ifsc,
      // "branch": branch,
      "upi": upi
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/edit_profile", data: formData);
      return response;
    } catch (e) {}
  }

  Future addPaymentDetailsCheque(
      File file,
      String paymentType,
      String accountHolderName,
      String bankName,
      String ifsc,
      String branch,
      String upi) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "cancelled_cheque_image": MultipartFile.fromFileSync(file.path),
      "payment_type": paymentType,
      "account_holder_name": accountHolderName,
      "bank_name": bankName,
      "ifsc": ifsc,
      "branch": branch
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/edit_profile", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetchUnits Api

  Future<ResponseFetchUnits> fetchUnitApi() async {
    ResponseFetchUnits responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/fetch_units", data: formData);
      responseProfile = ResponseFetchUnits.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ////////////////fetchOrganization Api /////////////////////

  Future<ResponseFetchCertificateType> fetchOrganisationApi() async {
    ResponseFetchCertificateType responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response = await dioClient.post("TrainerRestApi/fetch_organization",
          data: formData);
      responseProfile = ResponseFetchCertificateType.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ////////////////fetchCertificateTypeApi Api /////////////////////

  Future<ResponseFetchCertificateType> fetchCertificateTypeApi() async {
    ResponseFetchCertificateType responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/fetch_certificate_type", data: formData);
      responseProfile = ResponseFetchCertificateType.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ////////////////fetchPlans Api /////////////////////

  Future<ResponsePlans> fetchPlansApi() async {
    ResponsePlans responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/fetch_plans", data: formData);
      responseProfile = ResponsePlans.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ////////////////fetchCertificateApi Api /////////////////////

  Future<ResponseFetchCertificate> fetchCertificateApi() async {
    ResponseFetchCertificate responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response = await dioClient.post("TrainerRestApi/fetch_certificate",
          data: formData);
      responseProfile = ResponseFetchCertificate.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ///////////////////////////////new Certificate Api////////////////////////////////////

  Future newCertificateApi(File file, String certificateTye,
      String organisationName, String description) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "image": MultipartFile.fromFileSync(file.path),
      "certificate_type": certificateTye,
      "organisation_name": organisationName,
      "description": description
    });
    print(formData.fields);
    try {
      final response = await dioClient.post("TrainerRestApi/new_certificate",
          data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////add Transformation Api////////////////////////////////////

  Future addTransformationApi(File file, String description) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "image": MultipartFile.fromFileSync(file.path),
      "description": description
    });

    print(formData.fields);

    try {
      final response = await dioClient.post("TrainerRestApi/new_transformation",
          data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetchTransformation Api /////////////////////

  Future<ResponseFetchTransformation> fetchTransformation() async {
    ResponseFetchTransformation responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/fetch_transformation", data: formData);
      responseProfile = ResponseFetchTransformation.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  /////////////////////addNew exercise/////////////////////////////

  Future addNewExerCiseApi(
      File file, String name, String description, selectUnit) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var workoutId =
        await SharedPrefManager.getPrefrenceString(AppConstant.WORKOUTID);
    FormData formData = new FormData.fromMap({
      "key": key,
      "video": MultipartFile.fromFileSync(file.path),
      "name": name,
      "description": description,
      "you_tube_link": "",
      "selected_unit": selectUnit,
      "workout_id": workoutId
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/add_exercise", data: formData);
      return response;
    } catch (e) {}
  }

  /////////////////////add YoutubeLink Api/////////////////////////////

  Future addYoutubeLinkApi(
      String name, String description, String youtubelink, selectUnit) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var workoutId =
        await SharedPrefManager.getPrefrenceString(AppConstant.WORKOUTID);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": name,
      "description": description,
      "you_tube_link": youtubelink,
      "selected_unit": selectUnit,
      "workout_id": workoutId,
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/add_exercise", data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////// Fetch Category Id ///////////////////////////////

  Future<ResponseFetchWorkoutCategoryId> fetchExerCiseByWorkOutId() async {
    ResponseFetchWorkoutCategoryId responseFetchWorkOut;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var workOutId =
        await SharedPrefManager.getPrefrenceString(AppConstant.WORKOUTID);
    FormData formData =
        new FormData.fromMap({"key": key, "workout_id": workOutId});
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/fetch_exercise_by_workout_id", data: formData);
      responseFetchWorkOut = ResponseFetchWorkoutCategoryId.fromJson(response);
      return responseFetchWorkOut;
    } catch (e) {}
  }

  ///////////////////////////////addMembership Package Api////////////////////////////////////

  Future addMembershipPackageApi(String plan, String price, String name) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": name,
      "plan": plan,
      "price": price,
    });
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/add_membership_package", data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////editMembership Package Api////////////////////////////////////

  Future editMembershipApi(String plan, String price, String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "plan": plan,
      "price": price,
      "id": id,
    });
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/edit_membership_package", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetchMembershipPackage Api /////////////////////

  Future<ResponseFetchMembership> fetchMembershipPackage() async {
    ResponseFetchMembership responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/fetch_membership_package", data: formData);
      responseProfile = ResponseFetchMembership.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ///////////////////////////////create Blog APi////////////////////////////////////

  Future createBlogApi(String title, String description, File file, String link,
      String dropDownValue) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData;
    if (dropDownValue == "Image") {
      formData = new FormData.fromMap({
        "key": key,
        "title": title,
        "description": description,
        "link": "",
        "video": MultipartFile.fromFileSync(file.path)
      });
    } else {
      formData = new FormData.fromMap({
        "key": key,
        "title": title,
        "description": description,
        "link": link
      });
      print(formData.fields);
    }

    try {
      final response =
          await dioClient.post("TrainerRestApi/create_blog", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetchBlog Api /////////////////////

  Future<ResponseFetchBlog> fetchBlogApi() async {
    ResponseFetchBlog responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/fetch_blog_by_user_id", data: formData);
      responseProfile = ResponseFetchBlog.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ///////////////////////////////create Appointment APi////////////////////////////////////

  Future createAppointmentApi(
      String meetingType,
      String appointmentDate,
      String startTime,
      String endTime,
      String selectuser,
      String description,
      String link) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "meeting_type": meetingType,
      "appointment_date": appointmentDate,
      "start_time": startTime,
      "end_time": endTime,
      "selected_user": selectuser,
      "description": description,
      "meet_link": link,
    });
    print(formData.fields);
    try {
      final response = await dioClient.post("TrainerRestApi/create_appointment",
          data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////edit Appointment APi////////////////////////////////////

  Future editAppointmentApi(
      String meetingType,
      String appointmentDate,
      String startTime,
      String endTime,
      String selectuser,
      String description,
      String link,
      String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "meeting_type": meetingType,
      "appointment_date": appointmentDate,
      "start_time": startTime,
      "end_time": endTime,
      "selected_user": selectuser,
      "description": description,
      "meet_link": link,
      "id": id
    });

    print(formData.fields);

    try {
      final response = await dioClient.post("TrainerRestApi/edit_appointment",
          data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetchAppointment Api /////////////////////

  Future<ResponseFetchAppointment> fetchAppointmentApi() async {
    ResponseFetchAppointment responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/fetch_appointment_by_user_id", data: formData);
      responseProfile = ResponseFetchAppointment.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ////////////////fetchMembers Api /////////////////////

  Future<ResponseFetchMembers> fetchMembersApi() async {
    ResponseFetchMembers responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/fetch_member", data: formData);
      responseProfile = ResponseFetchMembers.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ///////////////////////////////edit Blog APi////////////////////////////////////

  Future editBlogApi(
      String title, String description, File file, String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "title": title,
      "description": description,
      "video": file,
      "id": id,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/edit_blog", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetch_clients Api /////////////////////

  Future<ResponseFetchCleints> fetchClientsApi() async {
    ResponseFetchCleints responseProfile;
    // key
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({"key": key});

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/fetch_clients", data: formData);
      responseProfile = ResponseFetchCleints.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ///////////////////////////////create New Dieth APi////////////////////////////////////

  Future createNewDietApi(String name, String fromDate, String toDate) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var userId = await SharedPrefManager.getPrefrenceString(
        AppConstant.CREATEDIETUSERID);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": name,
      "from_date": fromDate,
      "to_date": toDate,
      "user_id": userId,
    });
    print(formData.fields);
    try {
      final response = await dioClient.post("TrainerRestApi/create_new_diet",
          data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////create New Diet APi////////////////////////////////////

  Future createMealApi(
      String name, String mealTime, String note, String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var userId = await SharedPrefManager.getPrefrenceString(AppConstant.DIETID);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": name,
      "meal_time": mealTime,
      "diet_id": id,
      "note": note
    });

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/create_meal", data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////editMeal APi////////////////////////////////////

  Future editMealApi(String name, String mealTime, String mealId) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var userId = await SharedPrefManager.getPrefrenceString(AppConstant.DIETID);
    FormData formData = new FormData.fromMap(
        {"key": key, "name": name, "meal_time": mealTime, "id": mealId});
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/edit_meal", data: formData);

      return response;
    } catch (e) {}
  }

  ////////////////fetchMealApi /////////////////////

  Future<ResponseFetchMeal> fetchMealApi(String k) async {
    ResponseFetchMeal responseProfile;

    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var id = await SharedPrefManager.getPrefrenceString(AppConstant.DIETID);

    FormData formData = new FormData.fromMap({"key": key, "diet_id": k});

    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/fetch_meal_by_diet_id", data: formData);
      responseProfile = ResponseFetchMeal.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ///////////////////////////////add Foods Api////////////////////////////////////

  Future addFoodApi(
      String name, String protein, String carb, String fats) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": name,
      "protein": protein,
      "carbs": carb,
      "fats": fats,
    });
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/add_food", data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////add Foods to Meal Api////////////////////////////////////

  Future addFoodToMealApi(String id, String mealId) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    // var
    FormData formData =
        new FormData.fromMap({"key": key, "meal_id": mealId, "food_id": id});
    print(formData.fields);
    try {
      final response = await dioClient.post("TrainerRestApi/add_food_to_meal",
          data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////////////create New WorkOut APi////////////////////////////////////

  Future createClientWorkOutApi(
      String name, String fromDate, String toDate) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var userId = await SharedPrefManager.getPrefrenceString(
        AppConstant.CREATEDIETUSERID);
    FormData formData = new FormData.fromMap({
      "key": key,
      "name": name,
      "from_date": fromDate,
      "to_date": toDate,
      "user_id": userId,
    });
    print(formData.fields);
    try {
      final response = await dioClient
          .post("TrainerRestApi/create_client_workout", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetchWorkoutApi /////////////////////

  Future<ResponseFetchClientWorkout> fetchCleintWorkoutApi() async {
    ResponseFetchClientWorkout responseProfile;

    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var id = await SharedPrefManager.getPrefrenceString(
        AppConstant.CREATEDIETUSERID);

    FormData formData = new FormData.fromMap({"key": key, "user_id": id});

    print(formData.fields);

    try {
      final response = await dioClient.post(
          "TrainerRestApi/fetch_client_workout_by_user_id",
          data: formData);
      responseProfile = ResponseFetchClientWorkout.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  //////////////// fetchClientWorkoutDetailsApi /////////////////////

  Future reviewWorkoutbyDatesApi(String date, String workoutId) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap(
        {"key": key, "date": date, "workout_id": workoutId});

    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/review_workout_by_dates", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetchExerciseByUserId /////////////////////

  Future<ResponseFetchExerciseByUserId> fetchExerciseByUserId() async {
    ResponseFetchExerciseByUserId responseProfile;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({"key": key});
    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/fetch_exercise_by_user_id", data: formData);
      responseProfile = ResponseFetchExerciseByUserId.fromJson(response);
      return responseProfile;
    } catch (e) {}
  }

  ////////////////////////////add_exercise_to_client_workout////////////////////////////

  Future addExerciseToClientWorkout(
      String exerciseSuperset, Set setExerciseId, Set exerciseName) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var id =
        await SharedPrefManager.getPrefrenceString(AppConstant.CREATEWORKOUTID);
    FormData formData = new FormData.fromMap({
      "key": key,
      "client_workout_id": id,
      "exercise_superset": exerciseSuperset,
      "exercise_id_array[]": setExerciseId.toList(),
      "exercise_name_array[]": exerciseName.toList()
    });

    print(formData.fields);

    try {
      final response = await dioClient.post(
          "TrainerRestApi/add_exercise_to_client_workout",
          data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////fetchExerciseByUserId /////////////////////

  Future fetchWorkOutDetailsApi() async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var id =
        await SharedPrefManager.getPrefrenceString(AppConstant.CREATEWORKOUTID);

    FormData formData =
        new FormData.fromMap({"key": key, "client_workout_id": id});

    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/client_workout_details", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////add_to_set Api /////////////////////

  Future addTosetApi(String tag, id, String time, String setType) async {
    FormData formData;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    if (tag == "time") {
      formData = new FormData.fromMap({
        "key": key,
        "trainer_workout_exercise_id": id,
        "set_type": setType,
        "time": time,
      });
    } else if (tag == "breath") {
      formData = new FormData.fromMap({
        "key": key,
        "trainer_workout_exercise_id": id,
        "set_type": setType,
        "breath": time,
      });
    } else if (tag == "reps") {
      formData = new FormData.fromMap({
        "key": key,
        "trainer_workout_exercise_id": id,
        "set_type": setType,
        "reps": time,
      });
    } else if (tag == "km") {
      formData = new FormData.fromMap({
        "key": key,
        "trainer_workout_exercise_id": id,
        "set_type": setType,
        "km": time,
      });
    }
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/add_to_set", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////add_to_setTwoController Api /////////////////////

  Future addTosettwoControllerApi(
      String tag, id, String level, String time, String setType) async {
    FormData formData;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    if (tag == "level") {
      formData = new FormData.fromMap({
        "key": key,
        "trainer_workout_exercise_id": id,
        "set_type": setType,
        "time": time,
        "level": level
      });
    } else if (tag == "breathwithreps") {
      formData = new FormData.fromMap({
        "key": key,
        "trainer_workout_exercise_id": id,
        "set_type": setType,
        "breath": time,
        "reps": level
      });
    } else if (tag == "weightwithreps") {
      formData = new FormData.fromMap({
        "key": key,
        "trainer_workout_exercise_id": id,
        "set_type": setType,
        "kg": time,
        "reps": level
      });
    }
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/add_to_set", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////editToSetController Api /////////////////////

  Future editToSetControllerApi(String tag, id, String level) async {
    FormData formData;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    if (tag == "time") {
      formData =
          new FormData.fromMap({"key": key, "set_id": level, "time": id});
    } else if (tag == "km") {
      formData = new FormData.fromMap({"key": key, "set_id": level, "km": id});
    } else if (tag == "level") {
      formData =
          new FormData.fromMap({"key": key, "set_id": level, "level": id});
    } else if (tag == "breath") {
      formData =
          new FormData.fromMap({"key": key, "set_id": level, "breath": id});
    } else if (tag == "reps") {
      formData =
          new FormData.fromMap({"key": key, "set_id": level, "reps": id});
    } else if (tag == "kg") {
      formData = new FormData.fromMap({"key": key, "set_id": level, "kg": id});
    }
/*    else if(tag == "breathwithreps"){
      formData = new FormData.fromMap({
        "key": key,
        "set_id": id,
        "breath":time,
        "reps":level
      });
    }else if(tag == "weightwithreps"){
      formData = new FormData.fromMap({
        "key": key,
        "set_id": id,
        "kg":time,
        "reps":level
      });
    }*/
    print(formData.fields);
    try {
      final response =
          await dioClient.post("TrainerRestApi/edit_to_set", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////remove exercise /////////////////

  Future removeExerCiseApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/remove_client_exercise", data: formData);

      return response;
    } catch (e) {}
  }

  ////////////////////remove mealApi /////////////////

  Future removeMealApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/remove_meal", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////remove foodApi /////////////////

  Future removeFoodApi(String id, String mealId) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData =
        new FormData.fromMap({"key": key, "id": id, "meal_id": mealId});

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/remove_food", data: formData);

      return response;
    } catch (e) {}
  }

  ////////////////////remove Feeds /////////////////

  Future removeFeedsApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/remove_blog", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////remove Appointment /////////////////

  Future removeAppointmentApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response = await dioClient.post("TrainerRestApi/remove_appointment",
          data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////remove exercise /////////////////

  Future removePackageApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/delete_membership_package", data: formData);

      return response;
    } catch (e) {}
  }

  ////////////// remove Member Api ///////////////

  Future removeMemberApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/remove_member", data: formData);

      return response;
    } catch (e) {}
  }

  ////////////////////dietListApi /////////////////

  Future dietListApi() async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var clientId = await SharedPrefManager.getPrefrenceString(
        AppConstant.CREATEDIETUSERID);

    FormData formData = new FormData.fromMap({"key": key, "user_id": clientId});

    print(formData.fields);

    try {
      final response =
          await dioClient.post("TrainerRestApi/diet_list", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////reviewDietDatesApi /////////////////

  Future reviewDietDatesApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "diet_id": id});

    print(formData.fields);

    try {
      final response = await dioClient.post("TrainerRestApi/review_diet_dates",
          data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////reviewDietByDatesApi/////////////////

  Future reviewDietByDatesApi(String id, String date) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData =
        new FormData.fromMap({"key": key, "diet_id": id, "date": date});

    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/review_diet_by_dates", data: formData);
      return response;
    } catch (e) {}
  }

  ///////////////////////// beforeexercise //////////////////////////////////////////////

  Future beforExerciseApi(String fromDate, String toDate, String exercise,
      String set, String set1) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId = await SharedPrefManager.getPrefrenceString(
        AppConstant.CREATEDIETUSERID);
    var workoutId =
        await SharedPrefManager.getPrefrenceString(AppConstant.CREATEWORKOUTID);

    List<String> workId = [];
    List<String> exerciseArray = [];
    List<String> sets = [];
    List<String> set11 = [];

    workId.add(workoutId);
    exerciseArray.add(exercise);
    sets.add(set);
    set11.add(set1);

    try {
      FormData formData = new FormData.fromMap({
        "key": key,
        "user_id": key,
        "trainer_id": trainerId,
        "workout[]": workId,
        "from_date": fromDate,
        "to_date": toDate,
        "exercise[]": exerciseArray,
        "set[]": sets,
        "set1[]": set11
      });
      print(formData.fields);
      final response = await dioClient.post("TrainerRestApi/before_exercise",
          data: formData);
      return response;
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////////////SEND MESSAGE Api/////////////////////////////////////

  Future sendMessageApi(msg) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId = await SharedPrefManager.getPrefrenceString(
        AppConstant.CREATEDIETUSERID);
    try {
      FormData formData =
          new FormData.fromMap({"key": key, "msg_to": trainerId, "msg": msg});
      print(formData.fields);
      final response =
          await dioClient.post("TrainerRestApi/send_message", data: formData);
      return response;
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////////////New SEND MESSAGE Api////////////////////////////////////////////

  Future newSendMessageApi(msg, filename) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId = await SharedPrefManager.getPrefrenceString(
        AppConstant.CREATEDIETUSERID);
    try {
      FormData formData = new FormData.fromMap({
        "key": key,
        "msg_to": trainerId,
        "msg": "",
        "image": MultipartFile.fromFileSync(filename.path)
      });

      final response =
          await dioClient.post("TrainerRestApi/send_message", data: formData);
      return response;
    } catch (e) {
      print(e);
    }
  }

  ///////////////////////////////// fetchIndividualChatApi //////////////////////////

  ResponseFetchChatMessage responseIndividudal;

  Future<ResponseFetchChatMessage> fetchIndividualChat() async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    var trainerId = await SharedPrefManager.getPrefrenceString(
        AppConstant.CREATEDIETUSERID);

    try {
      FormData formData =
          new FormData.fromMap({"key": key, "msg_to": trainerId});

      print(formData.fields);

      final response =
          await dioClient.post("TrainerRestApi/fetch_message", data: formData);
      responseIndividudal = ResponseFetchChatMessage.fromJson(response);
      return responseIndividudal;
    } catch (e) {
      print(e);
    }
  }

  ////////////////////delete certificate Api /////////////////

  Future deleteCertificateApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response = await dioClient.post("TrainerRestApi/delete_certificate",
          data: formData);

      return response;
    } catch (e) {}
  }

  ////////////////////delete workout Api /////////////////

  Future deleteWorkoutApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response = await dioClient.post("TrainerRestApi/trainer_workout",
          data: formData);

      return response;
    } catch (e) {}
  }

  ////////////////////edit certificate Api /////////////////

  Future editCertificateApi(
      String id, String type, description, File file, String newId) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({
      "key": key,
      "id": newId,
      "image": MultipartFile.fromFileSync(file.path),
      "certificate_type": type,
      "organisation_name": "static organisation",
      "description": description,
    });

    print(formData.fields);

    try {
      final response = await dioClient.post("TrainerRestApi/edit_certificate",
          data: formData);

      return response;
    } catch (e) {}
  }

  ////////////////////delete category Api /////////////////

  Future deleteCategoryApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/delete_workout_category_3", data: formData);
      return response;
    } catch (e) {}
  }

  ////////////////////remove Client Workout Api ///////////////////////

  Future removeClientWorkOutApi(String id) async {
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);

    FormData formData = new FormData.fromMap({"key": key, "id": id});

    print(formData.fields);

    try {
      final response = await dioClient
          .post("TrainerRestApi/remove_client_workout", data: formData);

      return response;
    } catch (e) {}
  }

  ////////////////////////questionApi/////////////

  Future<ResponseQuestion> questionApi() async {
    ResponseQuestion responseQuestion;
    var key = await SharedPrefManager.getPrefrenceString(AppConstant.KEY);
    FormData formData = new FormData.fromMap({"key": key});
    print(formData.fields);

    try {
      final response =
          await dioClient.post("UserRestApi/fetch_question", data: formData);
      responseQuestion = ResponseQuestion.fromJson(response);
      return responseQuestion;
    } catch (e) {}
  }
}
