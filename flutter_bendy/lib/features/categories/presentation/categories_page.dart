import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/category_model.dart';
import '../../../core/models/product_model.dart';
import '../../../core/providers/providers.dart';
import '../../../core/widgets/product_card.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage> {
  // selection moved to Riverpod providers

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategoryId = ref.watch(selectedCategoryIdProvider);
    final selectedSubCategoryId = ref.watch(selectedSubCategoryIdProvider);
    final productsAsync = ref.watch(
      categoryProductsProvider((
        categoryId: selectedCategoryId,
        subCategoryId: selectedSubCategoryId,
      )),
    );

    final subcategoriesAsync = selectedCategoryId != null
      ? ref.watch(subcategoriesProvider(selectedCategoryId!))
      : null;

    final sectionTitle = selectedSubCategoryId != null
      ? 'Subkateqoriya Məhsulları'
      : selectedCategoryId != null
        ? 'Kateqoriya Məhsulları'
        : 'Bütün Məhsullar';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Kateqoriyalar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(color: const Color(0xFFE8E8E8), height: 0.5),
        ),
      ),
      body: categoriesAsync.when(
        data: (categories) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kateqoriya seçin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 96,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (_, index) {
                    final cat = categories[index];
                    final isSelected = cat.id == selectedCategoryId;
                    return GestureDetector(
                      onTap: () {
                        if (selectedCategoryId == cat.id) {
                          ref.read(selectedCategoryIdProvider.notifier).state = null;
                          ref.read(selectedSubCategoryIdProvider.notifier).state = null;
                        } else {
                          ref.read(selectedCategoryIdProvider.notifier).state = cat.id;
                          ref.read(selectedSubCategoryIdProvider.notifier).state = null;
                        }
                      },
                      child: Container(
                        width: 84,
                        margin: EdgeInsets.only(right: index == categories.length - 1 ? 0 : 12),
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? cat.color
                                    : cat.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? cat.color
                                      : cat.color.withOpacity(0.3),
                                ),
                              ),
                              child: Icon(
                                cat.iconData,
                                color: isSelected ? Colors.white : cat.color,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              cat.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? cat.color
                                    : const Color(0xFF555566),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (selectedCategoryId != null) ...[
                const SizedBox(height: 18),
                subcategoriesAsync == null
                    ? const SizedBox.shrink()
                    : subcategoriesAsync.when(
                        data: (subs) {
                          if (subs.isEmpty) {
                            return const Text(
                              'Bu kateqoriyaya aid subkateqoriya yoxdur.',
                              style: TextStyle(fontSize: 14, color: Color(0xFF555566)),
                            );
                          }

                          final category = categories.firstWhere((c) => c.id == selectedCategoryId);

                          return SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: subs.length,
                              itemBuilder: (_, index) {
                                final sub = subs[index];
                                final isSelected = sub.id == selectedSubCategoryId;
                                return Padding(
                                  padding: EdgeInsets.only(right: index == subs.length - 1 ? 0 : 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedSubCategoryId == sub.id) {
                                        ref.read(selectedSubCategoryIdProvider.notifier).state = null;
                                      } else {
                                        ref.read(selectedSubCategoryIdProvider.notifier).state = sub.id;
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: isSelected ? category.color : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: isSelected ? category.color : const Color(0xFFE4E4E4),
                                        ),
                                      ),
                                      child: Text(
                                        sub.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: isSelected ? Colors.white : const Color(0xFF555566),
                                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        loading: () => const SizedBox(
                          height: 40,
                          child: Center(
                            child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF1565C0))),
                          ),
                        ),
                        error: (err, stack) => Text(err.toString(), style: const TextStyle(color: Colors.red)),
                      ),
              ],
              const SizedBox(height: 24),
              Text(
                sectionTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(child: _buildProductGrid(productsAsync)),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
              color: Color(0xFF1565C0), strokeWidth: 2),
        ),
        error: (err, stack) => Center(
          child: Text(err.toString(), style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildSubcategoryChips(List<Category> categories) {
    // This method is no longer used; subcategories are rendered inline in build()
    return const SizedBox.shrink();
  }

  Widget _buildProductGrid(AsyncValue<List<Product>> productsAsync) {
    return productsAsync.when(
      data: (products) {
        if (products.isEmpty) {
          return const Center(
            child: Text(
              'Məhsul tapılmadı. Başqa kateqoriya və ya subkateqoriya seçin.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Color(0xFF555566)),
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.63,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: products.length,
          itemBuilder: (_, index) => ProductCard(product: products[index]),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(
            color: Color(0xFF1565C0), strokeWidth: 2),
      ),
      error: (err, stack) => Center(
        child: Text(err.toString(), style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
