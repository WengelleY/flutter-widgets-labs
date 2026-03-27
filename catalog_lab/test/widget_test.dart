import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:catalog_lab/main.dart';
import 'dart:async';

void main() {
  testWidgets('Catalog App smoke test', (
    WidgetTester tester,
  ) async {
    // This wrapper catches the network requests and points them to our "Fake" client below
    await HttpOverrides.runZoned(
      () async {
        await tester.pumpWidget(
          const CatalogApp(),
        );

        expect(
          find.text('Catalog'),
          findsOneWidget,
        );
        expect(
          find.text('Coffee Mug'),
          findsOneWidget,
        );
      },
      createHttpClient: (SecurityContext? c) =>
          createMockImageHttpClient(c),
    );
  });
}

/// THIS IS THE MISSING PIECE:
/// This function creates a "Fake" Internet Client that returns a transparent pixel
/// instead of actually trying to download an image.
HttpClient createMockImageHttpClient(
  SecurityContext? _,
) {
  final client = _MockHttpClient();
  return client;
}

class _MockHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;

  @override
  Future<HttpClientRequest> getUrl(
    Uri url,
  ) async => _MockHttpClientRequest();

  @override // This is a "no-op" (does nothing) for everything else
  dynamic noSuchMethod(Invocation invocation) =>
      null;
}

class _MockHttpClientRequest
    implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async =>
      _MockHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      null;
}

class _MockHttpClientResponse
    implements HttpClientResponse {
  @override
  int get statusCode => 200; // Pretend everything is okay!

  @override
  HttpClientResponseCompressionState
  get compressionState =>
      HttpClientResponseCompressionState
          .notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    // Return a tiny 1x1 transparent pixel so the Image widget is happy
    final transparentPixel = Uint8List.fromList([
      0x89,
      0x50,
      0x4E,
      0x47,
      0x0D,
      0x0A,
      0x1A,
      0x0A,
      0x00,
      0x00,
      0x00,
      0x0D,
      0x49,
      0x48,
      0x44,
      0x52,
      0x00,
      0x00,
      0x00,
      0x01,
      0x00,
      0x00,
      0x00,
      0x01,
      0x08,
      0x06,
      0x00,
      0x00,
      0x00,
      0x1F,
      0x15,
      0xC4,
      0x89,
      0x00,
      0x00,
      0x00,
      0x0A,
      0x49,
      0x44,
      0x41,
      0x54,
      0x78,
      0x9C,
      0x63,
      0x00,
      0x01,
      0x00,
      0x00,
      0x05,
      0x00,
      0x01,
      0x0D,
      0x0A,
      0x2D,
      0xB4,
      0x00,
      0x00,
      0x00,
      0x00,
      0x49,
      0x45,
      0x4E,
      0x44,
      0xAE,
      0x42,
      0x60,
      0x82,
    ]);
    return Stream.fromIterable([
      transparentPixel,
    ]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      null;
}
