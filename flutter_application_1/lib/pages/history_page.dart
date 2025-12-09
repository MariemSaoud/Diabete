import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_app_bar.dart';
import 'package:flutter_application_1/components/my_bottom_nav_bar.dart';
import 'package:flutter_application_1/components/page_transitions.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_application_1/pages/chart_page.dart';
import 'package:flutter_application_1/pages/news_page.dart';
import 'package:flutter_application_1/models/daily_entry.dart';
import 'package:flutter_application_1/services/daily_entry_service.dart';

/// ======================================
/// PAGE HISTORIQUE
/// ======================================
/// Cette page affiche l'historique des saisies quotidiennes
/// Liste des entrées avec date, glycémie, insuline, repas, activités et notes
/// Les glycémies élevées sont marquées avec un badge "Élevée"

// Widget StatefulWidget pour gérer l'état de la navigation
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Index de l'onglet actif dans la barre de navigation
  // 0 = Actualités, 1 = Saisie Quotidienne, 2 = Historique, 3 = Graphiques, 4 = Profil Patient
  final int _currentIndex = 2;
  
  // Liste des saisies quotidiennes
  List<DailyEntry> _allEntries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  // Charger les saisies depuis le stockage
  Future<void> _loadEntries() async {
    final entries = await DailyEntryService.getAllEntries();
    setState(() {
      _allEntries = entries;
      _isLoading = false;
    });
  }

  // Callback pour rafraîchir la liste après édition/suppression
  void _refreshHistoryList() {
    _loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Couleur de fond de la page (gris très clair)
      backgroundColor: const Color(0xFFF5F7FB),
      // Barre d'application en haut avec le titre
      appBar: const MyAppBar(title: 'Historique'),
      // Corps de la page
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Champ de saisie de la date supprimé
                // Liste des entrées
                Expanded(
                  child: _allEntries.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_note,
                                size: 120,
                                color: const Color(0xFFCBD5E1),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Aucune saisie enregistrée',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: const Color(0xFF6B7280),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadEntries,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _allEntries.length,
                            itemBuilder: (context, index) {
                              return _buildEntryCard(_allEntries[index]);
                            },
                          ),
                        ),
                ),
              ],
            ),
      // Barre de navigation en bas
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Ne rien faire si on clique sur l'onglet déjà actif
          if (index == _currentIndex) return;
          // Naviguer vers la page correspondante avec animation
          Navigator.pushReplacement(
            context,
            SlideAndFadePageTransition(page: _getPageForIndex(index)),
          );
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CONSTRUCTION D'UNE CARTE DE SAISIE COMPACTE AVEC EXPANSION
  // ─────────────────────────────────────────────────────────────────────────
  Widget _buildEntryCard(DailyEntry entry) {
    return _CompactEntryCard(entry: entry, onRefresh: _refreshHistoryList);
  }

  /// Retourner la page correspondant à l'index sélectionné
  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0:
        return const NewsPage();      // Actualités
      case 1:
        return const HomePage();      // Saisie Quotidienne
      case 2:
        return const HistoryPage();   // Historique (page actuelle)
      case 3:
        return const ChartPage();     // Graphiques
      case 4:
        return const ProfilePage();   // Profil Patient
      default:
        return const HistoryPage();   // Par défaut, rester sur Historique
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CARTE COMPACTE D'ENTRÉE AVEC EXPANSION
// ═══════════════════════════════════════════════════════════════════════════
class _CompactEntryCard extends StatefulWidget {
  final DailyEntry entry;
  final VoidCallback onRefresh;

  const _CompactEntryCard({required this.entry, required this.onRefresh});

  @override
  State<_CompactEntryCard> createState() => _CompactEntryCardState();
}

class _CompactEntryCardState extends State<_CompactEntryCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    try {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );
      _heightAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic),
      );
    } catch (e) {
      debugPrint('Animation initialization error: $e');
    }
  }

  @override
  void dispose() {
    try {
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
      _animationController.dispose();
    } catch (e) {
      debugPrint('Animation dispose error: $e');
    }
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (!mounted || !_animationController.isAnimating) {
      try {
        if (_isExpanded) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      } catch (e) {
        debugPrint('Animation toggle error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleExpanded,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête compact : Date, Heure, Glycémies
                    Row(
                      children: [
                        // Date et heure
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 14, color: const Color(0xFF2564EB)),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      widget.entry.date,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1F2937),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 12, color: const Color(0xFF6B7280)),
                                  const SizedBox(width: 6),
                                  Text(
                                    widget.entry.time,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF6B7280),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Glycémies en badges compacts
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildCompactBadge(
                              '${widget.entry.glycemieMatinale} g/L',
                              widget.entry.isGlycemieMatinaleElevee ? const Color(0xFFFEF3C7) : const Color(0xFFD1FAE5),
                              widget.entry.isGlycemieMatinaleElevee ? const Color(0xFF92400E) : const Color(0xFF065F46),
                            ),
                            const SizedBox(height: 4),
                            _buildCompactBadge(
                              '${widget.entry.glycemie2h} g/L',
                              widget.entry.isGlycemie2hElevee ? const Color(0xFFFEF3C7) : const Color(0xFFD1FAE5),
                              widget.entry.isGlycemie2hElevee ? const Color(0xFF92400E) : const Color(0xFF065F46),
                            ),
                          ],
                        ),
                        
                        // Icône d'expansion animée
                        const SizedBox(width: 12),
                        Transform.rotate(
                          angle: _heightAnimation.value * 3.14159, // π radians = 180 degrés
                          child: Icon(
                            Icons.expand_more,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                    
                    // Détails expandables avec animation
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: _heightAnimation.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Divider(
                              height: 1,
                              color: const Color(0xFFE2E8F0).withValues(alpha: _heightAnimation.value),
                            ),
                            const SizedBox(height: 16),
                            
                            // Tous les détails affichés en ordre
                            Opacity(
                              opacity: _heightAnimation.value,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Section Glycémie Matinale
                                  _buildDetailRow(
                                    icon: Icons.bloodtype,
                                    iconColor: const Color(0xFFDC2626),
                                    title: 'Glycémie matinale',
                                    value: '${widget.entry.glycemieMatinale} mg/dL',
                                  ),
                                  const SizedBox(height: 12),
                                  
                                  // Section Glycémie 2h après repas
                                  _buildDetailRow(
                                    icon: Icons.bloodtype,
                                    iconColor: const Color(0xFFFF9800),
                                    title: 'Glycémie 2h après repas',
                                    value: '${widget.entry.glycemie2h} mg/dL',
                                  ),
                                  const SizedBox(height: 12),
                                  
                                  // Section Insuline
                                  _buildExpandedSection(
                                    icon: Icons.water_drop,
                                    iconColor: const Color(0xFF16A34A),
                                    title: 'Insuline',
                                    content: 'NovoRapid: ${widget.entry.novoRapid} unités\nLantus: ${widget.entry.lantus} unités',
                                  ),
                                  const SizedBox(height: 12),
                                  
                                  // Section Repas (si remplie)
                                  if (widget.entry.alimentation.isNotEmpty) ...[
                                    _buildExpandedSection(
                                      icon: Icons.restaurant,
                                      iconColor: const Color(0xFFEA580C),
                                      title: 'Repas',
                                      content: widget.entry.alimentation,
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  
                                  // Section Activités (si remplie)
                                  if (widget.entry.activites.isNotEmpty) ...[
                                    _buildExpandedSection(
                                      icon: Icons.directions_run,
                                      iconColor: const Color(0xFF7C3AED),
                                      title: 'Activités',
                                      content: widget.entry.activites,
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  
                                  // Section Notes (si remplie)
                                  if (widget.entry.notes.isNotEmpty) ...[
                                    _buildExpandedSection(
                                      icon: Icons.note,
                                      iconColor: const Color(0xFF6B7280),
                                      title: 'Notes',
                                      content: widget.entry.notes,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ],
                              ),
                            ),
                            
                            // Boutons d'action (Éditer et Supprimer)
                            Opacity(
                              opacity: _heightAnimation.value,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _editEntry(context),
                                      icon: const Icon(Icons.edit, size: 16),
                                      label: const Text('Éditer'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2564EB),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _deleteEntry(context),
                                      icon: const Icon(Icons.delete, size: 16),
                                      label: const Text('Supprimer'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFDC2626),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCompactBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1F2937),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF4B5563),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  void _editEntry(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => EditEntryDialog(
        entry: widget.entry,
        onSave: () {
          widget.onRefresh();
        },
      ),
    );
  }

  void _deleteEntry(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer cette entrée ?'),
        content: const Text('Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              await DailyEntryService.deleteEntry(widget.entry.id);
              if (context.mounted) {
                Navigator.pop(context);
              }
              widget.onRefresh();
            },
            child: const Text('Supprimer', style: TextStyle(color: Color(0xFFDC2626))),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DIALOG D'ÉDITION D'UNE ENTRÉE
// ═══════════════════════════════════════════════════════════════════════════
class EditEntryDialog extends StatefulWidget {
  final DailyEntry entry;
  final VoidCallback onSave;

  const EditEntryDialog({
    required this.entry,
    required this.onSave,
    super.key,
  });

  @override
  State<EditEntryDialog> createState() => _EditEntryDialogState();
}

class _EditEntryDialogState extends State<EditEntryDialog> {
  late TextEditingController glycemieMatinaleController;
  late TextEditingController glycemie2hController;
  late TextEditingController novoRapidController;
  late TextEditingController lantusController;
  late TextEditingController alimentationController;
  late TextEditingController activitesController;
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    glycemieMatinaleController = TextEditingController(text: widget.entry.glycemieMatinale);
    glycemie2hController = TextEditingController(text: widget.entry.glycemie2h);
    novoRapidController = TextEditingController(text: widget.entry.novoRapid);
    lantusController = TextEditingController(text: widget.entry.lantus);
    alimentationController = TextEditingController(text: widget.entry.alimentation);
    activitesController = TextEditingController(text: widget.entry.activites);
    notesController = TextEditingController(text: widget.entry.notes);
  }

  @override
  void dispose() {
    glycemieMatinaleController.dispose();
    glycemie2hController.dispose();
    novoRapidController.dispose();
    lantusController.dispose();
    alimentationController.dispose();
    activitesController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Éditer l\'entrée',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Glycémie matinale (mg/dL)', glycemieMatinaleController),
              const SizedBox(height: 12),
              _buildTextField('Glycémie 2h après repas (mg/dL)', glycemie2hController),
              const SizedBox(height: 12),
              _buildTextField('NovoRapid (unités)', novoRapidController),
              const SizedBox(height: 12),
              _buildTextField('Lantus (unités)', lantusController),
              const SizedBox(height: 12),
              _buildTextField('Alimentation', alimentationController, maxLines: 2),
              const SizedBox(height: 12),
              _buildTextField('Activités', activitesController, maxLines: 2),
              const SizedBox(height: 12),
              _buildTextField('Notes', notesController, maxLines: 2),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Annuler'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2564EB),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Enregistrer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }

  Future<void> _saveChanges() async {
    // Créer une nouvelle entrée avec les données modifiées
    final updatedEntry = DailyEntry(
      id: widget.entry.id,
      date: widget.entry.date,
      time: widget.entry.time,
      glycemieMatinale: glycemieMatinaleController.text,
      glycemie2h: glycemie2hController.text,
      novoRapid: novoRapidController.text,
      lantus: lantusController.text,
      alimentation: alimentationController.text,
      activites: activitesController.text,
      notes: notesController.text,
    );

    // Supprimer l'ancienne entrée et enregistrer la nouvelle
    await DailyEntryService.deleteEntry(widget.entry.id);
    await DailyEntryService.saveEntry(updatedEntry);

    if (mounted) {
      Navigator.pop(context);
      widget.onSave();
    }
  }
}
