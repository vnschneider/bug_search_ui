class SearchResults {
  final String title;
  final String description;
  final String url;

  SearchResults({
    required this.title,
    required this.description,
    required this.url,
  });



  final List<SearchResults> _searchResults = [
    SearchResults(
        title: 'Site1',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla',
        url: 'example.com'),
    SearchResults(
        title: 'Site2',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla',
        url: 'example.com'),
    SearchResults(
        title: 'Site3',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla',
        url: 'example.com'),
    SearchResults(
        title: 'Site4',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla',
        url: 'example.com'),
    SearchResults(
        title: 'Site5',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla',
        url: 'example.com'),
    SearchResults(
        title: 'Site6',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla',
        url: 'example.com'),
    SearchResults(
        title: 'Site7',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla',
        url: 'example.com'),
    SearchResults(
        title: 'Site8',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla',
        url: 'example.com'),
  ];
}
