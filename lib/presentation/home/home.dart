import 'package:flutter/material.dart';
import 'package:noviindusvideoapp/core/theme/colors.dart';
import 'package:noviindusvideoapp/presentation/add/add_feed_screen.dart';
import 'package:noviindusvideoapp/presentation/widgets/feed_card.dart';
import 'package:noviindusvideoapp/providers/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Hello Maria",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Welcome back to Section",
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories
              SizedBox(
              height: 45,
              child: Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoadingCategories) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (provider.categories.isEmpty) {
                    return const Center(
                      child: Text(
                        "No categories found",
                        style: TextStyle(color: AppColors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) {
                      final category = provider.categories[index];
                      final isSelected =
                          provider.selectedCategoryIndex == index;

                      return GestureDetector(
                        onTap: () => provider.selectCategory(index),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.textSecondary),
                          ),
                          child: Text(
                            category.title,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          // Feeds
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                if (provider.isLoadingFeeds) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.feeds.isEmpty) {
                  return const Center(
                    child: Text(
                      "No feeds available",
                      style: TextStyle(color: AppColors.white),
                    ),
                  );
                }
      
                return ListView.builder(
                  itemCount: provider.feeds.length,
                  itemBuilder: (context, index) {
                    final feed = provider.feeds[index];
      
                    return FeedCard(
                      feed: feed,
                      isPlaying: provider.playingVideoIndex == index,
                      onPlay: () => provider.setPlayingVideo(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60, 
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddFeedsPage()));
          },
          backgroundColor: AppColors.primary, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          child: Icon(
            Icons.add,
            size: 40, 
          ),
        ),
      ),
    );
  }
}
