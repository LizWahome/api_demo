import 'package:api_demo/presentation/dashboard/state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _refreshkey = GlobalKey<RefreshIndicatorState>();

  int _page = 1;
  int get page => _page;

  _increment() => setState(() => _page++);
  _decrement() => setState(() => _page--);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _refreshkey.currentState!.show());
  }

  @override
  Widget build(BuildContext context) {
    final watcher = context.watch<DashboardProvider>();
    final reader = context.read<DashboardProvider>();
    //final loginProvider = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: RefreshIndicator(
          key: _refreshkey,
          onRefresh: () async => await reader.reqListOfUsers(page),
          child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                tileColor: Colors.grey[200],
                title: Text("${reader.listOfUsers?.data?[index].firstName} ${reader.listOfUsers?.data?[index].lastName}"),
                subtitle: Text("${reader.listOfUsers?.data?[index].email}"),
              ),
              separatorBuilder: (context, index) => 12.height,
              itemCount: watcher.users == -1 ? 0 : watcher.users),
        ),
      ),
      bottomSheet: watcher.listOfUsers != null
          ? Container(
            height: 40,
            color: Colors.white,
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: watcher.listOfUsers?.page == 1
                          ? null
                          : () {
                              _decrement();
                              _refreshkey.currentState!.show();
                            },
                      icon: const Icon(Icons.chevron_left)),
                  8.width,
                  Text("${watcher.listOfUsers?.page ?? ''}"),
                  8.width,
                  const Text("/"),
                  8.width,
                  Text("${watcher.listOfUsers?.totalPages ?? ''}"),
                  8.width,
                  IconButton(
                      onPressed: watcher.listOfUsers?.page == watcher.listOfUsers?.totalPages
                          ? null
                          : () {
                              _increment();
                              _refreshkey.currentState!.show();
                            }, icon: const Icon(Icons.chevron_right)),
                ],
              ),
            )
          : null,
    );
  }
}
