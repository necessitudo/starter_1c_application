import 'package:fluent_ui/fluent_ui.dart';
import 'package:starter_1c_application/models/base_description.dart';

class BaseItem extends StatelessWidget {
  final BaseDescription baseDescription;

  const BaseItem({Key? key, required this.baseDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;

    return Card(
      padding: const EdgeInsets.only(bottom: 8, top: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 80,
              //color: material.Colors.grey.shade700,
              child: Image.asset(
                'assets/images/1c_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(
                6,
              ),
              child: Text(
                baseDescription.name,
                style: typography.bodyLarge?.apply(fontSizeFactor: 0.8),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FluentIcons.device_run,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                IconButton(
                  style: ButtonTheme.of(context).iconButtonStyle,
                  onPressed: () {},
                  icon: const Icon(
                    FluentIcons.add_favorite,
                    //color: FluentTheme.of(context).activeColor,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FluentIcons.settings,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
