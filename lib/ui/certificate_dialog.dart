import 'package:flutter/material.dart';

class CertificateDialog {
  static void show(BuildContext context, {required int score, required int total, required VoidCallback onHome}) {
    final cs = Theme.of(context).colorScheme;
    final date = DateTime.now();
    final dateText =
        "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}.";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cs.primary.withOpacity(0.18),
                  cs.secondary.withOpacity(0.10),
                  cs.surface,
                ],
              ),
              border: Border.all(color: cs.primary.withOpacity(0.20)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: cs.primary.withOpacity(0.22)),
                    ),
                    child: Icon(Icons.verified_rounded, size: 40, color: cs.primary),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "POTVRDA",
                    style: Theme.of(ctx).textTheme.titleLarge?.copyWith(letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "o uspješno prijeđenom putu",
                    style: Theme.of(ctx).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: cs.primary.withOpacity(0.14)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "PUT SMISLA — 3 RAZINE LOGOTERAPIJE",
                          style: Theme.of(ctx).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text("Rezultat: $score/$total", style: Theme.of(ctx).textTheme.bodyMedium),
                        const SizedBox(height: 6),
                        Text("Datum: $dateText", style: Theme.of(ctx).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Čestitamo! Završio/la si sve razine. 🎉\nOva potvrda je znak tvog uloženog truda, ustrajnosti i rasta kroz sve korake.",
                    textAlign: TextAlign.center,
                    style: Theme.of(ctx).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            onHome();
                          },
                          icon: const Icon(Icons.home_rounded),
                          label: const Text("Natrag na početnu"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
