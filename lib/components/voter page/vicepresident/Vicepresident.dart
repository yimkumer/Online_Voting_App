import 'package:flutter/material.dart';

class VicePresident extends StatefulWidget {
  const VicePresident({super.key});

  @override
  State<VicePresident> createState() => _VicePresidentState();
}

class _VicePresidentState extends State<VicePresident> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String? _selectedCandidate;

  List<Map<String, dynamic>> allCandidates = [
    {
      'icon': Icons.person,
      'name': 'Michael Scott',
      'department': 'Business Administration',
      'year': 'Senior',
    },
    {
      'icon': Icons.person,
      'name': 'Pam Beesly',
      'department': 'Art',
      'year': 'Junior',
    },
    {
      'icon': Icons.person,
      'name': 'Jim Halpert',
      'department': 'Sales',
      'year': 'Sophomore',
    },
    {
      'icon': Icons.person,
      'name': 'Dwight Schrute',
      'department': 'Agriculture',
      'year': 'Freshman',
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

  void _castVote(String candidateName) {
    setState(() {
      if (_selectedCandidate == candidateName) {
        _selectedCandidate = null;
      } else {
        _selectedCandidate = candidateName;
      }
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
            "- Vice President Candidates -",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff030034),
        elevation: 1,
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CandidateDetailPage(candidate: candidate),
        ),
      ),
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
          ],
        ),
      ),
    );
  }
}

class CandidateDetailPage extends StatefulWidget {
  final Map<String, dynamic> candidate;

  const CandidateDetailPage({
    super.key,
    required this.candidate,
  });

  @override
  State<CandidateDetailPage> createState() => _CandidateDetailPageState();
}

class _CandidateDetailPageState extends State<CandidateDetailPage> {
  bool _hasVoted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Candidate Details",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff030034),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
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
              child: Center(
                child: Icon(
                  widget.candidate['icon'],
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.candidate['name'],
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Department: ${widget.candidate['department']}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Year: ${widget.candidate['year']}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _hasVoted = !_hasVoted;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _hasVoted
                                  ? "Vote cast for ${widget.candidate['name']}!"
                                  : "Vote retracted for ${widget.candidate['name']}.",
                              style: const TextStyle(fontSize: 17),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _hasVoted ? Colors.red : const Color(0XFFC91E93),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _hasVoted ? 'Retract Vote' : 'Cast Vote',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
