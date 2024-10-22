import 'package:cached_network_image/cached_network_image.dart';
import 'package:demotask/cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => DataCubit(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<DataCubit>().loadItem();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          context.read<DataCubit>().state.taskStatus!) {
        context.read<DataCubit>().loadItem();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Sample Data"),
          ),
          body: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.list!.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == state.list!.length) {
                      return !state.taskStatus!
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox.shrink();
                    }
                    return Card(
                      color: Colors.white54,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: "https://picsum.photos/200/300",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Title $index"),
                            Text("Description  $index")
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              context
                                  .read<DataCubit>()
                                  .removeItem(index);
                            },
                            icon: const Icon(Icons.close)),
                      ),
                    );
                  }),
        );
      },
    );
  }
}
