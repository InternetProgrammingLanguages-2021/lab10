require "active_support/core_ext"
require "nokogiri"

XSLT = Nokogiri::XSLT(File.read('public/template.xsl'))

class ChunksController < ApplicationController
  def index
    query = request.query_parameters['q']
    ssr = request.query_parameters['ssr']
    msg = { error: 'no query provided' }.to_xml
    return render xml: msg unless query.is_a?(String)
    input = query
            .split(',')
            .map(&:to_f)
    chunks = input
             .chunk_while { |previous, current| previous < current }
    msg = { input: input,
      chunks: chunks.to_a,
      max_length: chunks.max_by(&:length) }.to_xml
    if ssr == 'true' then
      render inline: XSLT.transform(Nokogiri::XML(msg))
    else
      render xml: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
  <?xml-stylesheet type=\"text/xsl\" href=\"/template.xsl\"?>
  #{msg.split(/\n/, 2)[1]}"
    end
  end
end
