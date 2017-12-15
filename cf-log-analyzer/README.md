# Container

## CloudFront Log Analyser

Container image for analysing cloudfront request logs.

It uses the [request-log-analyzer](https://github.com/wvanbergen/request-log-analyzer/wiki) tool with a custom format parser.

### Usage

Step 1: Obtain CloudFront logs from s3 bucket.

<script src="https://gist.github.com/nicksantamaria/ee6322161e6469daf31a2214d8fa9f80.js"></script>

Step 2: Run `cf-log-analyzer` tool to parse logs.

```bash
docker run --rm -v $(pwd):/data previousnext/cf-log-analyzer
```

Step 3: Open the report.

```bash
open ./report.html
```

## Update Image

```
# Build image.
make build

# Push image.
make push
```
