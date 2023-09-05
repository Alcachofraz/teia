import 'package:teia/models/chapter_graph.dart';

class Chapter {
  int id;
  String storyId;
  String title;

  /// Indicates which pages are connected schematically.
  ChapterGraph graph;

  /// Indicates which pages are connected logically (by links).
  ChapterGraph links;

  Chapter(
    this.id,
    this.storyId,
    this.title,
    this.graph,
    this.links,
  );

  factory Chapter.create(int id, String storyId, String title, String uid) {
    return Chapter(
      id,
      storyId,
      title,
      ChapterGraph({1: []}),
      ChapterGraph({1: []}),
    );
  }

  factory Chapter.empty() {
    return Chapter(
      -1,
      'Story ID',
      'Title',
      ChapterGraph({1: []}),
      ChapterGraph({1: []}),
    );
  }

  /// Map Page constructor. Instantiate a page from a
  /// Map<String, dynamic> object.
  factory Chapter.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return Chapter(
        -1,
        '',
        '',
        ChapterGraph.empty(),
        ChapterGraph.empty(),
      );
    }
    return Chapter(
      map['id'] as int,
      map['storyId'] as String,
      map['title'] as String,
      ChapterGraph.fromMap(Map<String, dynamic>.from(map['graph']).map(
          (key, value) => MapEntry(int.parse(key), List<int>.from(value)))),
      ChapterGraph.fromMap(Map<String, dynamic>.from(map['links']).map(
          (key, value) => MapEntry(int.parse(key), List<int>.from(value)))),
    );
  }

  /// Create a new page.
  /// * [id] parent id.
  /// Returns the id of the child.
  int addPage(int id, {String? uid}) {
    int newId = graph.numberOfPages() + 1;
    graph.addConnection(id, newId);
    return newId;
  }

  /// Add link to a page. If [childId] isn't, a new page is created.
  /// * [id] parent id.
  /// Returns the id of the child.
  int addLink(int id, {int? childId, String? uid}) {
    childId ??= addPage(id, uid: uid);
    links.addConnection(id, childId);
    return childId;
  }

  /// Connect page [from] to [to].
  bool connectPages(int from, int to) {
    return graph.addConnection(from, to);
  }

  /// Check if page is last in chapter.
  /// * [id] page id.
  bool isFinalPage(int id) {
    return graph.isLeaf(id);
  }

  /// Convert this chapter to a Map<String, dynamic> object.
  Map<String, dynamic> toMap() => {
        'id': id,
        'storyId': storyId,
        'title': title,
        'graph': graph.nodes,
        'links': links.nodes
      };

  @override
  String toString() => toMap().toString();
}