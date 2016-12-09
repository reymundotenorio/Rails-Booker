class Book < ActiveRecord::Base
  extend FriendlyId

#  friendly_id :tittle
friendly_id :slug_candidates, use: :slugged


  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :tittle,
      [:tittle, :author],
      [:tittle, :author, :description]
    ]
  end

  def should_generate_new_friendly_id?
  slug.blank? || tittle_changed? || author_changed? || description_changed?
  end

  #def tittle_and_author
  #  "#{tittle} by #{author}"
#end

def self.search(search)

if search
  where("author LIKE ? OR tittle LIKE ?", "%#{search}%", "%#{search}%")
else
 scoped
end
# where("tittle LIKE ?", "%#{search}%")

end


end
