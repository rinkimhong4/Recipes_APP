import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/controller/home_controller.dart';
import '../../models/about_us_model.dart';

class ItemProfileScreen extends StatelessWidget {
  final int index;
  final String title;
  const ItemProfileScreen({
    super.key,
    required this.index,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Widget content =
        index == 0
            ? EditProfileContent()
            : index == 1
            ? AboutUsContent()
            : index == 2
            ? ContactUsContent()
            : index == 3
            ? TermOfUseContent()
            : Text("Unknown Option");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(title, style: AppTextStyle.poppinsLargeRegular20()),
        leading: BackButton(color: Colors.white),
      ),
      body: Center(child: content),
    );
  }
}

// ===========================================================================
//                                EditProfileContent
// ===========================================================================

class EditProfileContent extends StatefulWidget {
  const EditProfileContent({super.key});

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate = DateTime.now();
  String _selectedGender = 'Male';
  final TextEditingController _nameController = TextEditingController(
    text: 'Rin Kimhong',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+855 86 240 668',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'Rinkimhong4@gmail.com',
  );

  String _formatDate(DateTime date) {
    return DateFormat('dd / MMM / yyyy').format(date);
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(color: Colors.white, child: _buildEdit),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildEdit {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 85,
                    backgroundColor: AppColors.primaryColor[200],
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: AppColors.primaryColor[400],
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: AssetImage(
                          'assets/images/hong_profile.png',
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.2),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Implement image picker logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Image picker not implemented')),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Text(
              'Name',
              style: AppTextStyle.poppinsSmallRegular14(
                color: AppColors.neutral,
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration('Enter your name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            Text(
              'Phone Number',
              style: AppTextStyle.poppinsSmallRegular14(
                color: AppColors.neutral,
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _phoneController,
              decoration: _inputDecoration('Enter your phone number'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 18),
            Text(
              'Date of Birth',
              style: AppTextStyle.poppinsSmallRegular14(
                color: AppColors.neutral,
              ),
            ),
            SizedBox(height: 4),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate != null
                          ? _formatDate(_selectedDate!)
                          : 'Select Date',
                      style: AppTextStyle.poppinsNormalRegular16(
                        color:
                            _selectedDate != null
                                ? AppColors.neutral
                                : AppColors.neutral.withValues(alpha: 0.5),
                      ),
                    ),
                    Icon(Icons.calendar_today, color: AppColors.primaryColor),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Gender',
              style: AppTextStyle.poppinsSmallRegular14(
                color: AppColors.neutral,
              ),
            ),
            SizedBox(height: 4),
            DropdownButtonFormField2<String>(
              value: _selectedGender,
              decoration: _inputDecoration('Select Gender'),
              items:
                  ['Male', 'Female', 'Other']
                      .map(
                        (gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(
                            gender,
                            style: AppTextStyle.poppinsNormalRegular16(
                              color: AppColors.neutral,
                            ),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a gender';
                }
                return null;
              },
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                offset: Offset(0, -5),
              ),
              iconStyleData: IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 18),
            Text(
              'Email',
              style: AppTextStyle.poppinsSmallRegular14(
                color: AppColors.neutral,
              ),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _emailController,
              decoration: _inputDecoration('Enter your email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile updated successfully')),
                  );
                  // Implement save logic here
                }
              },
              child: Text(
                'Save Profile',
                style: AppTextStyle.poppinsNormalRegular16(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyle.poppinsNormalRegular16(
        color: AppColors.neutral.withValues(alpha: 0.5),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.neutral),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.primaryColor.withValues(alpha: 0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}
// ===========================================================================
//                                AboutUsContent
// ===========================================================================

class AboutUsContent extends StatefulWidget {
  const AboutUsContent({super.key});

  @override
  State<AboutUsContent> createState() => _AboutUsContentState();
}

class _AboutUsContentState extends State<AboutUsContent> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        body: Obx(
          () =>
              controller.isLoading.value
                  ? SizedBox()
                  : controller.errorMessage.value.isNotEmpty
                  ? Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: AppTextStyle.poppinsSmallRegular14(
                        color: AppColors.neutral,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                  : SingleChildScrollView(
                    child: _buildBody(controller.aboutUsModels),
                  ),
        ),
      ),
    );
  }

  Widget _buildBody(AboutUsModels aboutUsModels) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (aboutUsModels.about?.description?.isNotEmpty ?? false) ...[
            _buildSectionTitle("About Us"),
            ...aboutUsModels.about!.description!.map(_buildParagraph),
          ],

          if (aboutUsModels.mission?.description?.isNotEmpty ?? false) ...[
            SizedBox(height: 30),
            _buildSectionTitle(aboutUsModels.mission!.title ?? "Our Mission"),
            _buildParagraph(aboutUsModels.mission!.description!),
          ],

          if (aboutUsModels.features?.items?.isNotEmpty ?? false) ...[
            SizedBox(height: 30),
            _buildSectionTitle(aboutUsModels.features!.title ?? "Features"),
            ...aboutUsModels.features!.items!.map(
              (item) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(item.name ?? ""),
                  if (item.description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: _buildParagraph(
                        item.description is List<String>
                            ? (item.description as List<String>).join('\n')
                            : item.description.toString(),
                      ),
                    ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],

          if (aboutUsModels.whyChooseUs?.description?.isNotEmpty ?? false) ...[
            SizedBox(height: 30),
            _buildSectionTitle(
              aboutUsModels.whyChooseUs!.title ?? "Why Choose Us",
            ),
            _buildParagraph(aboutUsModels.whyChooseUs!.description!),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: AppTextStyle.poppinsMediumBold18(color: AppColors.neutral),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: AppTextStyle.poppinsSmallRegular14(color: AppColors.neutral),
      ),
    );
  }
}

// ===========================================================================
//                                ContactUsContent
// ===========================================================================

class ContactUsContent extends StatelessWidget {
  ContactUsContent({super.key});

  final List<Map<String, dynamic>> contactItems = [
    {'title': "086 240 668 / 012 345 567", 'icon': Icons.call_outlined},
    {'title': "rinkimhong4@gmail.com", 'icon': Icons.email_outlined},
    {
      'title': "https://www.facebook.com/rinkimhong",
      'icon': Icons.language_outlined,
    },
    {
      'title': "#168, Street 68, Phnom Penh, Cambodia",
      'icon': Icons.location_on_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody);
  }

  get _buildBody {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Us",
            style: AppTextStyle.poppinsMediumBold18(color: AppColors.neutral),
          ),
          SizedBox(height: 24),
          Text(
            "Have questions, feedback, or need support? We're here to help! "
            "Reach out to us anytime and our team will get back to you as soon as possible.",
            style: AppTextStyle.poppinsSmallRegular14(color: AppColors.neutral),
          ),
          SizedBox(height: 24),
          Column(
            children: List.generate(
              contactItems.length,
              (index) => Padding(
                padding: EdgeInsets.only(top: 16, bottom: 24),
                child: Row(
                  children: [
                    Icon(
                      contactItems[index]['icon'],
                      color: AppColors.primaryColor,
                      size: 34,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        contactItems[index]['title'],
                        style: AppTextStyle.poppinsNormalRegular16(
                          color: AppColors.neutral,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl:
                  'https://www.google.com/maps/vt/data=k7MNbRH56k09vKFuNer-e6GzGbcpNkt39OScVpzRMk05LCW5qRv7JGdP0NVWbbI1SicWq4OIcoF4zG0rjiheFjbmZc0SBYi3G9ubO3-tzR312SqipvV7LPpEClFvWgj4QfggapEGWLdJUOmIDoE0GFg2okXdnPCc6TMGxIT3IOT6j7RUFwwx5Ogc-vdtHJy0siulDCOosaghBYFJmM2Vgj327usfxKlmcnm168A8IEDwY-fkq4KZzsaNcxaX9pXMIBHWRLUKCXFzwDlMPSfJcuUlw9-LBhx2x8466Q',
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: SizedBox()),
              errorWidget:
                  (context, url, error) => Center(child: Icon(Icons.error)),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
//                                TermOfUseContent
// ===========================================================================
class TermOfUseContent extends StatelessWidget {
  const TermOfUseContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle('Terms of Use for Recipe App'),
              _buildDate('Last Updated: May 16, 2025'),
              _buildIntro(),
              _buildSection('1. Acceptance of Terms', '''
By using the App, you agree to these Terms. You confirm that:
- You are at least 13 years old. Users under 18 require parental consent.
- You have the authority to accept these Terms.
- You will comply with all applicable laws.

We may update these Terms. Continued use after updates means you accept them. For questions, email rinkimhong4@gmail.com.
'''),
              _buildSection('2. License to Use the App', '''
We grant you a limited, non-exclusive, non-transferable, revocable license to use the App on your device for personal, non-commercial purposes. You may not:
- Copy, modify, or distribute the App, except for personal backups.
- Reverse-engineer or disassemble the App.
- Rent, lease, sell, or sublicense the App.
- Use the App for illegal purposes.
'''),
              _buildSection('3. App Features and Content', '''
The App offers:
- Recipes with ingredients and instructions.
- Contact options (phone, email, Facebook).
- A map showing our location (#168, Street 68, Phnom Penh, Cambodia).

**Intellectual Property**
- Our content (design, text, images, recipes) is protected by copyright and trademark laws.
- User content (e.g., recipes, feedback) grants us a worldwide, royalty-free license to use and display.
- Third-party content (e.g., recipes) is credited to its creators.
'''),
              _buildSection('4. User Conduct', '''
You agree to:
- Not post unlawful, defamatory, or obscene content.
- Not harass or harm others.
- Not attempt unauthorized access.
- Not share copyrighted recipes without permission.

We may remove content or suspend your access for violations.
'''),
              _buildSection('5. Contact Information', '''
Contact us at:
- Phone: 086 240 668 / 012 345 567
- Email: rinkimhong4@gmail.com
- Facebook: https://www.facebook.com/rinkimhong
- Address: #168, Street 68, Phnom Penh, Cambodia

Do not misuse these details (e.g., spamming).
'''),
              _buildSection('6. Privacy', '''
Your use is subject to our Privacy Policy. We may collect device or usage data. Using the App means you consent to our data practices.
'''),
              _buildSection('7. Third-Party Services', '''
The App uses:
- CachedNetworkImage for images.
- Google Maps for location data.
- Social media links (e.g., Facebook).

We are not responsible for third-party services. Review their terms.
'''),
              _buildSection('8. Termination', '''
We may suspend or terminate your access for violations. Upon termination, delete the App. Sections 3, 9, 10, and 12 remain effective.
'''),
              _buildSection('9. Disclaimer', '''
The App is provided "as is" without warranties. We do not guarantee:
- Content accuracy or reliability.
- Uninterrupted service.
- Availability of contact methods.

Use recipes at your own risk.
'''),
              _buildSection('10. Limitation of Liability', '''
We are not liable for damages from:
- Inaccurate or unsafe recipes.
- Contact failures.
- Third-party service errors.

Liability is limited to any amount you paid for the App.
'''),
              _buildSection('11. Indemnification', '''
You agree to indemnify us for claims or damages from your misuse or violation of these Terms.
'''),
              _buildSection('12. Governing Law', '''
These Reducing redundancy and improving flow Terms are governed by Cambodian law. Disputes will be resolved in Phnom Penh courts, unless local laws differ.
'''),
              _buildSection('13. Jurisdictional Notices', '''
Local laws may grant additional rights. If a term is unenforceable, others remain valid. App stores may impose extra terms.
'''),
              _buildSection('14. Contact Us', '''
For questions, reach us at:
- Email: rinkimhong4@gmail.com
- Phone: 086 240 668 / 012 345 567
- Address: #168, Street 68, Phnom Penh, Cambodia

Do not use the App until your questions are answered.

By using Recipe App, you agree to these Terms. Thank you for choosing our App!
'''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDate(String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(date, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildIntro() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Text(
        'Please read these Terms of Use carefully before using Recipe App. These Terms govern your use of the App, provided by an independent developer ("we," "us," or "our"). By using the App, you agree to these Terms. If you do not agree, do not use the App.',
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
