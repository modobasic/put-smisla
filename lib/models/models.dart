class LevelContent {
  final String title;
  final String subtitle;
  final List<EduCard> eduCards;

  const LevelContent({
    required this.title,
    required this.subtitle,
    required this.eduCards,
  });
}

class EduCard {
  final String heading;
  final String assetPath;
  final String? quote;

  const EduCard({
    required this.heading,
    required this.assetPath,
    this.quote,
  });
}

class DbQuestion {
  final int questionNumber;
  final String questionText;

  const DbQuestion({
    required this.questionNumber,
    required this.questionText,
  });
}

class DbAnswer {
  final String text;
  final bool isCorrect;

  const DbAnswer({
    required this.text,
    required this.isCorrect,
  });
}