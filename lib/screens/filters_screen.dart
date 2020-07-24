import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters_screen';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isLactoseFree = false;
  var _isVegetarian = false;
  var _isVegan = false;

  @override
  initState() {
    _isGlutenFree = widget.currentFilters['gluten'];
    _isLactoseFree = widget.currentFilters['lactose'];
    _isVegetarian = widget.currentFilters['vegetarian'];
    _isVegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String subtitle,
    bool activeValue,
    Function changeValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: activeValue,
      onChanged: changeValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Your filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final _filters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegetarian': _isVegetarian,
                'vegan': _isVegan,
              };
              widget.saveFilters(_filters);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only includes gluten-free meals.',
                  _isGlutenFree,
                  (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include Lactose-free meals.',
                  _isLactoseFree,
                  (newValue) {
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include Vegetarian meals.',
                  _isVegetarian,
                  (newValue) {
                    setState(() {
                      _isVegetarian = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include Vegan meals.',
                  _isVegan,
                  (newValue) {
                    setState(() {
                      _isVegan = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
