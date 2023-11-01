import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();


  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var varificationId= ''.obs;

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }


  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    // user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => const Dashboard());
  }


  //FUNC
  Future<void> phoneauth(String phnNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phnNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e){

        }, codeSent: (verificationId,resendToken){

      this.varificationId.value=verificationId;

    }, codeAutoRetrievalTimeout: (verificationId){
      this.varificationId.value=verificationId;
    });
  }

  Future<String?> verifyOtp(String otp) async {

   try{
     var credentials=await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.varificationId.value, smsCode: otp));
     print(credentials);

     return credentials.user?.uid;
   }
   catch(E){
     print(E.toString());
   }
  }

  Future<void> logout() async => await _auth.signOut();
}