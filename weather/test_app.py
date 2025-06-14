import unittest
from main import app
from unittest.mock import patch


class WeatherServiceTests(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_health_check(self):
        response = self.app.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"The service is running", response.data)

    @patch("main.requests.get")
    def test_valid_city(self, mock_get):
        mock_response = {
            "location": {
                "name": "London"
            },
            "current": {
                "temp_c": 15
            }
        }
        mock_get.return_value.status_code = 200
        mock_get.return_value.json.return_value = mock_response

        response = self.app.get("/London")
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertIn("location", data)
        self.assertEqual(data["location"]["name"], "London")

    @patch("main.requests.get")
    def test_invalid_city(self, mock_get):
        mock_get.side_effect = Exception("City not found")

        response = self.app.get("/InvalidCity123")
        self.assertIn(response.status_code, [400, 500])
        data = response.get_json()
        self.assertIn("message", data)


if __name__ == "__main__":
    unittest.main()
