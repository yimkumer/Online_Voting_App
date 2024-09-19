import 'package:flutter/material.dart';

class AdminCulturalsecretary extends StatefulWidget {
  const AdminCulturalsecretary({super.key});

  @override
  State<AdminCulturalsecretary> createState() => _AdminCulturalsecretaryState();
}

class _AdminCulturalsecretaryState extends State<AdminCulturalsecretary> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  List<Map<String, dynamic>> allCandidates = [
    {
      'icon': Icons.person,
      'name': 'Angela Martin',
      'department': 'Accounting',
      'year': 'Senior',
      'votes': 120,
    },
    {
      'icon': Icons.person,
      'name': 'Oscar Martinez',
      'department': 'Finance',
      'year': 'Junior',
      'votes': 95,
    },
    {
      'icon': Icons.person,
      'name': 'Kevin Malone',
      'department': 'Accounting',
      'year': 'Sophomore',
      'votes': 80,
    },
    {
      'icon': Icons.person,
      'name': 'Stanley Hudson',
      'department': 'Sales',
      'year': 'Freshman',
      'votes': 60,
    },
  ];

  List<Map<String, dynamic>> displayedCandidates = [];

  @override
  void initState() {
    super.initState();
    displayedCandidates = allCandidates;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.unfocus();
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = allCandidates;
    } else {
      results = allCandidates
          .where((candidate) =>
              candidate['name']!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              candidate['department']!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      displayedCandidates = results;
    });
  }

  void _addCandidate() {
    setState(() {
      allCandidates.add({
        'icon': Icons.person,
        'name': _nameController.text,
        'department': _departmentController.text,
        'year': _yearController.text,
        'votes': 0,
      });
      displayedCandidates = allCandidates;
    });
    _nameController.clear();
    _departmentController.clear();
    _yearController.clear();
    Navigator.of(context).pop();
  }

  void _deleteCandidate(String candidateName) {
    setState(() {
      allCandidates
          .removeWhere((candidate) => candidate['name'] == candidateName);
      displayedCandidates = allCandidates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const FittedBox(
          child: Text(
            "- Cultural Candidates -",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff030034),
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _showAddCandidateDialog(),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff030034),
                Color(0xFF040040),
                Color(0xFF06005D),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) => _runFilter(value),
                ),
              ),
              const Center(
                child: Text(
                  "Note: Long Press on the Candidate Card to delete",
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 13),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            _getCrossAxisCount(constraints.maxWidth),
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      padding: const EdgeInsets.all(16),
                      itemCount: displayedCandidates.length,
                      itemBuilder: (context, index) => _buildGridItem(
                          displayedCandidates[index], constraints.maxWidth),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1200) return 5;
    if (width > 900) return 4;
    if (width > 600) return 3;
    return 2;
  }

  Widget _buildGridItem(Map<String, dynamic> candidate, double maxWidth) {
    double fontSize = maxWidth < 600 ? 18 : 20;
    return GestureDetector(
      onLongPress: () => _showDeleteCandidateDialog(candidate['name']),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              candidate['icon'],
              size: maxWidth < 600 ? 80 : 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            Text(
              candidate['name'],
              style: TextStyle(
                color: Colors.pink,
                fontWeight: FontWeight.w500,
                fontSize: fontSize,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              candidate['department'],
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: fontSize * 0.80,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Votes: ${candidate['votes']}',
              style: TextStyle(
                color: Colors.green,
                fontSize: fontSize * 0.80,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCandidateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Candidate'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _departmentController,
                decoration: const InputDecoration(labelText: 'Department'),
              ),
              TextField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Year'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addCandidate,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteCandidateDialog(String candidateName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Candidate'),
          content:
              Text('Are you sure you want to delete Candidate $candidateName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteCandidate(candidateName);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
