import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../widgets/neon_button.dart';
import '../models/contest.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';

class ContestsPage extends StatefulWidget {
  const ContestsPage({super.key});

  @override
  State<ContestsPage> createState() => _ContestsPageState();
}

class _ContestsPageState extends State<ContestsPage> {
  final ApiService _apiService = ApiService();
  List<Contest> _contests = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadContests();
  }

  Future<void> _loadContests() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _apiService.getContests();
      setState(() {
        _contests = response.contests;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Live Contests',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Orbitron',
                color: AppTheme.cyberGreen,
              ),
            ),
            if (!_isLoading && _contests.isNotEmpty)
              Text(
                'Total: ${_contests.length}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
          ],
        ),
        const SizedBox(height: 24),
        
        if (_isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.cyberGreen),
              ),
            ),
          )
        else if (_error != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Text(
                    'Error loading contests',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  NeonButton(
                    text: 'Retry',
                    onPressed: _loadContests,
                  ),
                ],
              ),
            ),
          )
        else if (_contests.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'No contests available',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          )
        else
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadContests,
              color: AppTheme.cyberGreen,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: _contests.length,
                itemBuilder: (context, index) {
                  return _ContestCard(
                    contest: _contests[index],
                    onJoin: () => _showJoinDialog(_contests[index]),
                    onViewDetails: () => _showDetailsDialog(_contests[index]),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  void _showJoinDialog(Contest contest) {
    showDialog(
      context: context,
      builder: (context) => _JoinContestDialog(contest: contest),
    );
  }

  void _showDetailsDialog(Contest contest) {
    showDialog(
      context: context,
      builder: (context) => _ContestDetailsDialog(contest: contest),
    );
  }
}

class _ContestCard extends StatelessWidget {
  final Contest contest;
  final VoidCallback onJoin;
  final VoidCallback onViewDetails;

  const _ContestCard({
    required this.contest,
    required this.onJoin,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      glowEffect: contest.isActive,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contest.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orbitron',
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      contest.stakeAmountInEth,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.cyberGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.people, size: 16, color: Colors.grey[400]),
              const SizedBox(width: 4),
              Text(
                '${contest.participantCount}',
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
              const SizedBox(width: 16),
              Icon(Icons.timer, size: 16, color: Colors.grey[400]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  contest.isActive ? 'Active' : 'Ended',
                  style: TextStyle(
                    fontSize: 12,
                    color: contest.isActive ? AppTheme.cyberGreen : Colors.red,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: NeonButton(
                  text: 'Join',
                  icon: Icons.play_arrow,
                  onPressed: onJoin,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: NeonButton(
                  text: 'Details',
                  variant: NeonButtonVariant.secondary,
                  onPressed: onViewDetails,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _JoinContestDialog extends StatelessWidget {
  final Contest contest;

  const _JoinContestDialog({required this.contest});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Join Contest',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Orbitron',
                color: AppTheme.cyberGreen,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              contest.name,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Stake Amount: ${contest.stakeAmountInEth}',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.cyberGreen,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: NeonButton(
                    text: 'Cancel',
                    variant: NeonButtonVariant.secondary,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NeonButton(
                    text: 'Confirm',
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Join contest functionality coming soon!'),
                          backgroundColor: AppTheme.cyberGreen,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContestDetailsDialog extends StatelessWidget {
  final Contest contest;

  const _ContestDetailsDialog({required this.contest});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassCard(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                contest.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Orbitron',
                  color: AppTheme.cyberGreen,
                ),
              ),
              const SizedBox(height: 16),
              _DetailRow('Stake', contest.stakeAmountInEth),
              _DetailRow('Participants', '${contest.participantCount}/${contest.maxParticipants}'),
              _DetailRow('Status', contest.isActive ? 'Active' : 'Ended'),
              const SizedBox(height: 24),
              NeonButton(
                text: 'Close',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[400]),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppTheme.cyberGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

