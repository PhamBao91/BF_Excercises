import 'dart:math';

import 'package:api_base/pages/videos/video_model.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';


class PlayAudioWidget extends StatefulWidget {
  final VideoModel videoModel;
  final AudioPlayer audioPlayer;

  const PlayAudioWidget({Key key, this.videoModel, this.audioPlayer}) : super(key: key);
  @override
  _PlayAudioWidgetState createState() => _PlayAudioWidgetState();
}

class _PlayAudioWidgetState extends State<PlayAudioWidget> {

  ConcatenatingAudioSource _playlist;


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));

    _playlist = ConcatenatingAudioSource(children: [

      AudioSource.uri(
        Uri.parse(
            widget.videoModel.url_video),
        tag: AudioMetadata(
          group_name: widget.videoModel.name_category.toUpperCase(),
          title: widget.videoModel.title,
          cover_image:
          widget.videoModel.url_photo,
        ),
      ),

    ]);
    _init();
  }

  _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await widget.audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      // catch load errors: 404, invalid url ...
      print("An error occured $e");
    }
  }

  @override
  void dispose() {
    _playlist = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder<SequenceState>(
                  stream: widget.audioPlayer.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence?.isEmpty ?? true) return SizedBox();
                    final audioFile = state.currentSource.tag as AudioMetadata;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            Center(child: Image.network(audioFile.cover_image)),
                          ),
                        ),
                        Text(audioFile.group_name ?? '',
                            style: Theme.of(context).textTheme.headline6),
                        Text(audioFile.title ?? ''),
                      ],
                    );
                  },
                ),
              ),
              ControlButtons(widget.audioPlayer),
              StreamBuilder<Duration>(
                stream: widget.audioPlayer.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: widget.audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return SeekBar(
                        duration: duration,
                        position: position,
                        onChangeEnd: (newPosition) {
                          widget.audioPlayer.seek(newPosition);
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 8.0),

            ],
          ),
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            _showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        StreamBuilder<SequenceState>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero,
                    index: player.effectiveIndices.first),
              );
            }
          },
        ),
        StreamBuilder<SequenceState>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              _showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double _dragValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Slider(
          min: 0.0,
          max: widget.duration.inMilliseconds.toDouble(),
          value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
              widget.duration.inMilliseconds.toDouble()),
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
            if (widget.onChanged != null) {
              widget.onChanged(Duration(milliseconds: value.round()));
            }
          },
          onChangeEnd: (value) {
            if (widget.onChangeEnd != null) {
              widget.onChangeEnd(Duration(milliseconds: value.round()));
            }
            _dragValue = null;
          },
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                  .firstMatch("$_remaining")
                  ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

_showSliderDialog({
  BuildContext context,
  String title,
  int divisions,
  double min,
  double max,
  String valueSuffix = '',
  Stream<double> stream,
  ValueChanged<double> onChanged,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AudioMetadata {
  final String group_name;
  final String title;
  final String cover_image;

  AudioMetadata({this.group_name, this.title, this.cover_image});
}