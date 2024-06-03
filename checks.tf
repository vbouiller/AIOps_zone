check "front_end_200" {
  data "http" "front_end" {
    url = output.app_URL.value
  }

  assert {
    condition     = data.http.front_end.status_code == 200
    error_message = "${data.http.front_end.url} a retourné un mauvais code de statut: ${data.http.front_end.status_code}"
  }
}