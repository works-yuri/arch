// {first_name: null, email: works.yura@gmail.com, phone: 380669958227, city: null, locale: ru, gps_allowed: false, subscribed: true, country: UA, show_promo_code: false, demo_filled: false, verification_status: waiting, phone_mask: 380999999999, demo_survey_id: null, verification_survey_id: null, show_rating_window: false, languages: [uk, ru], email_confirmed: false, show_promo_code_menu: true, has_email: true, country_name: Україна, birth_date: null, is_survey_tester: false, is_staff: false, is_superuser: false, id: 507}
class ProfileResponse {
  final String first_name;
  final String email;
  final String phone;
  final String city;

  ProfileResponse({
    required this.first_name,
    required this.email,
    required this.phone,
    required this.city,
  });

  factory ProfileResponse.fromMap(Map<String, dynamic> value) {
    return ProfileResponse(
      first_name: value['first_name'] ?? '',
      email: value['email'] ?? '',
      phone: value['phone'] ?? '',
      city: value['city'] ?? '',
    );
  }
}
