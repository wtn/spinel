# A class under a reopened BasicObject lists a module that Object includes:
# Object is not among the class's ancestors.
module BM; end
class Object; include BM; end
class BasicObject; def bo_probe = 1; end
class BZ < BasicObject; include ::BM; end
class BY; include BM; end
p BZ.ancestors
p BY.ancestors
