import ...
final fi = FirebaseFirestore.instance;

final userFR = fi.collection("users");
final quizePaperFR = fi.collection("quizePapers");
final leaderBoardFR = fi.collection("leaderBoard");

DocumentReference recentQuizesData({required String userId, required String paperId})
collectionReference<Map<String, dynamic>> recent






late FirebaseAuth _auth;
final _user = Rxn<User>();
late Stream<User?> _authStateChanges;

void initAuth() async{
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
        _user.value = user;
    });
    navigateToIntroduction();
}

Future<void> signInwithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

try{
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if(account != null){
        final _gAuthentication = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _gAuthentication.idToken,
            accessToken: _gAuthentication.accessToken);
            await _auth.signInWithCredential(_credential);
            await saveUser(account);
            navigateToHome();
    }
    } on Exception catch(error){
        AppLogger.e(error);
}
}
Future<void> saveUser(GoogleSignInAccount account) async {
    userFR
        .doc(account.email)
        .set({
            "name": account.displayName,
            "email": account.email,
            "profilePic": account.photoUrl
        });
        print("......saved user data....");
}