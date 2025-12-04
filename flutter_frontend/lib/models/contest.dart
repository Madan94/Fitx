class Contest {
  final int id;
  final String name;
  final String stakeAmount;
  final String startTime;
  final String endTime;
  final String maxParticipants;
  final String minParticipants;
  final bool rewardsDistributed;
  final int participantCount;
  final List<String> participants;
  final bool? isFallback;
  final bool? isMockData;

  Contest({
    required this.id,
    required this.name,
    required this.stakeAmount,
    required this.startTime,
    required this.endTime,
    required this.maxParticipants,
    required this.minParticipants,
    required this.rewardsDistributed,
    required this.participantCount,
    required this.participants,
    this.isFallback,
    this.isMockData,
  });

  factory Contest.fromJson(Map<String, dynamic> json) {
    return Contest(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      stakeAmount: json['stakeAmount']?.toString() ?? '0',
      startTime: json['startTime']?.toString() ?? '0',
      endTime: json['endTime']?.toString() ?? '0',
      maxParticipants: json['maxParticipants']?.toString() ?? '0',
      minParticipants: json['minParticipants']?.toString() ?? '0',
      rewardsDistributed: json['rewardsDistributed'] ?? false,
      participantCount: json['participantCount'] ?? 0,
      participants: List<String>.from(json['participants'] ?? []),
      isFallback: json['isFallback'],
      isMockData: json['isMockData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stakeAmount': stakeAmount,
      'startTime': startTime,
      'endTime': endTime,
      'maxParticipants': maxParticipants,
      'minParticipants': minParticipants,
      'rewardsDistributed': rewardsDistributed,
      'participantCount': participantCount,
      'participants': participants,
      'isFallback': isFallback,
      'isMockData': isMockData,
    };
  }

  String get stakeAmountInEth {
    try {
      final wei = BigInt.parse(stakeAmount);
      final eth = wei / BigInt.from(1000000000000000000);
      final remainder = wei % BigInt.from(1000000000000000000);
      final decimals = (remainder / BigInt.from(1000000000000000)).toInt();
      return '$eth.${decimals.toString().padLeft(3, '0')} CBTC';
    } catch (e) {
      return '0.000 CBTC';
    }
  }

  bool get isActive {
    try {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final start = int.parse(startTime);
      final end = int.parse(endTime);
      return now >= start && now <= end;
    } catch (e) {
      return false;
    }
  }

  bool get hasEnded {
    try {
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final end = int.parse(endTime);
      return now > end;
    } catch (e) {
      return false;
    }
  }
}

class ContestResponse {
  final List<Contest> contests;
  final String total;
  final String message;
  final bool? fallbackUsed;

  ContestResponse({
    required this.contests,
    required this.total,
    required this.message,
    this.fallbackUsed,
  });

  factory ContestResponse.fromJson(Map<String, dynamic> json) {
    return ContestResponse(
      contests: (json['contests'] as List<dynamic>?)
              ?.map((e) => Contest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      total: json['total']?.toString() ?? '0',
      message: json['message'] ?? '',
      fallbackUsed: json['fallbackUsed'],
    );
  }
}

