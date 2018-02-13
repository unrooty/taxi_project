# case_sensitive by default: false
class UniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    relation = build_relation(record.model, attribute, value)

    record.errors.add(attribute, :taken || 'already taken!') unless relation.empty?
  end

  private

  def build_relation(model, attribute, value)
    relation_class = model.class

    relation = if options[:case_sensitive]
                 relation_class.where(attribute => value)
               else
                 relation_class.where(Sequel.function(:lower, attribute) =>
                                          value.downcase)
               end


    if model.persisted?
      relation.exclude(relation_class.primary_key => model.id)
    else
      relation
    end
  end
end
