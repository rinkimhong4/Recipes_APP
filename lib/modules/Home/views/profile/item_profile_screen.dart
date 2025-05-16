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
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (aboutUsModels.about?.description?.isNotEmpty ?? false) ...[
            _buildSectionTitle("About Us"),
            ...aboutUsModels.about!.description!.map(_buildParagraph),
          ],

          if (aboutUsModels.mission?.description?.isNotEmpty ?? false) ...[
            const SizedBox(height: 30),
            _buildSectionTitle(aboutUsModels.mission!.title ?? "Our Mission"),
            _buildParagraph(aboutUsModels.mission!.description!),
          ],

          if (aboutUsModels.features?.items?.isNotEmpty ?? false) ...[
            const SizedBox(height: 30),
            _buildSectionTitle(aboutUsModels.features!.title ?? "Features"),
            ...aboutUsModels.features!.items!.map(
              (item) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildParagraph(item.name ?? ""),
                  if (item.description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: _buildParagraph(
                        item.description is List<String>
                            ? (item.description as List<String>).join('\n')
                            : item.description.toString(),
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],

          if (aboutUsModels.whyChooseUs?.description?.isNotEmpty ?? false) ...[
            const SizedBox(height: 30),
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
      padding: const EdgeInsets.only(bottom: 12.0),
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
  const ContactUsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "ContactUsContent",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TermOfUseContent",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
