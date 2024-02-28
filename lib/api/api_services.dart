import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://drplusapp.in/admin";
  static const String adminBaseUrl ="https://drplusapp.in/admin/app/v1/api/login" ;
  static const String imageUrl = "https://drplusapp.in/";
  static const String userRegister = baseUrl+'user_register';
  static const String getPharmaCategory = baseUrl+'select_category';
  static const String getPharmaProductsCategory = baseUrl+'pharma_category';
  static const String getPharmaProducts = baseUrl+'get_products';
  static const String sendOTP = baseUrl+'send_otp';
  static const String login = baseUrl+'login';
  static const String verifyOtp = baseUrl+'v_verify_otp';
  static const String getSlider = baseUrl + 'get_slider_images';
  static const String getUserProfile = baseUrl+'user_profile';
  static const String getEvents = baseUrl+'get_events';
    static const String getWebinar = baseUrl+'get_webinar';
  static const String job_edit = baseUrl+'job_edit';
  static const String update_job_post = baseUrl+'update_job_post';
  static const String applied_seeker = baseUrl+'applied_seeker';
  static const String seeker_info = baseUrl+'seeker_info';
  static const String user_profile_update = baseUrl+'user_profile_update';
  static const String recruiter_profile_update = baseUrl+'recruiter_profile_update';
  static const String adminLogin = adminBaseUrl+'login';
}
