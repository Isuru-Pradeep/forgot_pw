import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, dynamic>> _historyData = [
    {
      'image':
          'https://images.pexels.com/photos/112811/pexels-photo-112811.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'palette': ['#FF5733', '#C70039', '#900C3F', '#581845']
    },
    {
      'image':
          'https://images.pexels.com/photos/271816/pexels-photo-271816.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'palette': ['#3498DB', '#2ECC71', '#F1C40F', '#E67E22']
    },
    {
      'image':
          'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'palette': ['#FF5733', '#C70039', '#900C3F', '#581845']
    },
    {
      'image':
          'https://images.pexels.com/photos/259962/pexels-photo-259962.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'palette': ['#3498DB', '#2ECC71', '#F1C40F', '#E67E22']
    },
  ];

  void _showClearHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear History'),
          content: Text(
              'Are you sure, you want to clear previously generated color palettes with image?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                _clearHistory();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _clearHistory() {
    setState(() {
      _historyData.removeLast(); // Clear the history last data
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Previously generated color palettes and images history Cleared')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History Page')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _historyData.isNotEmpty
                  ? ListView.builder(
                      itemCount: _historyData.length,
                      itemBuilder: (context, index) {
                        final item = _historyData[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Image.network(item['image']),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: item['palette'].map<Widget>((color) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    color: Color(int.parse(
                                            color.substring(1, 7),
                                            radix: 16) +
                                        0xFF000000),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No history available')),
            ),
            ElevatedButton(
              onPressed: _showClearHistoryDialog,
              child: Text('Clear History'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
