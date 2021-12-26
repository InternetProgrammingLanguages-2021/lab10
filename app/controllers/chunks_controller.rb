require "active_support/core_ext"

class ChunksController < ApplicationController
  def index
    query = request.query_parameters['q']
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
    render xml: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"/template.xsl\"?>
#{msg.split(/\n/, 2)[1]}"
  end
end
