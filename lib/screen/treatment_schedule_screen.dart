import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas/bloc/treatment_websocket_bloc.dart';
import 'package:mascotas/bloc/websocket_state.dart';
import 'package:mascotas/datasource/api.dart';
import 'package:mascotas/datasource/treatment_datasource.dart';
import 'package:mascotas/datasource/web_socket_controller.dart';
import 'package:mascotas/datasource/web_socket_datasource.dart';
import 'package:mascotas/widget/pets_scaffold.dart';
import 'package:mascotas/widget/treatment_detail.dart';

class TreatmentScheduleScreen extends StatelessWidget {
  final int id;

  const TreatmentScheduleScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return PetsScaffold(
      title: "Tratamiento",
      body: BlocProvider(
          create: (BuildContext context) => WebSocketBloc(
                webSocketController:
                    WebSocketController(repository: WebSocketDatasource()),
                treatmentsDatasource: TreatmentsDatasource(api: Api()),
                id: id,
              ),
          child: const TreatmentScheduleDetails()),
    );
  }
}

class TreatmentScheduleDetails extends StatefulWidget {
  const TreatmentScheduleDetails({
    super.key,
  });

  @override
  State<TreatmentScheduleDetails> createState() => _TreatmentScheduleDetailsState();
}

class _TreatmentScheduleDetailsState extends State<TreatmentScheduleDetails> {
  late WebSocketBloc _webSocketBloc;

  @override
  void initState() {
    super.initState();
    _webSocketBloc = context.read<WebSocketBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebSocketBloc, WebSocketState>(
      builder: (BuildContext context, WebSocketState state) {
        switch (state) {
          case WebSocketError():
            return Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Flexible(child: Text(state.errorMessage)),
                ],
              ),
            );
          case WebSocketTreatmentReceived():
            return TreatmentDetail(treatment: state.treatment);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _webSocketBloc.closeWebSocket();
    _webSocketBloc.close();
    super.dispose();
  }
}
