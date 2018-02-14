class TermCourse < SaposModels
  belongs_to :term
  belongs_to :course
  belongs_to :staff

  ASSIGNED   = 1
  UNASSIGNED = 2
  DELETED = 3

end