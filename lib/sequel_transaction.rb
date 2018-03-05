class SequelTransaction
  extend Uber::Callable

  def self.call(_options, *)
    Sequel::Model.db.transaction { yield }
  end
end
