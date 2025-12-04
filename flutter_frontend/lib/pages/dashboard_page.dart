import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../theme/app_theme.dart';
import '../constants/app_constants.dart';
import 'contests_page.dart';

enum DashboardTab {
  challenges,
  contests,
  betting,
  analytics,
  profile,
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardTab _activeTab = DashboardTab.challenges;
  bool _isSidebarOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isSidebarOpen ? 280 : 80,
            decoration: BoxDecoration(
              color: AppTheme.cyberBlack.withValues(alpha: 0.8),
              border: Border(
                right: BorderSide(
                  color: AppTheme.cyberGreen.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: _isSidebarOpen
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      if (_isSidebarOpen)
                        Text(
                          AppConstants.appName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Orbitron',
                            color: AppTheme.cyberGreen,
                          ),
                        ),
                      IconButton(
                        icon: Icon(
                          _isSidebarOpen ? Icons.close : Icons.menu,
                          color: AppTheme.cyberGreen,
                        ),
                        onPressed: () {
                          setState(() {
                            _isSidebarOpen = !_isSidebarOpen;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                
                // Navigation
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      _NavItem(
                        icon: Icons.track_changes,
                        label: 'AI Challenges',
                        isActive: _activeTab == DashboardTab.challenges,
                        isCollapsed: !_isSidebarOpen,
                        onTap: () {
                          setState(() {
                            _activeTab = DashboardTab.challenges;
                          });
                        },
                      ),
                      _NavItem(
                        icon: Icons.emoji_events,
                        label: 'Public Contests',
                        isActive: _activeTab == DashboardTab.contests,
                        isCollapsed: !_isSidebarOpen,
                        onTap: () {
                          setState(() {
                            _activeTab = DashboardTab.contests;
                          });
                        },
                      ),
                      _NavItem(
                        icon: Icons.attach_money,
                        label: 'Betting',
                        isActive: _activeTab == DashboardTab.betting,
                        isCollapsed: !_isSidebarOpen,
                        onTap: () {
                          setState(() {
                            _activeTab = DashboardTab.betting;
                          });
                        },
                      ),
                      _NavItem(
                        icon: Icons.bar_chart,
                        label: 'Analytics',
                        isActive: _activeTab == DashboardTab.analytics,
                        isCollapsed: !_isSidebarOpen,
                        onTap: () {
                          setState(() {
                            _activeTab = DashboardTab.analytics;
                          });
                        },
                      ),
                      _NavItem(
                        icon: Icons.person,
                        label: 'Profile',
                        isActive: _activeTab == DashboardTab.profile,
                        isCollapsed: !_isSidebarOpen,
                        onTap: () {
                          setState(() {
                            _activeTab = DashboardTab.profile;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                
                // Profile Card (simplified)
                Container(
                  padding: const EdgeInsets.all(16),
                  child: GlassCard(
                    padding: EdgeInsets.all(_isSidebarOpen ? 16 : 8),
                    child: Row(
                      mainAxisAlignment: _isSidebarOpen
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.cyberGreen,
                          child: const Icon(Icons.person, color: Colors.black),
                        ),
                        if (_isSidebarOpen) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '0x742d...',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.cyberBlack.withValues(alpha: 0.4),
                    border: Border(
                      bottom: BorderSide(
                        color: AppTheme.cyberGreen.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getTabName(_activeTab),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Orbitron',
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Welcome back',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.grey[400]),
                            onPressed: () {},
                          ),
                          Stack(
                            children: [
                              IconButton(
                                icon: Icon(Icons.notifications,
                                    color: Colors.grey[400]),
                                onPressed: () {},
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Content Area
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_activeTab) {
      case DashboardTab.challenges:
        return Center(
          child: Text(
            'AI Challenges',
            style: TextStyle(color: Colors.grey[400]),
          ),
        );
      case DashboardTab.contests:
        return const ContestsPage();
      case DashboardTab.betting:
        return Center(
          child: Text(
            'Betting',
            style: TextStyle(color: Colors.grey[400]),
          ),
        );
      case DashboardTab.analytics:
        return Center(
          child: Text(
            'Analytics',
            style: TextStyle(color: Colors.grey[400]),
          ),
        );
      case DashboardTab.profile:
        return Center(
          child: Text(
            'Profile',
            style: TextStyle(color: Colors.grey[400]),
          ),
        );
    }
  }

  String _getTabName(DashboardTab tab) {
    switch (tab) {
      case DashboardTab.challenges:
        return 'AI Challenges';
      case DashboardTab.contests:
        return 'Public Contests';
      case DashboardTab.betting:
        return 'Betting';
      case DashboardTab.analytics:
        return 'Analytics';
      case DashboardTab.profile:
        return 'Profile';
    }
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isCollapsed;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.isCollapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isActive
            ? AppTheme.cyberGreen.withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: isActive
                  ? Border.all(color: AppTheme.cyberGreen, width: 1)
                  : null,
            ),
            child: Row(
              mainAxisAlignment:
                  isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: isActive ? AppTheme.cyberGreen : Colors.grey[400],
                ),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      color: isActive ? AppTheme.cyberGreen : Colors.grey[400],
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

