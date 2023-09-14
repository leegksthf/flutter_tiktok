import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  // repository에서 직접 가져올 수도 있지만, 매번 꺼내서 쓰는 것은 비효율적이기때문에 model에 한 번 초기화한 다음 매번 꺼내서 사용함. + 데이터 cache 해야 할 때도 필요. => provider
  // bool get muted => _model.muted;
  // bool get autoplay => _model.autoplay;
  // bool get darkmode => _model.darkmode;

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
        autoplay: state.autoplay, darkmode: state.darkmode, muted: value);
  }

  void setAutoplay(bool value) {
    _repository.setAutoPlay(value);
    state = PlaybackConfigModel(
        muted: state.muted, autoplay: value, darkmode: state.darkmode);
  }

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = PlaybackConfigModel(
        muted: state.muted, autoplay: state.autoplay, darkmode: value);
  }

  @override
  PlaybackConfigModel build() {
    // build 메서드에서는 state의 초기 데이터를 반환함.
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoPlay(),
      darkmode: _repository.isDarkMode(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
