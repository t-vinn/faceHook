class SimilarityCreateService
  def initialize(id_1, id_2, similarity)
    @id_1 = id_1
    @id_2 = id_2
    @similarity = similarity
  end


  def create_similarity
    a = Similarity.create(similarity: @similarity)
    SimilaritiesUser.create(similarity_id: a.id, user_id: @id_1)
    SimilaritiesUser.create(similarity_id: a.id, user_id: @id_2)
  end

  private

    attr_reader :id_1, :id_2, :similarity
end
