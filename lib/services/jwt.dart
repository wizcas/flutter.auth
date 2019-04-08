import 'dart:convert';

class JWT {
  final String token;
  Map<String, dynamic> _payload;
  JWT(this.token) {
    final segments = this.token.split('.');
    if (segments.length < 2) {
      throw ('Invalid token (too few information)');
    }
    final dataParts = segments.sublist(0, 2).map((String raw) {
      final equalCount = (raw.length % 4 == 0) ? 0 : (4 - raw.length % 4);
      for (var i = 0; i < equalCount; i++) {
        raw += '=';
      }
      return json.decode(utf8.decode(base64.decode(raw)));
    }).toList();
    if (!dataParts[0].containsKey('typ') || dataParts[0]['typ'] != 'JWT') {
      throw ('Invalid token (unknown type)');
    }
    _payload = dataParts[1];
    if (_payload == null) {
      throw ('Invalid token (empty)');
    }
  }

  bool get isExpired {
    if (!_payload.containsKey('exp')) {
      return false; // Never expires if 'exp' field absent
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    return _payload['exp'] < now;
  }

  String get aud {
    return _payload['aud'];
  }

  @override
  String toString() {
    final payloadInfo = _payload.entries
        .map((entry) => '${entry.key}:\t${entry.value}')
        .join('\n\t');
    return '<JWT> =============>\n\t$payloadInfo\n<=============';
  }
}
