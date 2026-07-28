import 'dart:math';
import 'package:flutter/material.dart';

class HeroHeader extends StatelessWidget {
final String title;
final String subtitle;
final Color accent;

const HeroHeader({
super.key,
required this.title,
required this.subtitle,
required this.accent,
});

@override
Widget build(BuildContext context) {
const lightLilac = Color.fromARGB(255, 163, 114, 216);
const deepPurple = Color.fromARGB(255, 61, 20, 104);

return Container(
padding: const EdgeInsets.all(18),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(10),
gradient: const LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [
lightLilac,
deepPurple,
],
),
border: Border.all(
color: Colors.white.withValues(alpha: 0.38),
width: 1.2,
),
boxShadow: [
BoxShadow(
blurRadius: 22,
offset: const Offset(0, 14),
color: const Color.fromARGB(255, 60, 27, 78).withValues(alpha: 0.25),
),
],
),
child: Row(
children: [
Container(
width: 76,
height: 76,
padding: const EdgeInsets.all(5),
decoration: BoxDecoration(
color: Colors.white.withValues(alpha: 0.20),
borderRadius: BorderRadius.circular(22),
border: Border.all(
color: Colors.white.withValues(alpha: 0.40),
),
),
child: ClipRRect(
borderRadius: BorderRadius.circular(17),
child: Image.asset(
'assets/icons/logo.png',
fit: BoxFit.cover,
),
),
),
const SizedBox(width: 14),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
title,
style: Theme.of(context).textTheme.titleLarge?.copyWith(
color: Colors.white,
fontWeight: FontWeight.w900,
fontSize: 28,
),
),
const SizedBox(height: 7),
Text(
subtitle,
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
color: Colors.white.withValues(alpha: 0.94),
fontSize: 16.5,
fontWeight: FontWeight.w600,
),
),
],
),
),
],
),
);
}
}

class ProgressCard extends StatelessWidget {
final int completed;
final int total;

const ProgressCard({
super.key,
required this.completed,
required this.total,
});

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

final ratio = completed / max(1, total);
final percent = (ratio * 100).round();

return Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(26),
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
width: 1.3,
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
padding: const EdgeInsets.all(18),
child: Row(
children: [
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
"Napredak",
style: Theme.of(context).textTheme.titleMedium?.copyWith(
color: deepPurple,
fontSize: 23,
fontWeight: FontWeight.w900,
),
),
const SizedBox(height: 7),
Text(
"$completed od $total razine završeno",
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
color: deepPurple,
fontWeight: FontWeight.w800,
),
),
const SizedBox(height: 12),
ClipRRect(
borderRadius: BorderRadius.circular(999),
child: LinearProgressIndicator(
value: ratio,
minHeight: 12,
backgroundColor: const Color(0xFFEDE9FE),
valueColor: const AlwaysStoppedAnimation<Color>(
deepPurple,
),
),
),
],
),
),
const SizedBox(width: 14),
MiniBadge(text: "$percent%"),
],
),
),
);
}
}

class MiniBadge extends StatelessWidget {
final String text;

const MiniBadge({
super.key,
required this.text,
});

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

return Container(
padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
decoration: BoxDecoration(
gradient: const LinearGradient(
colors: [
almostWhiteLilac,
Colors.white,
],
),
borderRadius: BorderRadius.circular(20),
border: Border.all(
color: lightLilac,
width: 1.3,
),
),
child: Text(
text,
style: const TextStyle(
fontWeight: FontWeight.w900,
color: deepPurple,
fontSize: 16,
),
),
);
}
}

class LevelTile extends StatelessWidget {
final int index;
final String title;
final String subtitle;
final bool locked;
final String bestScoreText;
final VoidCallback? onTap;

const LevelTile({
super.key,
required this.index,
required this.title,
required this.subtitle,
required this.locked,
required this.bestScoreText,
this.onTap,
});

@override
Widget build(BuildContext context) {
const deepPurple = Color.fromARGB(255, 35, 8, 63);
const darkLilac = Color.fromARGB(255, 167, 85, 214);
const lightLilac = Color(0xFFD8B4FE);
const softLilac = Color(0xFFF5F3FF);

final icon = locked ? Icons.lock_rounded : Icons.play_circle_fill_rounded;

final backgroundColor = locked ? softLilac : const Color.fromARGB(255, 61, 20, 104);
final borderColor = locked ? darkLilac : deepPurple;
final textColor = locked ? deepPurple : Colors.white;

return Container(
margin: const EdgeInsets.only(bottom: 14),
decoration: BoxDecoration(
color: backgroundColor,
borderRadius: BorderRadius.circular(28),
border: Border.all(
color: borderColor,
width: 2.5,
),
boxShadow: [
BoxShadow(
color: const Color.fromARGB(255, 48, 12, 87).withValues(alpha: locked ? 0.10 : 0.28),
blurRadius: 18,
offset: const Offset(0, 10),
),
],
),
child: Material(
color: Colors.transparent,
borderRadius: BorderRadius.circular(28),
child: InkWell(
onTap: onTap,
borderRadius: BorderRadius.circular(28),
child: Padding(
padding: const EdgeInsets.all(18),
child: Row(
children: [
Container(
width: 58,
height: 58,
decoration: BoxDecoration(
color: locked ? Colors.white : Colors.white.withValues(alpha: 0.18),
borderRadius: BorderRadius.circular(18),
border: Border.all(
color: locked ? lightLilac : Colors.white,
width: 1.8,
),
),
child: Icon(
icon,
color: locked ? const Color.fromARGB(255, 90, 28, 153) : Colors.white,
size: 32,
),
),

const SizedBox(width: 15),

Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
title,
style: TextStyle(
color: textColor,
fontSize: 22,
fontWeight: FontWeight.w900,
height: 1.15,
),
),
const SizedBox(height: 8),
Text(
subtitle,
style: TextStyle(
color: textColor.withValues(alpha: locked ? 0.95 : 0.90),
fontSize: 16.5,
fontWeight: FontWeight.w700,
height: 1.35,
),
),
const SizedBox(height: 13),
Wrap(
spacing: 8,
runSpacing: 8,
children: [
_LevelBadge(
icon: Icons.layers_rounded,
text: "Razina ${index + 1}",
locked: locked,
),
_LevelBadge(
icon: Icons.emoji_events_rounded,
text: bestScoreText,
locked: locked,
),
],
),
],
),
),

const SizedBox(width: 8),

Icon(
Icons.chevron_right_rounded,
color: textColor,
size: 34,
),
],
),
),
),
),
);
}
}


class _LevelBadge extends StatelessWidget {
final IconData icon;
final String text;
final bool locked;

const _LevelBadge({
required this.icon,
required this.text,
required this.locked,
});

@override
Widget build(BuildContext context) {
const deepPurple = Color.fromARGB(255, 76, 22, 133);
const lightLilac = Color(0xFFD8B4FE);

return Container(
padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
decoration: BoxDecoration(
color: locked ? Colors.white : Colors.white.withValues(alpha: 0.18),
borderRadius: BorderRadius.circular(999),
border: Border.all(
color: locked ? lightLilac : Colors.white.withValues(alpha: 0.65),
width: 1.4,
),
),
child: Row(
mainAxisSize: MainAxisSize.min,
children: [
Icon(
icon,
size: 18,
color: locked ? const Color.fromARGB(255, 87, 39, 138) : Colors.white,
),
const SizedBox(width: 7),
Text(
text,
style: TextStyle(
color: locked ? deepPurple : Colors.white,
fontWeight: FontWeight.w900,
fontSize: 14.5,
),
),
],
),
);
}
}




class FooterNote extends StatelessWidget {
final String text;

const FooterNote({
super.key,
required this.text,
});

@override
Widget build(BuildContext context) {
const lightLilac = Color(0xFFD8B4FE);
const almostWhiteLilac = Color(0xFFF5F3FF);
const deepPurple = Color.fromARGB(255, 35, 8, 63);

return Container(
padding: const EdgeInsets.all(15),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(22),
gradient: const LinearGradient(
colors: [
Color(0xFFF3E8FF),
almostWhiteLilac,
Colors.white,
],
),
border: Border.all(
color: lightLilac,
width: 1.2,
),
),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Icon(Icons.info_outline_rounded, color: deepPurple),
const SizedBox(width: 10),
Expanded(
child: Text(
text,
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
color: deepPurple,
fontWeight: FontWeight.w700,
),
),
),
],
),
);
}
}
