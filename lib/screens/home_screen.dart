import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holy_rosarie/models/mystery.dart';
import 'package:holy_rosarie/providers/mystery_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MysteryListScreen(),
    );
  }
}

class MysteryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF5F5DC), // Beige clair
            Color(0xFFDEB887), // Beige intermédiaire
            Color(0xFFD2B48C), // Beige foncé
          ],
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          stops: [0.0, 0.0, 0.1],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFFDEB887),
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Saint Rosaire',
                textScaleFactor: 1.2,
                textWidthBasis: TextWidthBasis.parent,
                textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF5F5DC), // Beige clair
                      Color(0xFFDEB887), // Beige intermédiaire
                      Color(0xFFD2B48C), // Beige foncé
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.5, 1.0],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border(
                    bottom: BorderSide(width: 1),
                  ),
                ),
              ),
            ),
          ),
          Consumer<MysteryProvider>(
            builder: (context, mysteryProvider, child) {
              if (mysteryProvider.mysteries.isEmpty) {
                mysteryProvider.loadMysteries();
                return const SliverFillRemaining(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    final mystery = mysteryProvider.mysteries[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(mystery: mystery),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              width: 140.0,
                              height: 200,
                              child: Image.asset(
                                mystery.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(
                                      mystery.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      mystery.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                  childCount: mysteryProvider.mysteries.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Mystery mystery;

  DetailScreen({required this.mystery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mystery.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mystery.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              mystery.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MysteryScreen(mystery: mystery),
                  ),
                );
              },
              child: Text('Continuer avec le Mystère'),
            ),
          ],
        ),
      ),
    );
  }
}
class IntroductionScreen extends StatelessWidget {
  final List<Prayer> prayers;

  IntroductionScreen({required this.prayers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introduction'),
      ),
      body: ListView.builder(
        itemCount: prayers.length,
        itemBuilder: (context, index) {
          final prayer = prayers[index];
          return ListTile(
            title: Text(prayer.title),
            subtitle: Text(prayer.text),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MysteryListScreen(),
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class Prayer {
  final String title;
  final String text;

  Prayer({required this.title, required this.text});
}
class MysteryScreen extends StatefulWidget {
  final Mystery mystery;

  MysteryScreen({required this.mystery});

  @override
  State<MysteryScreen> createState() => _MysteryScreenState();
}

class _MysteryScreenState extends State<MysteryScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final PageController _pageController = PageController();
  final PageController _dockController = PageController(viewportFraction: 0.2);
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _pageController.dispose();
    _dockController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageController.page != null &&
        _pageController.page! < widget.mystery.meditations.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_pageController.page != null && _pageController.page! > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mystery.title),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF5F5DC), // Beige clair
                  Color(0xFFDEB887), // Beige intermédiaire
                  Color(0xFFD2B48C), // Beige foncé
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            height: 80,
            child: PageView.builder(
              controller: _dockController,
              itemCount: widget.mystery.meditations.length,
              itemBuilder: (context, index) {
                final meditation = widget.mystery.meditations[index];

                return DockItem(
                  title: meditation.title,
                  index: index.toDouble(),
                  pageController: _pageController,
                );
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.mystery.meditations.length,
              itemBuilder: (context, index) {
                final meditation = widget.mystery.meditations[index];

                return SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFF5F5DC), // Beige clair
                          Color(0xFFDEB887), // Beige intermédiaire
                          Color(0xFFD2B48C), // Beige foncé
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            meditation.title,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            meditation.description,
                          ),
                          SizedBox(height: 20),
                          if (meditation.audioPath != null)
                            ListTile(
                              title: Text('Écouter l\'audio'),
                              leading: Icon(
                                  _isPlaying ? Icons.pause : Icons.play_arrow),
                              onTap: () async {
                                if (_isPlaying) {
                                  await _audioPlayer.pause();
                                } else {
                                  try {
                                    await _audioPlayer.setSource(
                                        AssetSource(meditation.audioPath!));
                                    await _audioPlayer.resume();
                                  } catch (e) {
                                    print('Error playing audio: $e');
                                  }
                                }
                                setState(() {
                                  _isPlaying = !_isPlaying;
                                });
                              },
                            ),
                          SizedBox(height: 20),
                          ...meditation.postMysteryPrayers.map((prayer) => ListTile(
                            title: Text(prayer.title),
                            subtitle: Text(prayer.text),
                            onTap: () async {
                              // await _audioPlayer.play(AssetSource(prayer.audioPath!));
                            },
                          )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousPage,
                  child: Text('Précédent'),
                ),
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text('Suivant'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class DockItem extends StatefulWidget {
  final String title;
  final double index; // Index pour les calculs d'animation
  final PageController pageController; // Contrôleur de page pour obtenir la page actuelle

  DockItem({
    required this.title,
    required this.index,
    required this.pageController,
  });

  @override
  _DockItemState createState() => _DockItemState();
}

class _DockItemState extends State<DockItem> {
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentPage = widget.pageController.page ?? widget.index;
      });
    });
    widget.pageController.addListener(_updatePage);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_updatePage);
    super.dispose();
  }

  void _updatePage() {
    if (widget.pageController.hasClients) {
      setState(() {
        _currentPage = widget.pageController.page ?? widget.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double difference = (_currentPage - widget.index).abs();
    double scale = 1 - (difference * 0.3).clamp(0.0, 0.3);
    double opacity = 1 - (difference * 0.3).clamp(0.0, 0.3);

    return Center(
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 150,
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
