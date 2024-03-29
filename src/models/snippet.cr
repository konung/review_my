class Snippet < BaseModel
  table do
    column slug : String
    column title : String
    column content : String
    column domain_restricted : Bool
    column revision_deadline : Time?
    belongs_to creator : User
    has_many revisions : Revision
  end
end
