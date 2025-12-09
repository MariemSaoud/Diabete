import 'package:flutter_application_1/models/daily_entry.dart';

// ═══════════════════════════════════════════════════════════════════════════
// SERVICE DE STOCKAGE - Saisies Quotidiennes
// ═══════════════════════════════════════════════════════════════════════════
//
// Service pour gérer le stockage des saisies quotidiennes
// Utilise une liste statique en mémoire (simple et compatible toutes plateformes)
// Note: Les données sont perdues lors du rechargement de l'application
// ═══════════════════════════════════════════════════════════════════════════

class DailyEntryService {
  // Liste statique pour stocker les saisies en mémoire
  static final List<DailyEntry> _entries = [];

  // ───────────────────────────────────────────────────────────────────────────
  // SAUVEGARDER une nouvelle saisie
  // ───────────────────────────────────────────────────────────────────────────
  static Future<void> saveEntry(DailyEntry entry) async {
    // Ajouter la nouvelle saisie au début de la liste
    _entries.insert(0, entry);
  }

  // ───────────────────────────────────────────────────────────────────────────
  // RÉCUPÉRER toutes les saisies
  // ───────────────────────────────────────────────────────────────────────────
  static Future<List<DailyEntry>> getAllEntries() async {
    // Retourner une copie de la liste pour éviter les modifications externes
    return List.from(_entries);
  }

  // ───────────────────────────────────────────────────────────────────────────
  // SUPPRIMER une saisie par ID
  // ───────────────────────────────────────────────────────────────────────────
  static Future<void> deleteEntry(String id) async {
    _entries.removeWhere((entry) => entry.id == id);
  }

  // ───────────────────────────────────────────────────────────────────────────
  // EFFACER toutes les saisies
  // ───────────────────────────────────────────────────────────────────────────
  static Future<void> clearAllEntries() async {
    _entries.clear();
  }
}
