import 'package:flutter_dotenv/flutter_dotenv.dart';

// BACKEND BASE URL
var baseURL = dotenv.env['BACKEND_BASEURL'].toString();
var baseHeader = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

// ENDPOINT
const nodesEndpoint = "/nodes";
const resampledEndpoint = "/sensors/resampledData";
const forecastEndpoint = "/sensors/forecast";
