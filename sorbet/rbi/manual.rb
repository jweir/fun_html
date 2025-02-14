# typed: true

module Minitest::Spec::DSL
  extend T::Sig

  sig { params(desc: String, block: T.proc.bind(Minitest::Test).void).void }
  def it(desc = T.unsafe(nil), &block); end

  sig { params(desc: String, block: T.proc.bind(Minitest::Test).void).void }
  def specify(desc = T.unsafe(nil), &block); end
end
