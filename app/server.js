// const express = require("express");
// const path = require("path");

// const app = express();
// const port = process.env.PORT || 8080;

// app.use(express.static(__dirname));

// app.get("/", (req, res) => {
//   res.sendFile(path.join(__dirname, "index.html"));
// });

// app.listen(port, () => console.log(`Listening on ${port}`));

//add appInsights telemetry
const appInsights = require("applicationinsights");

appInsights.setup().start();

const client = appInsights.defaultClient;


const express = require("express");
const app = express();

const PORT = process.env.PORT || 8080;

// Normal route
app.get("/", (req, res) => {
  res.send("App is running normally 🚀");
});

// Error simulation route
app.get("/error", (req, res) => {
  throw new Error("Simulated failure!");
});

// Slow route
app.get("/slow", async (req, res) => {

  //track when the slow route is triggered
  client.trackEvent({
  name: "SlowRouteTriggered",
  properties: {
    route: "/slow",
    environment: "demo"
  }
});
  
//track how much time it takes to process a slow request
const start = Date.now();
await new Promise(resolve => setTimeout(resolve, 5000));
const duration = Date.now() - start;

client.trackMetric({
  name: "CustomProcessingTime",
  value: duration
});

  res.send("Slow response completed ⏳");
});

// CPU load route
app.get("/load", (req, res) => {
  const start = Date.now();
  while (Date.now() - start < 3000) {}
  res.send("CPU load simulated 🔥");
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
}); 
 
