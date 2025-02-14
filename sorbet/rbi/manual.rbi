# typed: true

module ERB::Escape
  sig { params(value: String).returns(String) }
  def self.html_escape(value); end
end
