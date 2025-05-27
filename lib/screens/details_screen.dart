import 'package:flutter/material.dart';
import 'package:proyecto_peliculas/widgets/widget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppbar(),

          SliverList(
            delegate: SliverChildListDelegate([
              _PostetrAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              CastingCards(),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(
            "movie.title",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage("https://placehold.jp/500x300.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PostetrAndTitle extends StatelessWidget {
  const _PostetrAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme texttheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage("assets/loading.gif"),
              image: NetworkImage("https://placehold.jp/200x300.png"),
              height: 150,
            ),
          ),

          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "movie.title",
                style: texttheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                "movie.original.title",
                style: texttheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  Text("movievoteAvarage", style: texttheme.labelSmall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Tempor laborum veniam fugiat ipsum officia adipisicing nisi minim nisi proident qui nisi est irure. Eu labore laborum nisi in ut anim veniam exercitation minim aliqua cupidatat occaecat magna dolor. Lorem amet sunt Lorem sint amet. Dolore elit cillum ipsum cillum veniam dolor consectetur eiusmod sint nisi exercitation enim elit incididunt. Veniam anim dolor est et veniam et proident in pariatur est aliquip consequat et. Elit id reprehenderit enim magna et ad deserunt labore ipsum eiusmod exercitation ad. Sunt ut consectetur nisi quis labore eiusmod consequat do aliqua cupidatat.",
        textAlign: TextAlign.justify,

        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
