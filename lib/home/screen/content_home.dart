import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_app/home/models/users_model.dart';
import 'package:register_app/home/screen/detail_user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:register_app/utils/colors.dart';
import 'package:register_app/utils/custom_text.dart';
import 'package:register_app/home/provider/users_provider.dart';
import 'package:register_app/login/screen/login_screen.dart';

class ContentHome extends StatefulWidget {
  const ContentHome({super.key});

  @override
  State<ContentHome> createState() => _ContentHomeState();
}

class _ContentHomeState extends State<ContentHome> {
  final TextEditingController searchController = TextEditingController();
  String username = '';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    setState(() {
      username = savedUsername ?? '';
    });
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CustomText(
          text: 'Welcome $username',
          fontSize: 20,
          color: AppColors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.white),
            onPressed: logout,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Cari nama...",
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ), // Warna ikon
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          Expanded(
            child: PagedListView<int, Users>(
              pagingController: provider.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Users>(
                itemBuilder: (context, user, index) {
                  final isMatch =
                      user.username?.toLowerCase().contains(searchQuery) ??
                      false;

                  if (!isMatch) return const SizedBox();

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: user.username.toString(),
                                    fontSize: 20,
                                    color: AppColors.white,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => DetailUserScreen(
                                                userId: user.id!,
                                              ),
                                        ),
                                      );
                                    },
                                    child: CustomText(
                                      text: 'Detail',
                                      fontSize: 15,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                              CustomText(
                                text: user.email.toString(),
                                fontSize: 20,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                noItemsFoundIndicatorBuilder:
                    (_) =>
                        const Center(child: Text('Tidak ada data ditemukan.')),
                firstPageProgressIndicatorBuilder:
                    (_) => const Center(child: CircularProgressIndicator()),
                newPageProgressIndicatorBuilder:
                    (_) => const Center(child: CircularProgressIndicator()),
                firstPageErrorIndicatorBuilder:
                    (_) => const Center(child: Text('Gagal memuat data.')),
                newPageErrorIndicatorBuilder:
                    (_) => const Center(
                      child: Text('Gagal memuat halaman berikutnya.'),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
