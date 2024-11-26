import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Die Anfrage zur API:
  Future<String> getDatafromAPI() async {
    // Die URL zur API:
    String url =
        "https://dummyjson.com/products/1123456782345"; // wenn die url Fehler enthält, werden Fehlermeldungen ausgelöst!

    // Die URL in eine Uri umwandeln (parsen):
    Uri uri = Uri.parse(url);

    // Die Anfrage senden:
    final response = await http.get(uri);
    log("0030 - Anfrage gesendet an $uri");

    // Wenn die Anfrage erfolgreich war (= 200):
    if (response.statusCode == 200) {
      // Die Daten in eine Map konvertieren:
      Map<String, dynamic> data = jsonDecode(response.body);
      log("0036 - data: $data");

      // HIER nur den "title" zurückgeben:
      log("0039 - HIER nur den --> title <-- zurückgeben: ${data["title"]}");
      return data["title"];
    } else {
      // Wenn die Anfrage fehlgeschlagen ist:
      Map<String, dynamic> error = jsonDecode(response.body);
      log("0043 - ERROR !!! $error");

      // Eine Fehlermeldung (falls vorhanden) zurückgeben:
      return "Fehlermeldung: ${error["message"]}!";
    }
  }

  // Diese Variable ist ein "Platzhalter", die entweder die Daten oder einen Fehler (falls vohanden) speichert:
  String data = "Hier kommt der Text\nder API-Anfrage rein.";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Der Text zeigt entweder einen Fehler (falls vorhanden) oder die Daten aus der API an:
              Text(
                data,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 82, 149),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20),

              // Der "ElevatedButton" startet die Anfrage und übergibt die response an die Variable "data":
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue),
                  elevation: WidgetStateProperty.all(8),
                  // surfaceTintColor: WidgetStateProperty.all(Colors.black),
                  // overlayColor: WidgetStateProperty.all(Colors.red),
                  // shadowColor: const WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: () async {
                  String dataFromAPI = await getDatafromAPI();
                  setState(() {
                    log("0086 - dataFromAPI: $dataFromAPI");
                    data = dataFromAPI;
                  });
                },
                child: const Text(
                  "1 x eine API-Anfrage stellen",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*--------------------------------------------------------------------------------------------*
5.4.2_TS_API_Flutter
√ https://docs.google.com/document/d/1uRK9cpqYjDN_kii0g8jY-k5rhTamURrjyGgHZ_b_UfI/edit?tab=t.0
*---------------------------------------------------------------------------------------------*
√ Erstelle ein neues GitHub-Repository, das für dein Projekt gedacht ist.
√ Mache regelmäßige Commits und Pushes. Was ist der Link zu deinem Repository?
√ https://github.com/JuergenHollmann/ts_542_api_flutter
*---------------------------------------------------------------------------------------------*
Aufgabe 1: Kleine Flutter-App
√ Schreibe eine kleine Flutter-App, die ein Textfeld und einen Button enthält.
√ Wenn der Button geklickt wird, soll eine Abfrage an eine API gemacht werden.
√ Das Ergebnis soll im Textfeld angezeigt werden.
√ Mache anschließend commit und push.
√ Wie sieht dein Code und deine UI aus? Kopiere den Code und einen Screenshot deiner App in das Antwortfeld.
*---------------------------------------------------------------------------------------------*
Aufgabe 2: Fehlerbehandlung
Baue nun einen Fehler in deine Abfrage ein.
Dies kann eine falsche URL sein oder ein nicht passender Query Param.
Sorge dafür, dass der Fehler dem Benutzer angezeigt wird.
Mache anschließend Commit und Push.
Wie sieht dein Code und deine UI aus? Kopiere den Code und einen Screenshot deiner App in das Antwortfeld.
*---------------------------------------------------------------------------------------------*/