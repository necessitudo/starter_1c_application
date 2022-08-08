import 'package:fluent_ui/fluent_ui.dart';
import 'package:starter_1c_application/models/base_description.dart';
import 'package:starter_1c_application/services/bases_api.dart';
import 'package:starter_1c_application/widgets/base_item.dart';

class BasesListPage extends StatefulWidget {
  final List<BaseDescription> basesDescription;
  final BasesApi basesApi = const BasesApi();

  const BasesListPage({Key? key, required this.basesDescription})
      : super(key: key);

  @override
  State<BasesListPage> createState() => _BasesListPageState();
}

class _BasesListPageState extends State<BasesListPage> {
  late Future<List<BaseDescription>> futureBasesDescription;

  @override
  void initState() {
    super.initState();
    futureBasesDescription = widget.basesApi.fetchBases();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('header'),
          IconButton(
            icon: const Icon(FluentIcons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      content: FutureBuilder<List<BaseDescription>>(
        future: futureBasesDescription,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisExtent: 200,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(16),
                itemBuilder: (ctx, index) {
                  return BaseItem(baseDescription: snapshot.data![index]);
                });
          } else if (snapshot.hasError) {
            Typography typography = FluentTheme.of(context).typography;
            return Column(
              children: [
                const Spacer(),
                Center(
                  child: Text(
                    '$snapshot.error',
                    style: typography.bodyStrong,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FilledButton(
                    child: const Text('Refresh'),
                    onPressed: () {
                      setState(() {
                        futureBasesDescription = widget.basesApi.fetchBases();
                      });
                    }),
                const Spacer(),
              ],
            );
          }

          return const Center(
            child: ProgressRing(),
          );
        }),
      ),
    );
  }
}
