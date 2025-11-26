import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/presentation/Sources/source_name.dart';

import '../../../api/models/sources.dart';
import '../../../config/dependecy_injection/di.dart';
import '../News/Bloc/news_bloc.dart';
import '../News/Bloc/news_event.dart';
import '../News/news_widget.dart';

class SourceTabWidget extends StatefulWidget {
  final List<Sources> sourcesList;
  final String searchQuery;

  const SourceTabWidget(
      {super.key, required this.sourcesList, this.searchQuery = ""});

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            isScrollable: true,
            indicatorColor: Theme.of(context).primaryColor,
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            tabs: widget.sourcesList.map(
              (source) {
                return SourceName(
                  source: source,
                  isSelected:
                      selectedIndex == widget.sourcesList.indexOf(source),
                );
              },
            ).toList(),
          ),
          SizedBox(height: height * 0.03),
          Expanded(
            child: BlocProvider(
              key: ValueKey(
                  selectedIndex), // <-- Add: Forces new BLoC instance per tab change
              create: (_) {
                final sourceId = widget.sourcesList[selectedIndex].id;
                print(
                    'DEBUG: Creating NewsBloc for sourceId: $sourceId'); // <-- Add: Confirm sourceId
                if (sourceId == null || sourceId.isEmpty) {
                  print(
                      'ERROR: sourceId is null/empty for index $selectedIndex'); // <-- Add: Alert if null
                }
                return getIt<NewsBloc>()
                  ..add(GetNewsEvent(sourceId ?? '', page: 1));
              },
              child: NewsWidget(
                source: widget.sourcesList[selectedIndex],
                searchQuery: widget.searchQuery,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
