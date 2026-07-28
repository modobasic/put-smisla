import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/levels_data.dart';
import '../db/app_database.dart';
import 'level_screen.dart';
import 'notes/notes_list.dart';
import 'splash_screen.dart';
import 'widgets.dart';

class HomeScreen extends StatefulWidget {
final int userId;

const HomeScreen({
super.key,
required this.userId,
});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
late Future<List<Map<String, Object?>>> _progressFuture;

@override
void initState() {
super.initState();
_loadProgress();
}

void _loadProgress() {
_progressFuture = AppDatabase.instance.getProgress(widget.userId);
}

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const darkLilac = Color.fromARGB(255, 167, 85, 214);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

final cs = Theme.of(context).colorScheme;

return Scaffold(
appBar: AppBar(
leading: IconButton(
icon: const Icon(Icons.arrow_back_rounded),
tooltip: "Natrag na naslovnicu",
onPressed: () {
Navigator.pushReplacement(
context,
MaterialPageRoute(builder: (_) => const SplashScreen()),
);
},
),
title: const Text("Logoterapija • Leveli"),
),
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
child: FutureBuilder<List<Map<String, Object?>>>(
future: _progressFuture,
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return const Center(
child: CircularProgressIndicator(color: deepPurple),
);
}

if (snapshot.hasError) {
return Center(
child: Padding(
padding: const EdgeInsets.all(20),
child: Text(
"Greška pri učitavanju napretka:\n${snapshot.error}",
textAlign: TextAlign.center,
),
),
);
}

final progressRows = snapshot.data ?? [];

final completedCount = progressRows
.where((row) => row['isCompleted'] == 1)
.length;

return ListView(
padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
children: [
HeroHeader(
title: "Put smisla",
subtitle:
"3 razine • edukacija + kviz • praćenje napretka\nEdukativno-samorefleksivna aplikacija",
accent: cs.primary,
),
const SizedBox(height: 12),
_PremiumActionCard(
title: "Moje refleksije",
subtitle: "Zapiši misli, uvide i male pobjede kroz svoj put.",
icon: Icons.note_alt_rounded,
onTap: () {
HapticFeedback.selectionClick();
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => NotesListScreen(userId: widget.userId),
),
);
},
),
const SizedBox(height: 14),
ProgressCard(
completed: completedCount,
total: kLevels.length,
),
const SizedBox(height: 16),
Text(
"Razine",
style: Theme.of(context).textTheme.titleLarge?.copyWith(
color: deepPurple,
fontSize: 29,
fontWeight: FontWeight.w900,
),
),
const SizedBox(height: 10),
...List.generate(kLevels.length, (i) {
final level = kLevels[i];
final lessonId = i + 1;

final progressRow = progressRows.firstWhere(
(row) => row['lessonId'] == lessonId,
orElse: () => {
'lessonId': lessonId,
'isCompleted': 0,
'bestScore': 0,
'unlocked': lessonId == 1 ? 1 : 0,
},
);

final locked = progressRow['unlocked'] != 1;
final best = progressRow['bestScore'] as int? ?? 0;
final total = 3;

return Padding(
padding: const EdgeInsets.only(bottom: 12),
child: LevelTile(
index: i,
title: level.title,
subtitle: level.subtitle,
locked: locked,
bestScoreText: best == 0
? "Još nije riješeno"
: "Najbolje: $best/$total",
onTap: locked
? null
: () async {
HapticFeedback.selectionClick();

await Navigator.push(
context,
MaterialPageRoute(
builder: (_) => LevelScreen(
userId: widget.userId,
lessonId: lessonId,
levelIndex: i,
),
),
);

if (!mounted) return;

setState(() {
_loadProgress();
});
},
),
);
}),
const SizedBox(height: 8),
const FooterNote(
text:
"Napomena: Sadržaj je edukativan i namijenjen samorefleksiji. "
"Ako prolaziš kroz teške trenutke, obrati se stručnoj osobi.",
),
const SizedBox(height: 14),
Container(
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
color: darkLilac.withValues(alpha: 0.25),
),
],
),
child: FilledButton.icon(
style: FilledButton.styleFrom(
backgroundColor: Colors.transparent,
shadowColor: Colors.transparent,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(vertical: 16),
),
onPressed: () async {
final ok = await showDialog<bool>(
context: context,
builder: (dialogContext) => AlertDialog(
title: const Text("Krenuti ispočetka?"),
content: const Text(
"Ovo će obrisati sav napredak (otključane razine i najbolje rezultate).",
),
actions: [
TextButton(
onPressed: () =>
Navigator.pop(dialogContext, false),
child: const Text("Odustani"),
),
FilledButton(
onPressed: () =>
Navigator.pop(dialogContext, true),
child: const Text("Kreni ispočetka"),
),
],
),
);

if (ok == true) {
await AppDatabase.instance.resetProgress(widget.userId);

if (!mounted) return;

setState(() {
_loadProgress();
});

if (!context.mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
"Napredak je obrisan. Krenimo ispočetka!",
),
),
);
}
},
icon: const Icon(Icons.restart_alt_rounded),
label: const Text("Kreni ispočetka"),
),
),
],
);
},
),
),
);
}
}

class _PremiumActionCard extends StatelessWidget {
final String title;
final String subtitle;
final IconData icon;
final VoidCallback onTap;

const _PremiumActionCard({
required this.title,
required this.subtitle,
required this.icon,
required this.onTap,
});

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const darkLilac = Color.fromARGB(255, 167, 85, 214);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

return InkWell(
onTap: onTap,
borderRadius: BorderRadius.circular(24),
child: Ink(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(24),
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
blurRadius: 18,
offset: const Offset(0, 10),
color: lightLilac.withValues(alpha: 0.28),
),
],
),
child: Padding(
padding: const EdgeInsets.all(17),
child: Row(
children: [
Container(
width: 56,
height: 56,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(19),
gradient: const LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [
lightLilac,
darkLilac,
],
),
border: Border.all(
color: Colors.white.withValues(alpha: 0.50),
),
),
child: Icon(
icon,
color: deepPurple,
size: 30,
),
),
const SizedBox(width: 13),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
title,
style: Theme.of(context).textTheme.titleMedium?.copyWith(
color: deepPurple,
fontWeight: FontWeight.w900,
fontSize: 21,
),
),
const SizedBox(height: 6),
Text(
subtitle,
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
color: deepPurple,
fontWeight: FontWeight.w700,
),
),
],
),
),
const SizedBox(width: 10),
const Icon(Icons.chevron_right_rounded, color: deepPurple),
],
),
),
),
);
}
}
