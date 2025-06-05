import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker_bloc_app/screens/add_expense/bloc/create_category_bloc/create_category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';

getCategoryCreation(BuildContext context) {
  List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel',
  ];
  final theme = Theme.of(context);

  return showDialog(
    context: context,
    builder: (ctx) {
      bool isExtended = false;
      String iconSelected = '';
      Color categoryColor = Colors.grey;
      TextEditingController categoryNameController = TextEditingController();
      TextEditingController categoryController = TextEditingController();
      TextEditingController categoryIconController = TextEditingController();
      TextEditingController categoryColorController = TextEditingController();
      bool isLoading = false;

      return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
        child: StatefulBuilder(
          builder: (ctx, setState) {
            return BlocListener<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                if (state is CreateCategorySuccess) {
                  Navigator.of(ctx).pop();
                } else if (state is CreateCategoryLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: theme.colorScheme.tertiary, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Center(
                  child: Text(
                    'Create a category',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                backgroundColor: Colors.black,
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16),
                      TextFormField(
                        controller: categoryNameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          label: Text('Name', style: theme.textTheme.bodyLarge),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: categoryIconController,
                        onTap: () {
                          setState(() {
                            isExtended = !isExtended;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey,
                          suffixIcon: Icon(
                            CupertinoIcons.chevron_down,
                            color: theme.colorScheme.tertiary,
                          ),
                          isDense: true,
                          label: Text('Icon', style: theme.textTheme.bodyLarge),
                          border: OutlineInputBorder(
                            borderRadius:
                                isExtended
                                    ? BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    )
                                    : BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      isExtended
                          ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                    ),
                                itemCount: myCategoriesIcons.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        iconSelected = myCategoriesIcons[index];
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 3,
                                          color:
                                              iconSelected ==
                                                      myCategoriesIcons[index]
                                                  ? theme.colorScheme.primary
                                                  : theme.colorScheme.tertiary,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/${myCategoriesIcons[index]}.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                          : Container(),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: categoryColorController,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx2) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                      labelTextStyle:
                                          theme.textTheme.labelSmall,
                                      pickerColor: categoryColor,
                                      onColorChanged: (value) {
                                        setState(() {
                                          categoryColor = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Save Color',
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: categoryColor,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          label: Text(
                            'Color',
                            style: theme.textTheme.bodyLarge,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child:
                              isLoading == true
                                  ? Center(child: CircularProgressIndicator())
                                  : TextButton(
                                    onPressed: () {
                                      Category category = Category.empty;
                                      category.categoryId = Uuid().v1();
                                      category.name = categoryController.text;
                                      category.icon = iconSelected;
                                      category.color = categoryColor.toString();
                                      context.read<CreateCategoryBloc>().add(
                                        CreateCategory(category),
                                      );
                                      // Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      'Save',
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
