class SimilarityUpdateService
  def initialize(id_1, id_2)
    @id_1 = id_1
    @id_2 = id_2
  end

  def update_similarity
    array1 = SimilaritiesUser.where(user_id: @id_1).pluck(:similarity_id)
    array2 = SimilaritiesUser.where(user_id: @id_2).pluck(:similarity_id)
    next unless (array1 & array2).present?
    similarity = Similarity.find((array1 & array2)[0])
    next unless similarity.update( \
      similarity: ApplicationController.helpers.cos_similarity(id_1, id_2))
  end
  
  private

    attr_reader :id_1, :id_2
end
