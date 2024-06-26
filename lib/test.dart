import "package:fast_app_base/common/common.dart";
import "package:fast_app_base/common/util/provider_util.dart";
import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";
import "package:provider/provider.dart";

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 136, bottom: 92),
      color: Vx.white,
      child: Column(
        children: [
          Expanded(
            child: Consumer<SearchResultProvider>(
              builder: (context, provider, child) {
                return FutureBuilder<List<Map>>(
                  future: provider.searchResult,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!
                              .map((item) => Html(
                                      data: "<h1>${item["roomName"]}<br>${item["useDate"].toString().replaceAll("<br>", " ")}<br>${item["description"]}",
                                      style: {
                                        'h1': Style(
                                          color: Vx.gray500,
                                          fontSize: FontSize(14),
                                        ),
                                      }))
                              .toList(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
