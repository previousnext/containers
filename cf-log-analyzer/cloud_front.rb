# Cloudfront parser for request-log-analyzer tool.
#
# See:
# - https://github.com/wvanbergen/request-log-analyzer
# - https://gist.github.com/quezacoatl/bbc8195d44e8a0817b90c9e01ce43fc9

class CloudFront < RequestLogAnalyzer::FileFormat::Base
  extend RequestLogAnalyzer::FileFormat::CommonRegularExpressions

  line_definition :access do |line|
    line.header = true
    line.footer = true

    line.regexp = /^(#{timestamp('%Y-%m-%d	%H:%M:%S')})\s(\w+)\s(\d+)\s(#{ip_address})\s(\w+)\s(\S+)\s(\S+)\s(\d+)\s(\S+)\s(\S+)\s(\S+)\s(\S+)\s(\w+)\s(\S+)\s(\S+)\s(\w+)\s(\d+)\s(\S+)\s(#{ip_address}|-)\s+(\S+)\s(\S+)\s(\w+)\s(\S+)/

    line.capture(:timestamp).as(:timestamp)
    line.capture(:edge_location)
    line.capture(:bytes_sent).as(:traffic, unit: :byte)
    line.capture(:remote_ip)
    line.capture(:http_method)
    line.capture(:cloudfront_distribution)
    line.capture(:path).as(:path)
    line.capture(:http_status).as(:integer)
    line.capture(:referer)
    line.capture(:user_agent)
    line.capture(:query)
    line.capture(:cookie)
    line.capture(:edge_result_type)

    line.capture(:edge_request_id)
    line.capture(:host)
    line.capture(:protocol)
    line.capture(:bytes_received).as(:traffic, unit: :byte)

    line.capture(:duration).as(:duration, unit: :msec)
    line.capture(:forwarded_for).as(:nillable_string)
    line.capture(:ssl_protocol)
    line.capture(:ssl_cipher)

    line.capture(:edge_response_result_type)
    line.capture(:protocol_version)
  end

  report do |analyze|
    analyze.timespan
    analyze.hourly_spread

    analyze.frequency category: :http_method, title: 'HTTP methods'
    analyze.frequency category: :http_status, title: 'HTTP statuses'

    analyze.frequency category: :path, title: 'Most popular URIs'

    analyze.frequency category: :remote_ip, title: 'Most active clients'

    analyze.frequency category: :user_agent, title: 'User agents'
    analyze.frequency category: :referer,    title: 'Referers'

    analyze.frequency category: :edge_result_type,    title: 'Edge result types'

    analyze.duration duration: :duration,  category: :path, title: 'Request duration'
    analyze.traffic traffic: :bytes_sent, category: :path, title: 'Traffic out'
    analyze.traffic traffic: :bytes_received, category: :path, title: 'Traffic in'
  end

  class Request < RequestLogAnalyzer::Request
    # Do not use DateTime.parse, but parse the timestamp ourselves to return a integer
    # to speed up parsing.
    def convert_timestamp(value, _definition)
      "#{value[0, 4]}#{value[5, 2]}#{value[8, 2]}#{value[11, 2]}#{value[14, 2]}#{value[17, 2]}".to_i
    end
  end
end
