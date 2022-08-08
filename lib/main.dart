import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter_1c_application/models/base_category.dart';
import 'package:starter_1c_application/models/base_description.dart';
import 'package:starter_1c_application/widgets/bases_list_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitle('title');
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.setSize(const Size(755, 545));
    await windowManager.setMinimumSize(const Size(755, 545));
    await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'title',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ru', ''), // Spanish, no country code
      ],
      locale: const Locale('ru', ''),
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.orange,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  final viewKey = GlobalKey();
  final List<BaseDescription> basesDescription = const [
    BaseDescription(
      id: '123',
      name: 'Ancor 2022',
      executablePath: '',
      baseCategory: BaseCategory.work,
    ),
    BaseDescription(
      id: '125',
      name: 'Ancor 2022 (test0)',
      executablePath: '',
      baseCategory: BaseCategory.test,
    )
  ];
  int index = 0;

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure want to close the app?'),
            actions: [
              FilledButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context);
                    windowManager.destroy();
                  }),
              FilledButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        },
      );
    }
    super.onWindowClose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      key: viewKey,
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(
          () {
            index = i;
          },
        ),
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Main'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.health),
            title: const Text('AboutProgram'),
          ),
        ],
      ),
      content: NavigationBody.builder(
          index: index,
          itemBuilder: (ctx, index) {
            if (index == 0) {
              return BasesListPage(
                basesDescription: basesDescription,
              );
            } else {
              //TODO: Realize AboutPage
              return Container();
            }

            //return Text(AppLocalizations.of(context)!.title);
          }),
    );
  }
}
