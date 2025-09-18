import 'package:flutter/material.dart';
import 'package:noviindusvideoapp/presentation/widgets/video_picker.dart';
import 'package:provider/provider.dart';
import 'package:noviindusvideoapp/core/theme/colors.dart';
import 'package:noviindusvideoapp/presentation/widgets/category_widget.dart';
import 'package:noviindusvideoapp/providers/add_feed_provider.dart';

class AddFeedsPage extends StatelessWidget {
  AddFeedsPage({super.key});

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddFeedProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Feeds',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [Consumer<AddFeedProvider>(
        builder: (context, provider, child) {
          return OutlinedButton(
            onPressed: provider.isLoading
                ? null // disabled while uploading
                : () {
                    provider.setDesc(_descriptionController.text);
                    provider.uploadFeed(context);
                  },
            style: OutlinedButton.styleFrom(
              foregroundColor: provider.isLoading 
                  ? Colors.grey 
                  : AppColors.primary,
            ),
            child: provider.isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Text(
                    'Share Post',
                    style: TextStyle(color: AppColors.primary, fontSize: 16),
                  ),
          );
        },
      ),
    ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use VideoUploadWidget here
            VideoUploadWidget(),
            SizedBox(height: 20),

            // Thumbnail Section
            GestureDetector(
              onTap: () async {
                await provider.pickImage();
              },
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFF404040),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: provider.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          provider.image!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: Colors.white70,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Add a Thumbnail',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
              ),
            ),

            SizedBox(height: 24),

            // Description Section
            Text(
              'Add Description',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              style: TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: 'Add Description here....',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
            ),

            SizedBox(height: 32),

            // Categories Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories This Project',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(color: AppColors.primary, fontSize: 14),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.primary,
                      size: 12,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            // Category Tags
            CategorySelectionWidget(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
