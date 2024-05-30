String formatUrl(String url) {
  const host = "10.0.2.2";

  return url
      .replaceFirst("localhost", host)
      .replaceFirst("127.0.0.1", host)
      .replaceFirst("minio", host);
}
