import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;
import '../models/news_model.dart';

class NewsCard extends StatefulWidget {
  final NewsArticle article;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final bool isFavorite;

  const NewsCard({
    Key? key,
    required this.article,
    required this.onTap,
    required this.onFavorite,
    required this.isFavorite,
  }) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final _random = math.Random();
  double _tiltX = 0;
  double _tiltY = 0;

  // List of placeholder images with their copyright information
  final List<Map<String, String>> _placeholderImages = [
    {
      'url': 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=800',
      'copyright': 'Photo by AbsolutVision on Unsplash',
      'category': 'News'
    },
    {
      'url': 'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=800',
      'copyright': 'Photo by Nick Fewings on Unsplash',
      'category': 'Newspaper'
    },
    {
      'url': 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',
      'copyright': 'Photo by Campaign Creators on Unsplash',
      'category': 'Technology'
    },
    {
      'url': 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=800',
      'copyright': 'Photo by Jannes Glas on Unsplash',
      'category': 'Sports'
    },
    {
      'url': 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=800',
      'copyright': 'Photo by National Cancer Institute on Unsplash',
      'category': 'Health'
    },
    {
      'url': 'https://images.unsplash.com/photo-1507413245164-6160d8298b31?w=800',
      'copyright': 'Photo by ThisisEngineering RAEng on Unsplash',
      'category': 'Science'
    },
  ];

  Map<String, String> get _randomPlaceholderImage {
    return _placeholderImages[_random.nextInt(_placeholderImages.length)];
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleFavorite() {
    if (!widget.isFavorite) {
      _controller.forward().then((_) => _controller.reverse());
    }
    widget.onFavorite();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _tiltX += details.delta.dx * 0.01;
      _tiltY += details.delta.dy * 0.01;
      _tiltX = _tiltX.clamp(-0.1, 0.1);
      _tiltY = _tiltY.clamp(-0.1, 0.1);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _tiltX = 0;
      _tiltY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_tiltY)
          ..rotateY(_tiltX),
        alignment: Alignment.center,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'news_image_${widget.article.url}',
                        child: CachedNetworkImage(
                          imageUrl: widget.article.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 200,
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                  Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _getCategoryIcon(widget.article.source),
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.article.source,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Copyright notice overlay
                      if (widget.article.imageUrl.isEmpty)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Text(
                              _randomPlaceholderImage['copyright']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      // Favorite button
                      Positioned(
                        top: 12,
                        right: 12,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Material(
                            color: Colors.white.withOpacity(0.85),
                            shape: const CircleBorder(),
                            elevation: 2,
                            child: IconButton(
                              icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (Widget child, Animation<double> animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Icon(
                                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                                  key: ValueKey<bool>(widget.isFavorite),
                                  color: widget.isFavorite ? Colors.red : Colors.grey,
                                  size: 28,
                                ),
                              ),
                              onPressed: _handleFavorite,
                              color: widget.isFavorite ? Colors.red : Colors.grey,
                              splashRadius: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.article.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[800],
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.public,
                                size: 16,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.article.source,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.secondary,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                DateFormat('MMM dd, yyyy').format(
                                  DateTime.parse(widget.article.publishedAt),
                                ),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String source) {
    // Map common news sources to appropriate icons
    final sourceLower = source.toLowerCase();
    if (sourceLower.contains('tech') || sourceLower.contains('digital')) {
      return Icons.computer;
    } else if (sourceLower.contains('sport')) {
      return Icons.sports;
    } else if (sourceLower.contains('business') || sourceLower.contains('finance')) {
      return Icons.business;
    } else if (sourceLower.contains('entertainment') || sourceLower.contains('movie')) {
      return Icons.movie;
    } else if (sourceLower.contains('health') || sourceLower.contains('medical')) {
      return Icons.health_and_safety;
    } else if (sourceLower.contains('science')) {
      return Icons.science;
    } else {
      return Icons.article;
    }
  }
}