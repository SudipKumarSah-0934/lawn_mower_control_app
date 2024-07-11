import 'package:flutter/material.dart';
import 'package:lawn_mower_control_app/engine_operation_screen.dart';
import 'package:lawn_mower_control_app/error_information_screen.dart';
import 'package:lawn_mower_control_app/machine_information_screen.dart';
import 'package:lawn_mower_control_app/machine_operating_screen.dart';
import 'package:lawn_mower_control_app/paswword_change_screen.dart';
import 'package:lawn_mower_control_app/setting_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isEngineStarted = false;

  void onEngineToggle(bool isStarted) {
    setState(() {
      isEngineStarted = isStarted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SettingScreen()),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            GridItem(
              icon: Icons.info,
              label: 'Machine Information Screen',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MachineInformationScreen()),
              ),
            ),
            GridItem(
              icon: Icons.error,
              label: 'Error Information Screen',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ErrorInformationScreen()),
              ),
            ),
            GridItem(
              icon: Icons.open_in_browser,
              label: 'Machine Operating Screen',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MachineOperatingScreen(),
                ),
              ),
            ),
            GridItem(
              icon: Icons.engineering,
              label: 'Engine Operation Screen',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EngineOperationScreen(
                    onEngineToggle: onEngineToggle,
                  ),
                ),
              ),
            ),
            GridItem(
              icon: Icons.password,
              label: 'Password Change Screen',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PasswordChangeScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  GridItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                label,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
