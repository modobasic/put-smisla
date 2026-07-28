import 'package:flutter/material.dart';

import '../db/app_database.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
const LoginScreen({super.key});

@override
State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

bool _loading = false;

@override
void dispose() {
_usernameController.dispose();
_passwordController.dispose();
super.dispose();
}

Future<void> _login() async {
final username = _usernameController.text.trim();
final password = _passwordController.text.trim();

if (username.isEmpty || password.isEmpty) {
_showMessage("Unesi korisničko ime i lozinku.");
return;
}

setState(() => _loading = true);

final user = await AppDatabase.instance.loginUser(username, password);

if (!mounted) return;
setState(() => _loading = false);

if (user == null) {
_showMessage("Korisnik ne postoji ili je lozinka pogrešna.");
return;
}

final userId = user['id'] as int;

Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (_) => HomeScreen(userId: userId),
),
);
}

Future<void> _register() async {
final username = _usernameController.text.trim();
final password = _passwordController.text.trim();

if (username.isEmpty || password.isEmpty) {
_showMessage("Unesi korisničko ime i lozinku.");
return;
}

setState(() => _loading = true);

try {
final userId = await AppDatabase.instance.registerUser(username, password);

if (!mounted) return;
setState(() => _loading = false);

Navigator.pushReplacement(
context,
MaterialPageRoute(
builder: (_) => HomeScreen(userId: userId),
),
);
} catch (_) {
if (!mounted) return;
setState(() => _loading = false);
_showMessage("Korisničko ime već postoji. Pokušaj s drugim imenom.");
}
}

void _showMessage(String text) {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(text),
behavior: SnackBarBehavior.floating,
),
);
}

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const darkLilac = Color.fromARGB(255, 167, 85, 214);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

return Scaffold(
body: Container(
width: double.infinity,
height: double.infinity,
decoration: const BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [
lightLilac,
almostWhiteLilac,
Colors.white,
],
),
),
child: SafeArea(
child: Center(
child: SingleChildScrollView(
padding: const EdgeInsets.all(22),
child: Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(34),
gradient: const LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [
Color(0xFFF3E8FF),
almostWhiteLilac,
Colors.white,
],
),
border: Border.all(
color: lightLilac,
width: 1.4,
),
boxShadow: [
BoxShadow(
blurRadius: 30,
offset: const Offset(0, 18),
color: darkLilac.withValues(alpha: 0.18),
),
],
),
child: Padding(
padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Container(
width: 104,
height: 104,
padding: const EdgeInsets.all(6),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(30),
color: darkLilac.withValues(alpha: 0.18),
boxShadow: [
BoxShadow(
blurRadius: 24,
offset: const Offset(0, 13),
color: darkLilac.withValues(alpha: 0.22),
),
],
),
child: ClipRRect(
borderRadius: BorderRadius.circular(24),
child: Image.asset(
'assets/icons/logo.png',
fit: BoxFit.cover,
),
),
),
const SizedBox(height: 22),
Text(
"Dobrodošli!",
textAlign: TextAlign.center,
style: Theme.of(context).textTheme.headlineSmall?.copyWith(
color: deepPurple,
fontSize: 36,
fontWeight: FontWeight.w900,
),
),
const SizedBox(height: 10),
Text(
"Prijavi se ili napravi korisnički profil kako bi se tvoj napredak spremao.",
textAlign: TextAlign.center,
style: Theme.of(context).textTheme.bodyLarge?.copyWith(
color: deepPurple,
fontSize: 18,
fontWeight: FontWeight.w600,
height: 1.45,
),
),
const SizedBox(height: 26),
TextField(
controller: _usernameController,
style: const TextStyle(
fontSize: 18,
color: deepPurple,
fontWeight: FontWeight.w700,
),
decoration: const InputDecoration(
labelText: "Korisničko ime",
prefixIcon: Icon(Icons.person_rounded),
),
),
const SizedBox(height: 16),
TextField(
controller: _passwordController,
obscureText: true,
style: const TextStyle(
fontSize: 18,
color: deepPurple,
fontWeight: FontWeight.w700,
),
decoration: const InputDecoration(
labelText: "Lozinka",
prefixIcon: Icon(Icons.lock_rounded),
),
),
const SizedBox(height: 24),
if (_loading)
const CircularProgressIndicator(color: deepPurple)
else ...[
SizedBox(
width: double.infinity,
height: 58,
child: DecoratedBox(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(25),
gradient: const LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [
darkLilac,
deepPurple,
],
),
boxShadow: [
BoxShadow(
blurRadius: 18,
offset: const Offset(0, 10),
color: darkLilac.withValues(alpha: 0.28),
),
],
),
child: FilledButton.icon(
style: FilledButton.styleFrom(
backgroundColor: Colors.transparent,
shadowColor: Colors.transparent,
foregroundColor: Colors.white,
),
onPressed: _login,
icon: const Icon(Icons.login_rounded),
label: const Text("Prijavi se"),
),
),
),
const SizedBox(height: 12),
SizedBox(
width: double.infinity,
height: 56,
child: OutlinedButton.icon(
style: OutlinedButton.styleFrom(
backgroundColor: almostWhiteLilac,
foregroundColor: deepPurple,
side: const BorderSide(
color: darkLilac,
width: 1.7,
),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(25),
),
textStyle: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.w900,
),
),
onPressed: _register,
icon: const Icon(Icons.person_add_alt_1_rounded),
label: const Text("Registriraj se"),
),
),
],
],
),
),
),
),
),
),
),
);
}
}

