import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theft_detecting_system/features/all_widgets/custom_appbar.dart';
import 'package:theft_detecting_system/features/auth/presentation/providers/auth_provider.dart';
import 'package:theft_detecting_system/features/auth/presentation/pages/authentication_page.dart';
import 'package:theft_detecting_system/features/home/presentation/widgets/custom_drawer.dart';

class AccountPage extends StatefulWidget {
  static final String routeName = '/account';
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _allMotionAlert = false;
  bool _timeBasedAlert = false;
  bool _soundAlert = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().getCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Account Settings'),
      drawer: CustomDrawer(),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          // Redirect to authentication if not logged in
          if (!authProvider.isAuthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, AuthenticationPage.routeName);
            });
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Account Information Card
                Card(
                  color: Colors.white.withAlpha(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: authProvider.user?.photoUrl != null
                                  ? NetworkImage(authProvider.user!.photoUrl!)
                                  : const AssetImage('assets/placeholder.png') as ImageProvider,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    authProvider.user?.name ?? "User",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    authProvider.user?.email ?? "user@example.com",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: authProvider.isLoading
                                ? null
                                : () async {
                                    await authProvider.signOut();
                                    if (!authProvider.isAuthenticated) {
                                      Navigator.pushReplacementNamed(
                                          context, AuthenticationPage.routeName);
                                    }
                                  },
                            child: authProvider.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Logout",
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Error message
                if (authProvider.error != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Text(
                      authProvider.error!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),
            // Device Management Card
            Card(
              color: Colors.white.withAlpha(30),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Device Management",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Working Cameras Online",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "Camera 1",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Handle camera tap if needed.
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Test connection logic goes here.
                        },
                        child: const Text(
                          "Test Connection",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Notification Preference Card
            Card(
              color: Colors.white.withAlpha(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification Preferences",
                      style: TextStyle(color: Colors.white),
                    ),
                    // All Motion Alert
                    ListTile(
                      title: const Text(
                        "All Motion Alert",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8, // Adjust the scale to make it smaller.
                        child: Switch(
                          value: _allMotionAlert,
                          onChanged: (bool value) {
                            setState(() {
                              _allMotionAlert = value;
                            });
                          },
                        ),
                      ),
                    ),
                    // Time Based Alert
                    ListTile(
                      title: const Text(
                        "Time Based Alert",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _timeBasedAlert,
                          onChanged: (bool value) {
                            setState(() {
                              _timeBasedAlert = value;
                            });
                          },
                        ),
                      ),
                    ),
                    // Sound Alert
                    ListTile(
                      title: const Text(
                        "Sound Alert",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _soundAlert,
                          onChanged: (bool value) {
                            setState(() {
                              _soundAlert = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
        },
      ),
    );
  }
}
