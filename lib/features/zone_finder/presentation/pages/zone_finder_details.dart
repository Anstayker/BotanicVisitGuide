import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/zone_data.dart';

class ZoneFinderDetailsArgs {
  final ZoneData zoneData;
  final List<String>? imageUrls;
  final String? audioUrl;

  ZoneFinderDetailsArgs(
      {required this.zoneData,
      required this.imageUrls,
      required this.audioUrl});
}

class ZoneFinderDetailsPage extends StatefulWidget {
  const ZoneFinderDetailsPage({super.key, required this.args});

  final ZoneFinderDetailsArgs args;

  @override
  State<ZoneFinderDetailsPage> createState() => _ZoneFinderDetailsPageState();
}

class _ZoneFinderDetailsPageState extends State<ZoneFinderDetailsPage> {
  late AudioPlayer audioPlayer;
  bool _isPlaying = false;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<void>? _playerFinishedPlayingSubscription;
  Duration _audioDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _audioDuration = duration;
      });
    });
    _playerFinishedPlayingSubscription =
        audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _currentPosition = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerFinishedPlayingSubscription?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zoneData = widget.args.zoneData;

    final List<IconData> icons = [
      Icons.forest,
      Icons.forest_rounded,
      Icons.forest_outlined,
    ];

    final List<Color> colors = [
      Colors.green,
      Colors.blue,
      Colors.red,
    ];

    final imageUrls = widget.args.imageUrls;

    final List<Widget> imagesOrIcons = imageUrls != null && imageUrls.isNotEmpty
        ? imageUrls.map((url) => Image.network(url)).toList()
        : icons.map((icon) => Icon(icon)).toList();

    String notificationLongText = '${zoneData.zoneDescription}';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          imagenCarusel(imagesOrIcons, colors),
          Expanded(
              child: SingleChildScrollView(
                  child: notificationDescription(notificationLongText)))
        ],
      ),
      bottomNavigationBar: bottomAppBar(),
    );
  }

  Widget bottomAppBar() {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 64.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              reproducerText(formatDuration(_currentPosition)),
              Expanded(
                child: Slider(
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  value: _currentPosition.inSeconds.toDouble(),
                  min: 0,
                  max: _audioDuration.inSeconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
                  },
                ),
              ),
              reproducerText(formatDuration(_audioDuration)),
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors
                      .white, // Asegura que el color del ícono siempre sea blanco
                ),
                onPressed: () async {
                  if (widget.args.audioUrl != null &&
                      widget.args.audioUrl!.isNotEmpty) {
                    if (_isPlaying) {
                      audioPlayer.pause();
                    } else {
                      await audioPlayer.play(UrlSource(widget.args.audioUrl!));
                    }
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  } else {
                    // Opcional: Muestra un mensaje al usuario si la URL del audio es null o vacía
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('No hay audio para reproducir')),
                    );
                  }
                }, //
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reproducerText(String text) {
    return Text(text, style: const TextStyle(color: Colors.white));
  }

  Widget notificationDescription(String longText) {
    return Column(
      children: [
        notificationTitle(),
        textoMuyLargo(longText),
        textoMuyLargo(longText),
      ],
    );
  }

  Widget textoMuyLargo(String longText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Text(
        longText,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget notificationTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre de la zona',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Nombre de la planta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          FloatingActionButton(
            onPressed: () async {
              if (widget.args.audioUrl != null &&
                  widget.args.audioUrl!.isNotEmpty) {
                if (_isPlaying) {
                  audioPlayer.pause();
                } else {
                  await audioPlayer.play(UrlSource(widget.args.audioUrl!));
                }
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              } else {
                // Opcional: Muestra un mensaje al usuario si la URL del audio es null o vacía
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No hay audio para reproducir')),
                );
              }
            }, // Icono del botón
            backgroundColor: Colors.black,
            child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow), // Color del botón
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget imagenCarusel(List<Widget> widgets, List<Color> colors) {
    return Expanded(
      child: Container(
        color: Colors.grey[100],
        child: PageView.builder(
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return Center(
              child: widgets[index], // Usar el widget directamente
            );
          },
        ),
      ),
    );
  }
}
