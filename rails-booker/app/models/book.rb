class Book < ActiveRecord::Base
  extend FriendlyId

#  friendly_id :tittle
friendly_id :slug_candidates, use: :slugged


  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :tittle,
      [:tittle, :author]
    #,
    #  [:name, :street, :city],
    #  [:name, :street_number, :street, :city]
    ]
  end

  #def tittle_and_author
  #  "#{tittle} by #{author}"
#end


end
