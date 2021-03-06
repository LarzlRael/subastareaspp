part of '../widgets.dart';

class DesplegableComment extends StatefulWidget {
  final String commentContent;
  bool isExpanded;
  final int limit;
  DesplegableComment({
    Key? key,
    required this.commentContent,
    this.isExpanded = false,
    this.limit = 75,
  }) : super(key: key);
  @override
  State<DesplegableComment> createState() => _DesplegableCommentState();
}

class _DesplegableCommentState extends State<DesplegableComment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: ConstrainedBox(
            constraints: widget.isExpanded
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 45.0),
            /*     child: Text(
                      widget.text,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ), */
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                widget.commentContent,
                textAlign: TextAlign.start,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ),
        widget.commentContent.length > widget.limit
            ? widget.isExpanded
                ? /*  Column(
                            children: [
                              ConstrainedBox(constraints: const BoxConstraints()),
                              TextButton(
                                  child: const Text('Mostrar menos'),
                                  onPressed: () =>
                                      setState(() => widget.isExpanded = false))
                            ],
                          ) */
                ConstrainedBox(constraints: const BoxConstraints())
                : TextButton(
                    child: const Text('Mostrar m??s'),
                    onPressed: () => setState(() => widget.isExpanded = true),
                  )
            : Container(),
      ],
    );
  }
}
