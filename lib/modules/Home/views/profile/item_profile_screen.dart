// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recipe_app/config/theme/theme_style.dart';
import 'package:recipe_app/modules/Home/views/profile/profile_controller.dart';
import '../../models/about_us_model.dart';

class ItemProfileScreen extends GetView<ProfileController> {
  final int index;
  final String title;
  const ItemProfileScreen({
    super.key,
    required this.index,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, const Color(0xFF0d6f59)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(title, style: AppTextStyle.poppinsLargeRegular20()),
        leadingWidth: 56,
        leading: SizedBox(
          width: 56,
          height: 56,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            onPressed: () {
              print('Back button tapped'); // Debug log
              Navigator.pop(context);
            },
            tooltip: 'Back',
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child:
            index == 0
                ? const EditProfileContent()
                : index == 1
                ? const AboutUsContent()
                : index == 2
                ? ContactUsContent()
                : index == 3
                ? const TermOfUseContent()
                : const Center(child: Text("Unknown Option")),
      ),
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
  final ImagePicker _picker = ImagePicker();
  final ProfileController controller = Get.find<ProfileController>();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        controller.profileImage.value = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No image selected')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.birthDate.value ?? DateTime(2000),
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
      controller.birthDate.value = picked;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd / MMM / yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(
        () =>
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
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
                : SmartRefresher(
                  controller: controller.refreshController.value,
                  enablePullDown: true,
                  header: WaterDropHeader(
                    waterDropColor: AppColors.primaryColor,
                  ),
                  onRefresh: controller.onRefresh,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _buildEditForm(),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Center(
            child: Obx(() {
              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width > 1000 ? 100 : 85,
                    backgroundColor: AppColors.primaryColor[200],
                    child: CircleAvatar(
                      radius:
                          MediaQuery.of(context).size.width > 1000 ? 95 : 80,
                      backgroundColor: AppColors.primaryColor[400],
                      child: CircleAvatar(
                        radius:
                            MediaQuery.of(context).size.width > 1000 ? 90 : 75,
                        backgroundImage:
                            controller.profileImage.value != null
                                ? FileImage(controller.profileImage.value!)
                                : const AssetImage(
                                      'assets/images/hong_profile.png',
                                    )
                                    as ImageProvider,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 14),
          _buildLabel('Name'),
          const SizedBox(height: 4),
          Obx(() {
            return TextFormField(
              initialValue: controller.name.value,
              onChanged: (value) => controller.name.value = value,
              decoration: _inputDecoration('Enter your name'),
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter your name'
                          : null,
            );
          }),
          const SizedBox(height: 18),
          _buildLabel('Phone Number'),
          const SizedBox(height: 4),
          Obx(() {
            return TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              initialValue: controller.phone.value,
              onChanged: (value) => controller.phone.value = value,
              decoration: _inputDecoration('Enter your phone number'),
              keyboardType: TextInputType.phone,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter your phone number'
                          : value.replaceAll(' ', '').length < 9
                          ? 'Please enter a valid phone number'
                          : null,
            );
          }),
          const SizedBox(height: 18),
          _buildLabel('Date of Birth'),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: _pickDate,
            child: Obx(() {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
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
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.birthDate.value != null
                          ? _formatDate(controller.birthDate.value!)
                          : 'Select Date',
                      style: AppTextStyle.poppinsNormalRegular16(
                        color:
                            controller.birthDate.value != null
                                ? AppColors.neutral
                                : AppColors.neutral.withValues(alpha: 0.5),
                      ),
                    ),
                    Icon(Icons.calendar_today, color: AppColors.primaryColor),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 18),
          _buildLabel('Gender'),
          const SizedBox(height: 4),
          Obx(() {
            final validGender =
                ['Male', 'Female', 'Other'].contains(controller.gender.value)
                    ? controller.gender.value
                    : null;
            return DropdownButtonFormField2<String>(
              value: validGender,
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
                if (value != null) {
                  controller.gender.value = value;
                }
              },
              validator:
                  (value) => value == null ? 'Please select a gender' : null,
              isExpanded: true,
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                offset: const Offset(0, -5),
              ),
              iconStyleData: IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }),
          const SizedBox(height: 18),
          _buildLabel('Email'),
          const SizedBox(height: 4),
          Obx(() {
            return TextFormField(
              initialValue: controller.email.value,
              onChanged: (value) => controller.email.value = value,
              decoration: _inputDecoration('Enter your email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            );
          }),
          const SizedBox(height: 40),
          Obx(() {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              onPressed:
                  controller.isLoading.value
                      ? null
                      : () async {
                        if (_formKey.currentState!.validate()) {
                          await controller.saveProfile();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: const Row(
                                children: [
                                  Icon(Icons.check, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text('Profile updated successfully'),
                                ],
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                          // Ensure navigation back after saving
                          Navigator.pop(context);
                        }
                      },
              child:
                  controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        'Save Profile',
                        style: AppTextStyle.poppinsNormalRegular16(
                          color: Colors.white,
                        ),
                      ),
            );
          }),
          const SizedBox(height: 20),
        ],
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyle.poppinsSmallRegular14(color: AppColors.neutral),
    );
  }
}

// ===========================================================================
//                                AboutUsContent
// ===========================================================================

class AboutUsContent extends StatelessWidget {
  const AboutUsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();
    return Obx(
      () =>
          controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
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
              : SmartRefresher(
                controller: controller.refreshController.value,
                enablePullDown: true,
                header: WaterDropHeader(waterDropColor: AppColors.primaryColor),
                onRefresh: controller.onRefresh,
                child: SingleChildScrollView(
                  child: _buildBody(controller.aboutUsModels),
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
                      padding: const EdgeInsets.only(top: 4),
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
    final ProfileController controller = Get.find<ProfileController>();
    return Obx(
      () =>
          controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
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
              : SmartRefresher(
                controller: controller.refreshController.value,
                enablePullDown: true,
                header: WaterDropHeader(waterDropColor: AppColors.primaryColor),
                onRefresh: controller.onRefresh,
                child: SingleChildScrollView(child: _buildBody),
              ),
    );
  }

  Widget get _buildBody {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Us",
            style: AppTextStyle.poppinsMediumBold18(color: AppColors.neutral),
          ),
          const SizedBox(height: 24),
          Text(
            "Have questions, feedback, or need support? We're here to help! "
            "Reach out to us anytime and our team will get back to you as soon as possible.",
            style: AppTextStyle.poppinsSmallRegular14(color: AppColors.neutral),
          ),
          const SizedBox(height: 24),
          Column(
            children: List.generate(
              contactItems.length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: Row(
                  children: [
                    Icon(
                      contactItems[index]['icon'],
                      color: AppColors.primaryColor,
                      size: 34,
                    ),
                    const SizedBox(width: 14),
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
          const SizedBox(height: 24),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl:
                  'https://www.google.com/maps/vt/data=k7MNbRH56k09vKFuNer-e6GzGbcpNkt39OScVpzRMk05LCW5qRv7JGdP0NVWbbI1SicWq4OIcoF4zG0rjiheFjbmZc0SBYi3G9ubO3-tzR312SqipvV7LPpEClFvWgj4QfggapEGWLdJUOmIDoE0GFg2okXdnPCc6TMGxIT3IOT6j7RUFwwx5Ogc-vdtHJy0siulDCOosaghBYFJmM2Vgj327usfxKlmcnm168A8IEDwY-fkq4KZzsaNcxaX9pXMIBHWRLUKCXFzwDlMPSfJcuUlw9-LBhx2x8466Q',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: SizedBox()),
              errorWidget:
                  (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
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
    final ProfileController controller = Get.find<ProfileController>();
    return Obx(
      () =>
          controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
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
              : SmartRefresher(
                controller: controller.refreshController.value,
                enablePullDown: true,
                header: WaterDropHeader(waterDropColor: AppColors.primaryColor),
                onRefresh: controller.onRefresh,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Terms of Use"),
                      const SizedBox(height: 24),
                      _buildParagraph(
                        "Welcome to Recipe App! By using our app, you agree to the following terms and conditions. Please read them carefully.",
                      ),
                      const SizedBox(height: 18),
                      _buildSectionTitle("1. Use of Content"),
                      const SizedBox(height: 6),
                      _buildParagraph(
                        "All recipes, images, and content provided in this app are for personal, non-commercial use only. You may not reproduce, distribute, or use any content for commercial purposes without permission.",
                      ),
                      const SizedBox(height: 18),
                      _buildSectionTitle("2. User Conduct"),
                      const SizedBox(height: 6),
                      _buildParagraph(
                        "You agree not to misuse the app, upload harmful content, or engage in any activity that may harm the app or its users.",
                      ),
                      const SizedBox(height: 18),
                      _buildSectionTitle("3. Privacy"),
                      const SizedBox(height: 6),
                      _buildParagraph(
                        "We respect your privacy. Please refer to our Privacy Policy for information on how we collect, use, and protect your data.",
                      ),
                      const SizedBox(height: 18),
                      _buildSectionTitle("4. Disclaimer"),
                      const SizedBox(height: 6),
                      _buildParagraph(
                        "The recipes and nutritional information provided are for reference only. Please consult a professional for dietary advice.",
                      ),
                      const SizedBox(height: 18),
                      _buildSectionTitle("5. Changes to Terms"),
                      const SizedBox(height: 6),
                      _buildParagraph(
                        "We may update these Terms of Use from time to time. Continued use of the app constitutes acceptance of the updated terms.",
                      ),
                      const SizedBox(height: 24),
                      _buildParagraph(
                        "If you have any questions about these terms, please contact us through the Contact Us section.",
                      ),
                    ],
                  ),
                ),
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
