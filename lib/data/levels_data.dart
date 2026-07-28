import '../models/models.dart';

final List<LevelContent> kLevels = [
  LevelContent(
    title: "Level 1 • Što je smisao?",
    subtitle: "Uvod u logoterapiju: čovjek i potraga za smislom.",
    eduCards: const [
      EduCard(
        heading: "Svrha logoterapije",
        assetPath: "assets/lessons/lesson1_card1.txt",
        quote: "„Onaj tko ima zašto, može izdržati gotovo svako kako.”",
      ),
      EduCard(
        heading: "Smisao nije općenit — nego konkretan",
        assetPath: "assets/lessons/lesson1_card2.txt",
      ),
      EduCard(
        heading: "Tri puta do smisla (vrijednosti)",
        assetPath: "assets/lessons/lesson1_card3.txt",
      ),
    ],
  ),

  LevelContent(
    title: "Level 2 • Sloboda i odgovornost",
    subtitle: "Između podražaja i reakcije — postoji prostor izbora.",
    eduCards: const [
      EduCard(
        heading: "Prostor izbora",
        assetPath: "assets/lessons/lesson2_card1.txt",
        quote: "„Između podražaja i reakcije postoji prostor.”",
      ),
      EduCard(
        heading: "Odgovornost kao ključ",
        assetPath: "assets/lessons/lesson2_card2.txt",
      ),
      EduCard(
        heading: "Smisao ≠ osjećaj",
        assetPath: "assets/lessons/lesson2_card3.txt",
      ),
    ],
  ),

  LevelContent(
    title: "Level 3 • Stav prema patnji",
    subtitle: "Kad se okolnosti ne mogu promijeniti — ostaje stav.",
    eduCards: const [
      EduCard(
        heading: "Patnja nije cilj — ali je prilika za stav",
        assetPath: "assets/lessons/lesson3_card1.txt",
      ),
      EduCard(
        heading: "Vrijednosti stava (najdublje)",
        assetPath: "assets/lessons/lesson3_card2.txt",
        quote:
            "„Kad više ne možemo promijeniti situaciju, pozvani smo promijeniti sebe.”",
      ),
      EduCard(
        heading: "Mala djela — veliki smisao",
        assetPath: "assets/lessons/lesson3_card3.txt",
      ),
    ],
  ),
];