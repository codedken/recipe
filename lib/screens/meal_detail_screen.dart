import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail';
  final Function toggleFavorite;
  final Function isMealFavorite;

  MealDetailScreen(this.toggleFavorite, this.isMealFavorite);
  Widget buildTitle(BuildContext ctx, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline2,
      ),
    );
  }

  Widget buildContainer({Widget child}) {
    return Container(
      height: 150,
      width: 300,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[800],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedMeal.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildTitle(context, 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Colors.yellow[800],
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                },
              ),
            ),
            buildTitle(context, 'Steps'),
            buildContainer(
              child: ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${index + 1}'),
                        ),
                        title: Text('${selectedMeal.steps[index]}'),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
