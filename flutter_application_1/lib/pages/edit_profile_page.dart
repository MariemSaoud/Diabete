import 'package:flutter/material.dart';

/// ======================================
/// STOCKAGE DES DONNÉES DU PROFIL
/// ======================================
/// Classe statique simple pour stocker les données du profil patient
/// Les données sont partagées entre profile_page.dart et edit_profile_page.dart
/// Note: Dans une vraie application, utiliser une base de données ou un state management
class ProfileData {
  static String name = 'Patient Exemple';           // Nom complet du patient
  static String age = '45';                          // Âge en années
  static String email = 'patient.exemple@email.com'; // Email de contact
  static String phone = '+33 6 12 34 56 78';        // Numéro de téléphone
  static String genre = 'Homme';                     // Genre (Homme/Femme/Autre)
  static String adresse = '123 Rue de la Paix';     // Adresse postale
  static String ville = 'Paris';                     // Ville de résidence
  static String codePostal = '75000';                // Code postal
}

/// ======================================
/// PAGE D'ÉDITION DU PROFIL
/// ======================================
/// Cette page permet au patient de modifier ses informations personnelles
/// Elle contient 3 sections : Informations Personnelles, Données de Santé, Adresse
/// Les modifications sont sauvegardées dans ProfileData lors du clic sur "Enregistrer"

// Widget StatefulWidget car le formulaire contient des champs modifiables
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Contrôleurs pour gérer le texte des champs de formulaire
  // "late" signifie qu'ils seront initialisés dans initState()
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _adresseController;
  late TextEditingController _villeController;
  late TextEditingController _codePostalController;

  // Valeur sélectionnée pour le dropdown du genre
  String _selectedGenre = 'Homme';

  @override
  void initState() {
    super.initState();
    // Initialiser tous les contrôleurs avec les valeurs actuelles de ProfileData
    _nameController = TextEditingController(text: ProfileData.name);
    _ageController = TextEditingController(text: ProfileData.age);
    _emailController = TextEditingController(text: ProfileData.email);
    _phoneController = TextEditingController(text: ProfileData.phone);
    _adresseController = TextEditingController(text: ProfileData.adresse);
    _villeController = TextEditingController(text: ProfileData.ville);
    _codePostalController = TextEditingController(text: ProfileData.codePostal);
    _selectedGenre = ProfileData.genre;
  }

  @override
  void dispose() {
    // Libérer les ressources des contrôleurs pour éviter les fuites mémoire
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _adresseController.dispose();
    _villeController.dispose();
    _codePostalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Couleur de fond de la page
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Container(
          // Dégradé de fond (bleu clair vers blanc)
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF5F8FF), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          // Contenu défilable pour les petits écrans
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),              // En-tête avec bouton retour et titre
                const SizedBox(height: 24),
                _buildEditForm(),            // Formulaire d'édition avec 3 sections
                const SizedBox(height: 30),
                _buildActionButtons(context), // Boutons Annuler/Enregistrer
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Construire l'en-tête de la page (bouton retour + titre + sous-titre)
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Bouton de retour vers la page profil
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Color(0xFF2564EB)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            // Titre principal
            const Text(
              'Modifier Profil',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2564EB), // Bleu
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Sous-titre descriptif
        const Padding(
          padding: EdgeInsets.only(left: 48),
          child: Text(
            'Mettez à jour vos informations personnelles',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF6B7280), // Gris
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  /// Construire le formulaire d'édition avec 3 sections (cards)
  Widget _buildEditForm() {
    return Column(
      children: [
        // ========== SECTION 1 : INFORMATIONS PERSONNELLES ==========
        _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Informations Personnelles',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 20),
              // Champ Nom Complet
              _buildFormField(
                label: 'Nom Complet',
                controller: _nameController,
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'Email',
                controller: _emailController,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildFormField(
                label: 'Téléphone',
                controller: _phoneController,
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Données de Santé',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'Âge',
                controller: _ageController,
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildGenreDropdown(),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adresse',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 20),
              _buildFormField(
                label: 'Rue',
                controller: _adresseController,
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildFormField(
                      label: 'Ville',
                      controller: _villeController,
                      icon: Icons.location_city_outlined,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildFormField(
                      label: 'Code Postal',
                      controller: _codePostalController,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenreDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Genre',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            color: const Color(0xFFFAFAFA),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.wc_outlined, size: 20, color: Color(0xFF6B7280)),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedGenre,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: ['Homme', 'Femme', 'Autre'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedGenre = newValue;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            color: const Color(0xFFFAFAFA),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Row(
              children: [
                Icon(icon, size: 20, color: const Color(0xFF6B7280)),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: label,
                      hintStyle: const TextStyle(
                        color: Color(0xFFD1D5DB),
                        fontWeight: FontWeight.w500,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Annuler',
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Save profile data
              ProfileData.name = _nameController.text;
              ProfileData.email = _emailController.text;
              ProfileData.phone = _phoneController.text;
              ProfileData.age = _ageController.text;
              ProfileData.genre = _selectedGenre;
              ProfileData.adresse = _adresseController.text;
              ProfileData.ville = _villeController.text;
              ProfileData.codePostal = _codePostalController.text;

              // Show success feedback
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final navigator = Navigator.of(context);
              scaffoldMessenger.showSnackBar(
                const SnackBar(
                  content: Text('Profil mis à jour avec succès'),
                  backgroundColor: Color(0xFF1B8A43),
                  duration: Duration(seconds: 2),
                ),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted) {
                  navigator.pop();
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2564EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Enregistrer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
