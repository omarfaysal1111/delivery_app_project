import 'package:flutter_bloc/flutter_bloc.dart';
import 'phone_change_state.dart';

class PhoneChangeCubit extends Cubit<PhoneChangeState> {
  PhoneChangeCubit() : super(PhoneChangeInitial());

  String? currentPhone;
  String? newPhone;

  Future<void> verifyCurrentPhone(String phone) async {
    emit(PhoneChangeLoading());
    // Mock network call
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real scenario, we would validate with backend or AuthRepository
    if (phone.length >= 9) {
      currentPhone = phone;
      emit(CurrentPhoneVerified());
    } else {
      emit(const PhoneChangeError('invalidPhone')); // Using ARB key later
    }
  }

  Future<void> submitNewPhone(String phone) async {
    emit(PhoneChangeLoading());
    // Mock network call
    await Future.delayed(const Duration(seconds: 1));
    
    if (phone.length >= 9 && phone != currentPhone) {
      newPhone = phone;
      emit(OtpSent());
    } else {
      emit(const PhoneChangeError('invalidPhone'));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(PhoneChangeLoading());
    // Mock network call
    await Future.delayed(const Duration(seconds: 1));
    
    if (otp == '123456') {
      emit(PhoneChangedSuccessfully());
    } else {
      emit(const PhoneChangeError('Invalid OTP. Use 123456.'));
    }
  }
}
