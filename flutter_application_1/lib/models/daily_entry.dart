// ═══════════════════════════════════════════════════════════════════════════
// MODÈLE DE DONNÉES - Saisie Quotidienne
// ═══════════════════════════════════════════════════════════════════════════
//
// Classe pour représenter une saisie quotidienne de données diabétiques
// Contient toutes les informations saisies par le patient
// ═══════════════════════════════════════════════════════════════════════════

class DailyEntry {
  final String id;                    // Identifiant unique de la saisie
  final String date;                  // Date (ex: "dimanche 21 janvier 2024")
  final String time;                  // Heure (ex: "07:15")
  final String glycemieMatinale;      // Glycémie matinale en g/L (ex: "1.15")
  final String glycemie2h;            // Glycémie 2h après repas en g/L (ex: "1.65")
  final String novoRapid;             // Dose NovoRapid en unités (ex: "6")
  final String lantus;                // Dose Lantus en unités (ex: "24")
  final String alimentation;          // Description des repas (multilignes)
  final String activites;             // Description des activités (multilignes)
  final String notes;                 // Notes et observations (multilignes)

  DailyEntry({
    required this.id,
    required this.date,
    required this.time,
    required this.glycemieMatinale,
    required this.glycemie2h,
    required this.novoRapid,
    required this.lantus,
    required this.alimentation,
    required this.activites,
    required this.notes,
  });

  // Convertir l'objet en Map pour le stockage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'glycemieMatinale': glycemieMatinale,
      'glycemie2h': glycemie2h,
      'novoRapid': novoRapid,
      'lantus': lantus,
      'alimentation': alimentation,
      'activites': activites,
      'notes': notes,
    };
  }

  // Créer un objet depuis une Map
  factory DailyEntry.fromMap(Map<String, dynamic> map) {
    return DailyEntry(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      glycemieMatinale: map['glycemieMatinale'] ?? '',
      glycemie2h: map['glycemie2h'] ?? '',
      novoRapid: map['novoRapid'] ?? '',
      lantus: map['lantus'] ?? '',
      alimentation: map['alimentation'] ?? '',
      activites: map['activites'] ?? '',
      notes: map['notes'] ?? '',
    );
  }

  // Vérifier si la glycémie est élevée
  bool get isGlycemieMatinaleElevee {
    try {
      final value = double.parse(glycemieMatinale.replaceAll(',', '.'));
      return value > 1.26; // Seuil diabète
    } catch (e) {
      return false;
    }
  }

  bool get isGlycemie2hElevee {
    try {
      final value = double.parse(glycemie2h.replaceAll(',', '.'));
      return value > 1.4; // Seuil diabète 2h après repas
    } catch (e) {
      return false;
    }
  }
}
