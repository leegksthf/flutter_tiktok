import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoplay: _repository.isAutoPlay(),
    darkmode: _repository.isDarkMode(),
  );

  PlaybackConfigViewModel(this._repository);

  bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;
  bool get darkmode => _model.darkmode;

  void setMuted(bool value) {
    _repository.setMuted(value);
    _model.muted = value;
    notifyListeners();
  }

  void setAutoplay(bool value) {
    _repository.setAutoPlay(value);
    _model.autoplay = value;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    _model.darkmode = value;
    notifyListeners();
  }
}
