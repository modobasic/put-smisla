import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/levels_data.dart';
import '../db/app_database.dart';
import '../models/models.dart';
import 'certificate_dialog.dart';
import 'widgets.dart';

class LevelScreen extends StatefulWidget {
final int userId;
final int lessonId;
final int levelIndex;

const LevelScreen({
super.key,
required this.userId,
required this.lessonId,
required this.levelIndex,
});

@override
State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
int _step = 0;
late final PageController _pageController;

@override
void initState() {
super.initState();
_pageController = PageController();
}

@override
void dispose() {
_pageController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
final level = kLevels[widget.levelIndex];

return Scaffold(
appBar: AppBar(
title: Text(level.title),
),
body: Container(
width: double.infinity,
height: double.infinity,
decoration: const BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [
Color(0xFFD8B4FE),
Color(0xFFF5F3FF),
Colors.white,
],
),
),
child: AnimatedSwitcher(
duration: const Duration(milliseconds: 260),
switchInCurve: Curves.easeOut,
switchOutCurve: Curves.easeIn,
child: _step == 0
? EducationView(
key: const ValueKey("edu"),
level: level,
pageController: _pageController,
onStartQuiz: () {
HapticFeedback.mediumImpact();
setState(() => _step = 1);
},
)
: QuizView(
key: const ValueKey("quiz"),
userId: widget.userId,
lessonId: widget.lessonId,
levelIndex: widget.levelIndex,
onDone: () => Navigator.pop(context),
),
),
),
);
}
}

class EducationView extends StatefulWidget {
final LevelContent level;
final PageController pageController;
final VoidCallback onStartQuiz;

const EducationView({
super.key,
required this.level,
required this.pageController,
required this.onStartQuiz,
});

@override
State<EducationView> createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
int _page = 0;

@override
Widget build(BuildContext context) {
const deepPurple = Color.fromARGB(255, 35, 8, 63);

final total = widget.level.eduCards.length;
final ratio = (_page + 1) / max(1, total);

return Column(
children: [
Padding(
padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
child: Column(
children: [
Row(
children: [
Expanded(
child: Text(
widget.level.subtitle,
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
color: deepPurple,
fontWeight: FontWeight.w800,
),
),
),
const SizedBox(width: 12),
MiniBadge(text: "${_page + 1}/$total"),
],
),
const SizedBox(height: 12),
ClipRRect(
borderRadius: BorderRadius.circular(999),
child: LinearProgressIndicator(
value: ratio,
minHeight: 11,
backgroundColor: const Color(0xFFEDE9FE),
valueColor: const AlwaysStoppedAnimation<Color>(
deepPurple,
),
),
),
],
),
),
Expanded(
child: PageView.builder(
controller: widget.pageController,
itemCount: total,
onPageChanged: (i) => setState(() => _page = i),
itemBuilder: (context, i) {
final card = widget.level.eduCards[i];

return Padding(
padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
child: EduCardView(card: card),
);
},
),
),
Padding(
padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
child: Row(
children: [
Expanded(
child: OutlinedButton.icon(
onPressed: _page == 0
? null
: () {
HapticFeedback.selectionClick();
widget.pageController.previousPage(
duration: const Duration(milliseconds: 260),
curve: Curves.easeOut,
);
},
icon: const Icon(Icons.arrow_back_rounded),
label: const Text("Natrag"),
),
),
const SizedBox(width: 12),
Expanded(
child: FilledButton.icon(
onPressed: () {
HapticFeedback.selectionClick();

if (_page < total - 1) {
widget.pageController.nextPage(
duration: const Duration(milliseconds: 260),
curve: Curves.easeOut,
);
} else {
widget.onStartQuiz();
}
},
icon: Icon(
_page < total - 1
? Icons.arrow_forward_rounded
: Icons.quiz_rounded,
),
label: Text(
_page < total - 1 ? "Dalje" : "Kreni na pitanja",
),
),
),
],
),
),
],
);
}
}

class EduCardView extends StatelessWidget {
final EduCard card;

const EduCardView({
super.key,
required this.card,
});

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const darkLilac = Color.fromARGB(255, 167, 85, 214);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

return Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(28),
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
blurRadius: 22,
offset: const Offset(0, 12),
color: lightLilac.withValues(alpha: 0.30),
),
],
),
child: Padding(
padding: const EdgeInsets.all(18),
child: ListView(
children: [
Row(
children: [
Container(
width: 48,
height: 48,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16),
gradient: const LinearGradient(
colors: [
lightLilac,
darkLilac,
],
),
border: Border.all(
color: Colors.white.withValues(alpha: 0.45),
),
),
child: const Icon(
Icons.menu_book_rounded,
color: deepPurple,
size: 28,
),
),
const SizedBox(width: 13),
Expanded(
child: Text(
card.heading,
style: Theme.of(context).textTheme.titleLarge?.copyWith(
color: deepPurple,
fontSize: 25,
fontWeight: FontWeight.w900,
),
),
),
],
),
const SizedBox(height: 16),
FutureBuilder<String>(
future: rootBundle.loadString(card.assetPath),
builder: (context, snapshot) {
if (!snapshot.hasData) {
return const Padding(
padding: EdgeInsets.all(24),
child: Center(
child: CircularProgressIndicator(color: deepPurple),
),
);
}

return Text(
snapshot.data!,
style: Theme.of(context).textTheme.bodyLarge?.copyWith(
color: deepPurple,
fontSize: 19,
height: 1.55,
fontWeight: FontWeight.w500,
),
);
},
),
if (card.quote != null) ...[
const SizedBox(height: 16),
Container(
padding: const EdgeInsets.all(15),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(18),
gradient: const LinearGradient(
colors: [
Color(0xFFF3E8FF),
almostWhiteLilac,
Colors.white,
],
),
border: Border.all(
color: lightLilac,
),
),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Icon(
Icons.format_quote_rounded,
color: darkLilac,
size: 30,
),
const SizedBox(width: 10),
Expanded(
child: Text(
card.quote!,
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
color: deepPurple,
fontStyle: FontStyle.italic,
fontWeight: FontWeight.w700,
),
),
),
],
),
),
],
],
),
),
);
}
}

class QuizView extends StatefulWidget {
final int userId;
final int lessonId;
final int levelIndex;
final VoidCallback onDone;

const QuizView({
super.key,
required this.userId,
required this.lessonId,
required this.levelIndex,
required this.onDone,
});

@override
State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
int _qIndex = 0;
int? _selected;
bool _locked = false;
int _score = 0;

bool _loading = true;
List<int> _questionNumbers = [];
List<Map<String, Object?>> _answers = [];

@override
void initState() {
super.initState();
_loadQuiz();
}

Future<void> _loadQuiz() async {
final questionNumbers =
await AppDatabase.instance.getQuestionNumbersForLesson(widget.lessonId);

if (!mounted) return;

_questionNumbers = questionNumbers;
await _loadCurrentQuestion();

if (!mounted) return;
setState(() => _loading = false);
}

Future<void> _loadCurrentQuestion() async {
if (_questionNumbers.isEmpty) return;

final questionNumber = _questionNumbers[_qIndex];

final answers = await AppDatabase.instance.getAnswersForQuestion(
lessonId: widget.lessonId,
questionNumber: questionNumber,
);

if (!mounted) return;

setState(() {
_answers = answers;
_selected = null;
_locked = false;
});
}

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const darkLilac = Color.fromARGB(255, 167, 85, 214);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

if (_loading) {
return const Center(
child: CircularProgressIndicator(color: deepPurple),
);
}

if (_questionNumbers.isEmpty || _answers.isEmpty) {
return const Center(
child: Text("Nema dostupnih pitanja za ovu razinu."),
);
}

final total = _questionNumbers.length;
final progressRatio = (_qIndex + 1) / max(1, total);
final questionText = _answers.first['questionText'] as String;

return Padding(
padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
child: Column(
children: [
Row(
children: [
Expanded(
child: Text(
"Pitanja nakon edukacije",
style: Theme.of(context).textTheme.titleLarge?.copyWith(
color: deepPurple,
fontWeight: FontWeight.w900,
),
),
),
MiniBadge(text: "${_qIndex + 1}/$total"),
],
),
const SizedBox(height: 12),
ClipRRect(
borderRadius: BorderRadius.circular(999),
child: LinearProgressIndicator(
value: progressRatio,
minHeight: 11,
backgroundColor: const Color(0xFFEDE9FE),
valueColor: const AlwaysStoppedAnimation<Color>(
deepPurple,
),
),
),
const SizedBox(height: 14),
Expanded(
child: Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(28),
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
blurRadius: 22,
offset: const Offset(0, 12),
color: lightLilac.withValues(alpha: 0.30),
),
],
),
child: Padding(
padding: const EdgeInsets.all(18),
child: ListView(
children: [
Text(
questionText,
style: Theme.of(context).textTheme.titleMedium?.copyWith(
color: deepPurple,
fontSize: 22,
fontWeight: FontWeight.w900,
),
),
const SizedBox(height: 16),
...List.generate(_answers.length, (i) {
final answer = _answers[i];
final option = answer['answerText'] as String;
final isCorrect = answer['isCorrect'] == 1;
final isSelected = _selected == i;

Color border;
Color fill;
Color textColor = deepPurple;

if (_locked) {
if (isCorrect) {
border = Colors.green;
fill = Colors.green.withValues(alpha: 0.12);
textColor = const Color(0xFF166534);
} else if (isSelected && !isCorrect) {
border = Colors.red;
fill = Colors.red.withValues(alpha: 0.12);
textColor = const Color(0xFF991B1B);
} else {
border = lightLilac;
fill = Colors.white.withValues(alpha: 0.78);
}
} else {
border = isSelected ? deepPurple : lightLilac;
fill = isSelected
? const Color(0xFFD8B4FE).withValues(alpha: 0.55)
: Colors.white.withValues(alpha: 0.90);
}


return Padding(
padding: const EdgeInsets.only(bottom: 11),
child: InkWell(
onTap: _locked
? null
: () {
HapticFeedback.selectionClick();
setState(() => _selected = i);
},
borderRadius: BorderRadius.circular(18),
child: Ink(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(18),
border: Border.all(
color: border,
width: isSelected ? 3.0 : 1.5,
),
color: fill,
),
child: Padding(
padding: const EdgeInsets.all(13),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
width: 31,
height: 31,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(11),
color: isSelected
? deepPurple.withValues(alpha: 0.28)
: darkLilac.withValues(alpha: 0.16),
),
child: Center(
child: Text(
String.fromCharCode(65 + i),
style: const TextStyle(
fontWeight: FontWeight.w900,
color: deepPurple,
),
),
),
),
const SizedBox(width: 11),
Expanded(
child: Text(
option,
style: Theme.of(context)
.textTheme
.bodyLarge
?.copyWith(
color: textColor,
fontWeight: FontWeight.w700,
),
),
),
if (_locked && isCorrect)
const Icon(
Icons.check_circle_rounded,
color: Colors.green,
),
if (_locked && isSelected && !isCorrect)
const Icon(
Icons.cancel_rounded,
color: Colors.red,
),
],
),
),
),
),
);
}),
const SizedBox(height: 8),
AnimatedSwitcher(
duration: const Duration(milliseconds: 220),
child: _locked
? Container(
key: const ValueKey("explain"),
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(18),
gradient: const LinearGradient(
colors: [
Color(0xFFF3E8FF),
almostWhiteLilac,
Colors.white,
],
),
border: Border.all(
color: lightLilac,
),
),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Icon(
Icons.lightbulb_rounded,
color: darkLilac,
),
const SizedBox(width: 10),
Expanded(
child: Text(
_correctExplanation(),
style: Theme.of(context)
.textTheme
.bodyMedium
?.copyWith(
color: deepPurple,
fontWeight: FontWeight.w700,
),
),
),
],
),
)
: const SizedBox.shrink(key: ValueKey("empty")),
),
],
),
),
),
),
const SizedBox(height: 13),
Row(
children: [
Expanded(
child: OutlinedButton.icon(
onPressed: _qIndex == 0 && !_locked
? null
: () async {
HapticFeedback.selectionClick();

if (_qIndex > 0) {
setState(() {
_qIndex--;
_selected = null;
_locked = false;
});

await _loadCurrentQuestion();
}
},
icon: const Icon(Icons.arrow_back_rounded),
label: const Text("Natrag"),
),
),
const SizedBox(width: 12),
Expanded(
child: FilledButton.icon(
onPressed: () async {
if (!_locked) {
if (_selected == null) {
HapticFeedback.heavyImpact();
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Odaberi odgovor prije nastavka."),
),
);
return;
}

final correct = _answers[_selected!]['isCorrect'] == 1;

HapticFeedback.mediumImpact();

setState(() {
_locked = true;
if (correct) _score++;
});
} else {
HapticFeedback.selectionClick();

if (_qIndex < total - 1) {
setState(() {
_qIndex++;
_selected = null;
_locked = false;
});

await _loadCurrentQuestion();
} else {
await _finish(context);
}
}
},
icon: Icon(
!_locked
? Icons.check_rounded
: Icons.arrow_forward_rounded,
),
label: Text(
!_locked
? "Provjeri"
: (_qIndex < total - 1 ? "Dalje" : "Završi"),
),
),
),
],
),
],
),
);
}

String _correctExplanation() {
final correct = _answers.firstWhere(
(row) => row['isCorrect'] == 1,
orElse: () => {},
);

final text = correct['answerText'];

if (text == null) {
return "Odgovor je provjeren.";
}

return "Točan odgovor: $text";
}

Future<void> _finish(BuildContext context) async {
final total = _questionNumbers.length;
final passMark = (total * 0.66).ceil();
final passed = _score >= passMark;
final isLastLevel = widget.levelIndex == kLevels.length - 1;

if (passed) {
await AppDatabase.instance.completeLesson(
userId: widget.userId,
lessonId: widget.lessonId,
score: _score,
);
}

if (!mounted) return;

if (passed && isLastLevel) {
CertificateDialog.show(
context,
score: _score,
total: total,
onHome: widget.onDone,
);
return;
}

final cs = Theme.of(context).colorScheme;

showModalBottomSheet(
context: context,
isScrollControlled: true,
showDragHandle: true,
builder: (ctx) {
return Padding(
padding: EdgeInsets.fromLTRB(
16,
10,
16,
16 + MediaQuery.of(ctx).viewInsets.bottom,
),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Container(
width: 60,
height: 60,
decoration: BoxDecoration(
color: (passed ? Colors.green : cs.primary)
.withValues(alpha: 0.14),
borderRadius: BorderRadius.circular(20),
border: Border.all(
color: (passed ? Colors.green : cs.primary)
.withValues(alpha: 0.22),
),
),
child: Icon(
passed
? Icons.emoji_events_rounded
: Icons.auto_awesome_rounded,
color: passed ? Colors.green : cs.primary,
size: 32,
),
),
const SizedBox(height: 13),
Text(
passed
? "Bravo! Level je uspješno dovršen 🎉"
: "Dobar pokušaj — probaj još jednom ✨",
style: Theme.of(ctx).textTheme.titleLarge,
textAlign: TextAlign.center,
),
const SizedBox(height: 10),
Text(
passed
? "Rezultat: $_score/$total\nOtključan je sljedeći level."
: "Rezultat: $_score/$total\nZa prolaz ciljaj barem $passMark točna odgovora.",
textAlign: TextAlign.center,
style: Theme.of(ctx).textTheme.bodyMedium,
),
const SizedBox(height: 15),
Row(
children: [
Expanded(
child: OutlinedButton.icon(
onPressed: () async {
Navigator.pop(ctx);

setState(() {
_qIndex = 0;
_selected = null;
_locked = false;
_score = 0;
});

await _loadCurrentQuestion();
},
icon: const Icon(Icons.refresh_rounded),
label: const Text("Ponovi kviz"),
),
),
const SizedBox(width: 12),
Expanded(
child: FilledButton.icon(
onPressed: () {
Navigator.pop(ctx);
widget.onDone();
},
icon: const Icon(Icons.home_rounded),
label: const Text("Početna"),
),
),
],
),
],
),
);
},
);
}
}
