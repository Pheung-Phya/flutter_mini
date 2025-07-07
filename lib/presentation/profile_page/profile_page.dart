import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool _showAccountMenu = false;
  bool _showPrivacyMenu = false;
  bool _showGeneralMenu = false;

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
    );
  }

  Widget _buildExpandableTile({
    required String title,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: Colors.white,
          ),
          onTap: onTap,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child:
              isExpanded
                  ? Column(
                    children:
                        children.map((e) {
                          return Card(
                            color: Colors.white.withOpacity(0.2),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            child: e,
                          );
                        }).toList(),
                  )
                  : const SizedBox(),
        ),
        const Divider(color: Colors.white12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/'),
            ),
            const SizedBox(height: 20),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'johndoe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit, color: Colors.white),
                    title: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onTap: () {},
                  ),
                  const Divider(color: Colors.white12),

                  // ⚙️ Account Settings
                  _buildExpandableTile(
                    title: "Account Settings",
                    icon: Icons.person,
                    isExpanded: _showAccountMenu,
                    onTap: () {
                      setState(() => _showAccountMenu = !_showAccountMenu);
                    },
                    children: [
                      ListTile(
                        leading: const Icon(Icons.email, color: Colors.white),
                        title: const Text(
                          'Change Email',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.lock, color: Colors.white),
                        title: const Text(
                          'Change Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),

                  // 🔐 Privacy Settings
                  _buildExpandableTile(
                    title: "Privacy Settings",
                    icon: Icons.privacy_tip,
                    isExpanded: _showPrivacyMenu,
                    onTap: () {
                      setState(() => _showPrivacyMenu = !_showPrivacyMenu);
                    },
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.visibility_off,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Blocked Users',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.shield, color: Colors.white),
                        title: const Text(
                          'Security',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),

                  // 🌐 General Settings
                  _buildExpandableTile(
                    title: "General Settings",
                    icon: Icons.settings,
                    isExpanded: _showGeneralMenu,
                    onTap: () {
                      setState(() => _showGeneralMenu = !_showGeneralMenu);
                    },
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Language',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.dark_mode,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Theme',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: ElevatedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
