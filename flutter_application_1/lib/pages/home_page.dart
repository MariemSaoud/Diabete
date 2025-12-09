import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_app_bar.dart';
import 'package:flutter_application_1/components/my_bottom_nav_bar.dart';
import 'package:flutter_application_1/components/page_transitions.dart';
import 'package:flutter_application_1/pages/profile_page.dart';
import 'package:flutter_application_1/pages/chart_page.dart';
import 'package:flutter_application_1/pages/history_page.dart';
import 'package:flutter_application_1/pages/news_page.dart';
import 'package:flutter_application_1/models/daily_entry.dart';
import 'package:flutter_application_1/services/daily_entry_service.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/// ======================================
/// PAGE D'ACCUEIL - SAISIE QUOTIDIENNE
/// ======================================
/// Cette page est la page principale de l'application
/// Elle permet au patient diabétique de saisir ses données quotidiennes :
/// - Date et heure d'injection
/// - Niveaux de glycémie (matinale et 2h après repas)
/// - Doses d'insuline (NovoRapid et Lantus)
/// - Alimentation (description des repas)
/// - Activités physiques
/// - Notes et observations
///
/// Le formulaire est organisé en sections avec des cartes "glass" pour une meilleure lisibilité

// Widget StatefulWidget pour gérer l'état de la navigation
class HomePage extends StatelessWidget {
    Widget _getPageForIndex(int index) {
      switch (index) {
        case 0:
          return const NewsPage();
        case 1:
          return const HomePage();
        case 2:
          return const HistoryPage();
        case 3:
          return const ChartPage();
        case 4:
          return const ProfilePage();
        default:
          return const HomePage();
      }
    }
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Affiche directement le formulaire de saisie quotidienne
    return const HomePageForm();
  }
}

// Carte d'accès rapide ergonomique
class _HomeQuickCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final VoidCallback onTap;
  const _HomeQuickCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(14),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:  Color.fromARGB(255, 58, 75, 150),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFFCBD5E1), size: 20),
          ],
        ),
      ),
    );
  }
}

// Page de saisie quotidienne (ancienne HomePage)
class HomePageForm extends StatefulWidget {

  const HomePageForm({super.key});
  @override
  State<HomePageForm> createState() => _HomePageFormState();
}

class _HomePageFormState extends State<HomePageForm> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController glycemieMatinaleController = TextEditingController();
  final TextEditingController glycemie2hController = TextEditingController();
  final TextEditingController novoRapidController = TextEditingController();
  final TextEditingController lantusController = TextEditingController();
  final TextEditingController alimentationController = TextEditingController();
  final TextEditingController activitesController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override

  void initState() {
    super.initState();
    // Initialiser la date avec le jour actuel au format dd/mm/yyyy
    final now = DateTime.now();
    dateController.text = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    // Initialiser l'heure déplacé dans didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final nowTime = TimeOfDay.now();
    timeController.text = nowTime.format(context);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
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
    return Scaffold(
      appBar: MyAppBar(title: 'Saisie Quotidienne'),
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: 'Date et Heure',
                icon: Icons.calendar_today,
                children: [
                  _buildDateField('Date', dateController),
                  const SizedBox(height: 12),
                  _buildTimeField('Heure', timeController),
                ],
              ),
              const SizedBox(height: 18),
              _buildSection(
                title: 'Glycémie',
                icon: Icons.bloodtype,
                iconColor: const Color(0xFFDC2626),
                children: [
                  _buildNumberField('Glycémie matinale (mg/dL)', glycemieMatinaleController),
                  const SizedBox(height: 12),
                  _buildNumberField('Glycémie 2h après repas (mg/dL)', glycemie2hController),
                ],
              ),
              const SizedBox(height: 18),
              _buildSection(
                title: 'Insuline',
                icon: Icons.medical_services,
                iconColor: const Color(0xFF2564EB),
                children: [
                  _buildNumberField('NovoRapid (unités)', novoRapidController),
                  const SizedBox(height: 12),
                  _buildNumberField('Lantus (unités)', lantusController),
                ],
              ),
              const SizedBox(height: 18),
              _buildSection(
                title: 'Alimentation',
                icon: Icons.restaurant,
                iconColor: const Color(0xFF16A34A),
                children: [
                  _buildTextAreaField('Description des repas', alimentationController, maxLines: 2),
                ],
              ),
              const SizedBox(height: 18),
              _buildSection(
                title: 'Activités physiques',
                icon: Icons.directions_run,
                iconColor: const Color(0xFF7C3AED),
                children: [
                  _buildTextAreaField('Activités réalisées', activitesController, maxLines: 2),
                ],
              ),
              const SizedBox(height: 18),
              _buildSection(
                title: 'Notes',
                icon: Icons.note_alt,
                iconColor: const Color(0xFF64748B),
                children: [
                  _buildTextAreaField('Observations', notesController, maxLines: 2),
                ],
              ),
              const SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) return;
          Navigator.pushReplacement(
            context,
            SlideAndFadePageTransition(page: _getPageForIndex(index)),
          );
        },
      ),
    );
  }

  /// Construire une section du formulaire (carte avec titre, icône et champs)
  Widget _buildSection({
    required String title,
    required IconData icon,
    Color? iconColor,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor ?? const Color(0xFF2564EB), size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF3A4B96),
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Color(0xFF1F2937),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              controller.text = '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
            }
          },
          child: TextField(
            controller: controller,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_today, color: const Color(0xFF2564EB), size: 20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
            ),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF1F2937)),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF3A4B96),
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: Color(0xFF1F2937),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedTime != null && mounted) {
              controller.text = pickedTime.format(context);
            }
          },
          child: TextField(
            controller: controller,
            readOnly: true,
            enabled: false,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.access_time, color: const Color(0xFF2564EB), size: 20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              filled: true,
              fillColor: const Color(0xFFFAFAFA),
              hintText: '--:-- --',
              hintStyle: const TextStyle(color: Color(0xFFD1D5DB)),
            ),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF1F2937)),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            filled: true,
            fillColor: const Color(0xFFFAFAFA),
            suffixIcon: const Icon(Icons.unfold_more, color: Color(0xFF6B7280), size: 20),
          ),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildTextAreaField(String label, TextEditingController controller, {required int maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          minLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(12),
            filled: true,
            fillColor: const Color(0xFFFAFAFA),
          ),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF6B7280)),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: const  Color.fromARGB(255, 58, 75, 150),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              // Validation : au moins la glycémie matinale doit être remplie
              if (glycemieMatinaleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Veuillez entrer au moins la glycémie matinale'),
                    backgroundColor: Color(0xFFDC2626),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              final currentTime = timeController.text.isNotEmpty ? timeController.text : TimeOfDay.now().format(context);
              await initializeDateFormatting('fr_FR', null);
              
              // Convertir la date du format dd/mm/yyyy vers un DateTime
              DateTime? selectedDate;
              if (dateController.text.isNotEmpty) {
                try {
                  final parts = dateController.text.split('/');
                  if (parts.length == 3) {
                    selectedDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
                  }
                } catch (e) {
                  selectedDate = null;
                }
              }
              if (selectedDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Date invalide. Veuillez saisir une date au format jj/mm/aaaa.'),
                    backgroundColor: Color(0xFFDC2626),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }
              
              final entry = DailyEntry(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                date: DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(selectedDate),
                time: currentTime,
                glycemieMatinale: glycemieMatinaleController.text,
                glycemie2h: glycemie2hController.text,
                novoRapid: novoRapidController.text,
                lantus: lantusController.text,
                alimentation: alimentationController.text,
                activites: activitesController.text,
                notes: notesController.text,
              );
              await DailyEntryService.saveEntry(entry);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Données enregistrées avec succès'),
                    backgroundColor: Color(0xFF1B8A43),
                    duration: Duration(seconds: 2),
                  ),
                );
                // Réinitialiser le formulaire
                _resetForm();
                // Aller à la page Historique pour voir la nouvelle saisie
                Navigator.pushReplacement(
                  context,
                  SlideAndFadePageTransition(page: const HistoryPage()),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Center(
                child: Text(
                  'Enregistrer les Données',
                  style: TextStyle(
                    color:  Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _resetForm() {
    // Réinitialiser la date avec le jour actuel
    final now = DateTime.now();
    dateController.text = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    // Réinitialiser l'heure avec l'heure actuelle
    final nowTime = TimeOfDay.now();
    timeController.text = nowTime.format(context);
    // Vider les champs de saisie
    glycemieMatinaleController.clear();
    glycemie2hController.clear();
    novoRapidController.clear();
    lantusController.clear();
    alimentationController.clear();
    activitesController.clear();
    notesController.clear();
  }

  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0:
        return const NewsPage();
      case 1:
        return const HomePage();
      case 2:
        return const HistoryPage();
      case 3:
        return const ChartPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
