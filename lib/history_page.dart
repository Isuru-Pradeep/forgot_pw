// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HistoryPage extends StatefulWidget {
//   final String email;

//   HistoryPage({required this.email});

//   @override
//   _HistoryPageState createState() => _HistoryPageState();
// }

// class _HistoryPageState extends State<HistoryPage> {
//   List<Map<String, dynamic>> _historyData = [
//     // {
//     //   'image':
//     //       'https://images.pexels.com/photos/112811/pexels-photo-112811.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//     //   'palette': ['#FF5733', '#C70039', '#900C3F', '#581845']
//     // },
//     // {
//     //   'image':
//     //       'https://images.pexels.com/photos/271816/pexels-photo-271816.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//     //   'palette': ['#3498DB', '#2ECC71', '#F1C40F', '#E67E22']
//     // },
//     // {
//     //   'image':
//     //       'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//     //   'palette': ['#FF5733', '#C70039', '#900C3F', '#581845']
//     // },
//     // {
//     //   'image':
//     //       'https://images.pexels.com/photos/259962/pexels-photo-259962.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//     //   'palette': ['#3498DB', '#2ECC71', '#F1C40F', '#E67E22']
//     // },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _fetchHistory();
//   }

//   Future<void> _fetchHistory() async {
//     final response = await http.get(
//       Uri.parse('http://10.0.2.2:8080/api/v1/history/pradeepisuru31@gmail.com'),
//     );
//     print("status cod ${response.statusCode}");
//     if (response.statusCode == 200) {
//       setState(() {
//         _historyData =
//             List<Map<String, dynamic>>.from(json.decode(response.body));
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching history')),
//       );
//     }
//   }

//   void _showClearHistoryDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Clear History'),
//           content: Text(
//               'Are you sure, you want to clear previously generated color palettes with image?'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('No'),
//             ),
//             TextButton(
//               onPressed: () {
//                 _clearHistory();
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Yes'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _clearHistory() async {
//     final response = await http.delete(
//       Uri.parse('http://10.0.2.2:8080/api/v1/history/${widget.email}'),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         _historyData.clear(); // Clear the history data
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text(
//                 'Previously generated color palettes and images history Cleared')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error clearing history')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('History Page')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: _historyData.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: _historyData.length,
//                       itemBuilder: (context, index) {
//                         final item = _historyData[index];
//                         return Card(
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           child: Column(
//                             children: [
//                               Image.network(item['image']),
//                               SizedBox(height: 10),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: item['palette'].map<Widget>((color) {
//                                   return Container(
//                                     width: 50,
//                                     height: 50,
//                                     color: Color(int.parse(
//                                             color.substring(1, 7),
//                                             radix: 16) +
//                                         0xFF000000),
//                                   );
//                                 }).toList(),
//                               ),
//                               SizedBox(height: 10),
//                             ],
//                           ),
//                         );
//                       },
//                     )
//                   : Center(child: Text('No history available')),
//             ),
//             ElevatedButton(
//               onPressed: _showClearHistoryDialog,
//               child: Text('Clear History'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Back to Menu'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  final String email;

  HistoryPage({required this.email});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _historyData = [];

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/history/pradeepisuru31@gmail.com'),
    );
    print("Status code: ${response.statusCode}");
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        _historyData = jsonResponse.map((item) {
          return {
            'image': item['image'],
            'palette': (item['palette'][0] as String)
                .split(' ')
                .map((color) => color.trim())
                .toList(),
          };
        }).toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching history')),
      );
    }
  }

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

  Future<void> _clearHistory() async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8080/api/v1/history/${widget.email}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _historyData.clear(); // Clear the history data
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Previously generated color palettes and images history Cleared')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error clearing history')),
      );
    }
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
