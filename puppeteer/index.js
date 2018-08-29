const express = require("express"),
  puppeteer = require("puppeteer"),
  dns = require("dns"),
  bodyParser = require("body-parser"),
  http = require("http"),
  convertHTMLToPDF = require("./src/convertHTMLToPDF.js");

const app = express();
const router = express.Router();
let endpoint;

// Latest chrome can only connect via ip address.
const getChromeEndpoint = () => {
  return new Promise(function(resolve, reject) {
    if (endpoint) {
      return resolve(endpoint);
    }
    const versionEndPoint = `http://127.0.0.1:9222/json/version`;
    console.info(`Requesting chrome endpoint from ${versionEndPoint}`);
    http.get(versionEndPoint, (res) => {
      res.setEncoding('utf8');
      let rawData = '';
      res.on('data', (chunk) => { rawData += chunk; });
      res.on('end', () => {
        try {
          const parsedData = JSON.parse(rawData);
          endpoint = parsedData.webSocketDebuggerUrl;
          console.info(`Chrome endpoint is ${endpoint}`);
          return resolve(endpoint);
        } catch (e) {
          return reject(`Unable to determine chrome endpoint: ${e.message}`);
        }
      });
    }).on('error', (e) => {
      return reject(`Unable to connect to Chrome: ${e.message}`);
    });
  });
};

// PDF endpoint.
router.route("/pdf").post(async function(req, res) {
  getChromeEndpoint()
    .then(async (endpoint) => {
      const browser = await puppeteer.connect({
        browserWSEndpoint: endpoint
      });
      convertHTMLToPDF(browser, req.body, req.query, pdf => {
        res.setHeader("Content-Type", "application/pdf");
        res.send(pdf);
      });
    }, (err) => {
      // Force looking this up next time.
      endpoint = null;
      console.error(err)
    })
});

// Test route
router.route("/healthz").get(async function(req, res) {
  getChromeEndpoint()
    .then(async (endpoint) => {
      await puppeteer.connect({
        browserWSEndpoint: endpoint
      });
      res.send(`Connected to ${endpoint} with no hassles`);
    }, (err) => {
      res.status(500);
      res.send('Could not connect to chrome');
    });
});

app.use(
  bodyParser.text({
    limit: "50mb"
  })
);

app.use("/api", router);

// Start the server.
const port = 3000;
http.createServer(app).listen(port);
console.info("Server listening on port " + port);
