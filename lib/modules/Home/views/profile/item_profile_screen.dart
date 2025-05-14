import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/config/theme/theme_style.dart';

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
  DateTime? _selectedDate = DateTime.now();

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = _monthName(date.month);
    final year = date.year;
    return '$day / $month / $year';
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(body: Container(color: Colors.white, child: _buildEdit)),
    );
  }

  Widget get _buildEdit {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundColor: AppColors.primaryColor[200],
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: AppColors.primaryColor[400],
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage(
                      'assets/images/hong_profile.png',
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Name',
                  style: AppTextStyle.poppinsSmallRegular14(
                    color: AppColors.neutral,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Rin Kimhong',
                  hintStyle: AppTextStyle.poppinsNormalRegular16(
                    color: AppColors.neutral,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.neutral),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Phone number',
                  style: AppTextStyle.poppinsSmallRegular14(
                    color: AppColors.neutral,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '+855 86 240 668',
                  hintStyle: AppTextStyle.poppinsNormalRegular16(
                    color: AppColors.neutral,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.neutral),
                  ),
                ),
              ),

              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Date of Birth',
                  style: AppTextStyle.poppinsSmallRegular14(
                    color: AppColors.neutral,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.neutral.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    _formatDate(_selectedDate!),
                    style: AppTextStyle.poppinsNormalRegular16(
                      color: AppColors.neutral,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Gender',
                  style: AppTextStyle.poppinsSmallRegular14(
                    color: AppColors.neutral,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: DropdownButtonFormField2<String>(
                  value:
                      _selectedGender, // Ensure _selectedGender is initialized
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.neutral),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.neutral[500] ?? Colors.grey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),

                    hintText: 'Select Gender',
                    hintStyle: AppTextStyle.poppinsNormalRegular16(
                      color: AppColors.neutral.withValues(alpha: 0.5),
                    ),
                  ),
                  style: AppTextStyle.poppinsNormalRegular16(
                    color: AppColors.neutral,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: double.infinity, // Match parent width
                    decoration: BoxDecoration(
                      color: Colors.white, // Popup background color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    offset: const Offset(0, -5), // Adjust dropdown position
                  ),
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
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Email',
                  style: AppTextStyle.poppinsSmallRegular14(
                    color: AppColors.neutral,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Rinkimhong4@gmail.com',
                  hintStyle: AppTextStyle.poppinsNormalRegular16(
                    color: AppColors.neutral,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.neutral),
                  ),
                ),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
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
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "AboutUsContent",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
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
