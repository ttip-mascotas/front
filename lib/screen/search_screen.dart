import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/pet_bloc.dart';
import 'package:mascotas/model/analysis.dart';
import 'package:mascotas/widget/analysis_tab_view.dart';
import 'package:mascotas/widget/pets_scaffold.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key,});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Analysis> analysis = [];

  @override
  Widget build(BuildContext context) {
    return PetsScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onSubmitted: searchAnalysis,
              leading: const Icon(Icons.search),
            ),
            Expanded(
              child: AnalysisList(
                analyses: analysis,
                messageEmptyList: 'Buscá análisis en base a su contenido',
              ),
            )
          ],
        ),
      ),
      title: 'Buscador de análisis',
    );
  }

  void searchAnalysis(String text) async {
    final analysis = await context.read<PetCubit>().searchAnalysis(text);
    setState(() {
      this.analysis = analysis;
    });
  }
}
