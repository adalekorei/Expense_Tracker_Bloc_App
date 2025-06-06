import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker_bloc_app/screens/add_expense/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracker_bloc_app/screens/add_expense/bloc/get_categories_bloc/get_categories_bloc.dart';
import 'package:expense_tracker_bloc_app/screens/add_expense/views/category_creation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
    expense = Expense.empty;
    expense.expenseId = Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = DateTime.now();
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.of(context).pop(expense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(backgroundColor: theme.appBarTheme.backgroundColor),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Add Expenses', style: theme.textTheme.titleLarge),
                      SizedBox(height: 48),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: expenseController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(
                              CupertinoIcons.money_dollar,
                              color: theme.colorScheme.tertiary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      TextFormField(
                        readOnly: true,
                        onTap: () {},
                        controller: categoryController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              expense.category == Category.empty
                                  ? Colors.black
                                  : Color(expense.category.color),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          label: Text(
                            'Category',
                            style: theme.textTheme.bodyLarge,
                          ),
                          prefixIcon:
                              expense.category == Category.empty
                                  ? Icon(
                                    CupertinoIcons.list_bullet,
                                    color: theme.colorScheme.tertiary,
                                  )
                                  : Image.asset(
                                    'assets/${expense.category.icon}.png',
                                    scale: 1.5,
                                    color: Colors.white,
                                  ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var newCategory = await getCategoryCreation(
                                context,
                              );
                              setState(() {
                                state.categories.insert(0, newCategory);
                              });
                            },
                            icon: Icon(
                              CupertinoIcons.add,
                              color: theme.colorScheme.tertiary,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      expense.category =
                                          state.categories[index];
                                      categoryController.text =
                                          expense.category.name;
                                    });
                                  },
                                  leading: Image.asset(
                                    'assets/${state.categories[index].icon}.png',
                                    scale: 1.5,
                                  ),
                                  title: Text(state.categories[index].name),
                                  tileColor: Color(
                                    state.categories[index].color,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: dateController,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: expense.date,
                            firstDate: date,
                            lastDate: date.add(Duration(days: 365)),
                          );
                          if (newDate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(newDate).toString();
                              expense.date = newDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.colorScheme.tertiary,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          label: Text('Date', style: theme.textTheme.bodyLarge),
                          prefixIcon: Icon(
                            CupertinoIcons.clock,
                            color: theme.colorScheme.tertiary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child:
                            isLoading
                                ? Center(child: CircularProgressIndicator())
                                : TextButton(
                                  onPressed: () {
                                    setState(() {
                                      expense.amount = int.parse(
                                        expenseController.text,
                                      );
                                    });

                                    context.read<CreateExpenseBloc>().add(
                                      CreateExpense(expense),
                                    );
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
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
