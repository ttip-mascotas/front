import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:mascotas/bloc/analysis_bloc.dart";
import "package:mascotas/bloc/bloc_state.dart";
import "package:mascotas/datasource/analysis_datasource.dart";
import "package:mascotas/datasource/api.dart";
import "package:mascotas/model/analysis.dart";
import "package:mascotas/widget/pets_scaffold.dart";

class AnalysisScreen extends StatelessWidget {
  final int id;

  const AnalysisScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AnalysisBloc(
        id: id,
        analysisDatasource: AnalysisDatasource(api: Api()),
      ),
      child: Builder(builder: (context) {
        return BlocBuilder<AnalysisBloc, BlocState>(builder: (context, state) {
          switch (state) {
            case Error():
              return PetsScaffold(
                title: "Ocurrio un error",
                body: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Flexible(child: Text(state.message)),
                    ],
                  ),
                ),
              );
            case Loaded():
              final Analysis value = state.value;
              var images = value.images;
              return PetsScaffold(
                body: images.isNotEmpty
                    ? GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: List.generate(
                          images.length,
                          (index) => Image.network(
                            images[index].url,
                          ),
                        ),
                      )
                    : const Center(
                        child: Text("Este análisis no contiene imagenes")),
                title: value.name,
              );
            default:
              return const PetsScaffold(
                body: Center(child: CircularProgressIndicator()),
                title: "Cargando...",
              );
          }
        });
      }),
    );
  }
}
