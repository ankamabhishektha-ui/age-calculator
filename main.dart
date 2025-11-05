import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyCompanyApp());
}

class MyCompanyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgeX Technologies Pvt. Ltd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CompanyHomePage(),
    );
  }
}

class CompanyHomePage extends StatefulWidget {
  @override
  _CompanyHomePageState createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeTab(),
    AboutTab(),
    ServicesTab(),
    NotificationsTab(),
    ContactTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.jpg', height: 40),
            const SizedBox(width: 10),
            const Text('AgeX Technologies Pvt. Ltd'),
          ],
        ),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_mail), label: 'Contact Us'),
        ],
      ),
    );
  }
}

//////////////////// HOME TAB ////////////////////
class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  DateTime? _selectedDate;
  String _ageResult = "";

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _ageResult = _calculateAge(pickedDate);
      });
    }
  }

  String _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int years = today.year - birthDate.year;
    int months = today.month - birthDate.month;
    int days = today.day - birthDate.day;

    if (days < 0) {
      months--;
      days += DateUtils.getDaysInMonth(birthDate.year, birthDate.month);
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    return "You are $years years, $months months, and $days days old.";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome to AgeX Technologies Pvt. Ltd",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Our Objective:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "At AgeX Technologies, we aim to simplify your daily life with smart tools. "
                "Our flagship Age Calculator App provides accurate, quick, and reliable results "
                "to help users calculate their age, countdowns, and milestones efficiently.",
          ),
          const SizedBox(height: 20),
          const Text(
            "Why Choose Us?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Text(
            "• Fast & Accurate Results\n"
                "• User-friendly Interface\n"
                "• Secure & Privacy-Focused\n"
                "• Cross-Platform Availability\n"
                "• Excellent Customer Support",
          ),
          const SizedBox(height: 30),
          const Divider(thickness: 2),
          const SizedBox(height: 20),
          const Text(
            "🎉 Try Our Age Calculator Demo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => _pickDate(context),
              icon: const Icon(Icons.calendar_today),
              label: const Text("Select Your Birth Date"),
            ),
          ),
          const SizedBox(height: 20),
          if (_selectedDate != null)
            Center(
              child: Column(
                children: [
                  Text(
                    "Selected Date: ${DateFormat('dd MMM yyyy').format(_selectedDate!)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _ageResult,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

//////////////////// ABOUT TAB ////////////////////
class AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Our Team", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TeamMember(name: "Abhishektha", role: "CEO", image: "assets/ceo.jpg"),
        TeamMember(name: "Afroz", role: "CTO", image: "assets/cto.jpg"),
        TeamMember(name: "Upasana", role: "COO", image: "assets/coo.jpg"),
        TeamMember(name: "Deepika", role: "Developer", image: "assets/dev.jpg"),
      ],
    );
  }
}

class TeamMember extends StatelessWidget {
  final String name, role, image;
  const TeamMember({required this.name, required this.role, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(image)),
        title: Text(name),
        subtitle: Text(role),
      ),
    );
  }
}

//////////////////// SERVICES TAB ////////////////////
class ServicesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Our Services", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("• Age Calculator App Development\n"
              "• Mobile App Customization\n"
              "• Data Analytics for Age-based Insights\n"
              "• Cloud Integration and Backup Solutions\n"
              "• 24/7 Technical Support\n"),
        ],
      ),
    );
  }
}

//////////////////// NOTIFICATIONS TAB ////////////////////
class NotificationsTab extends StatelessWidget {
  final List<String> notifications = const [
    "Version 2.0 Released with new UI!",
    "Now available on iOS platform.",
    "Added new Age Difference Calculator feature.",
    "Scheduled maintenance on Oct 20, 2025.",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.notifications_active, color: Colors.blue),
          title: Text(notifications[index]),
        );
      },
    );
  }
}

//////////////////// CONTACT TAB ////////////////////
class ContactTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Contact Us", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("📍 Address: AgeX Technologies Pvt. Ltd,\n"
              "123 Tech Park, Hyderabad, India"),
          SizedBox(height: 10),
          Text("📞 Phone: +91 9876543210"),
          SizedBox(height: 10),
          Text("✉️ Email: contact@agextech.com"),
          SizedBox(height: 10),
          Text("🌐 Website: www.agextech.com"),
          SizedBox(height: 20),
          Text("Google Map (Static Preview Below):"),
          SizedBox(height: 10),
          Image(
            image: AssetImage('assets/map.jpg'),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
