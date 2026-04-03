// Flutter GraphQL — 公开 Countries API
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: GraphqlPage());
  }
}

class GraphqlPage extends StatefulWidget {
  const GraphqlPage({super.key});

  @override
  State<GraphqlPage> createState() => _GraphqlPageState();
}

class _GraphqlPageState extends State<GraphqlPage> {
  late final GraphQLClient _client;
  String _out = 'Loading…';

  @override
  void initState() {
    super.initState();
    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink('https://countries.trevorblades.com/graphql'),
    );
    _load();
  }

  Future<void> _load() async {
    const doc = r'''
      query Country($code: ID!) {
        country(code: $code) {
          name
          capital
        }
      }
    ''';
    final result = await _client.query(
      QueryOptions(
        document: gql(doc),
        variables: const {'code': 'JP'},
      ),
    );
    setState(() {
      if (result.hasException) {
        _out = result.exception.toString();
      } else {
        _out = result.data?.toString() ?? 'no data';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GraphQL')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SelectableText(_out),
      ),
    );
  }
}
