import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_info/database/models/character_list.model.dart';
import 'package:rick_and_morty_info/database/models/profile.model.dart';
import 'package:rick_and_morty_info/gate/api.dart';
import 'package:rick_and_morty_info/pages/widgets/person_card.dart';

class AllCharactersPage extends StatefulWidget {
  const AllCharactersPage({super.key});

  @override
  State<AllCharactersPage> createState() => _AllCharactersPageState();
}

class _AllCharactersPageState extends State<AllCharactersPage> {
  final ScrollController _scrollController = ScrollController();

  late List<ProfileModel> _profiles = [];
  int _pageNumber = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadMore();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadFromCache() async {
    final box = Hive.box<ProfileModel>('all_characters');
    setState(() {
      _profiles = box.values.toList()
        ..sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
      _hasMore = false;
    });
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;
    setState(() {
      _isLoading = true;
    });
    try {
      CharacterListModel characterList = await Api().getCards(page: _pageNumber);
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _profiles = [..._profiles, ...?characterList.results];
        _pageNumber = _pageNumber+1;
        if (characterList.info == null || characterList.info!.count == null) {
          _hasMore = false;
          return;
        }

        if (_profiles.length >= characterList.info!.count!) {
          _hasMore = false;
        }
      });
    } catch (e) {
      // Нет интернета
      if (_profiles.isEmpty) {
        await _loadFromCache();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Персонажи Рик и Морти'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _profiles.clear();
            _hasMore = true;
          });
          await _loadMore();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.6, // квадратные карточки
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index < _profiles.length) {
                      return PersonCard(profile: _profiles[index]);
                    }

                    // лоадер внизу
                    return _isLoading || _hasMore
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Больше нет",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                  childCount: _profiles.length + (_isLoading || _hasMore ? 1 : 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

