# A module that Object includes is listed once for a class that includes
# the module after Object does, as CRuby skips the include.
module OM; end
class OA; include OM; end
class Object; include OM; end
class OB; include OM; end
class OC < OA; include OM; end
class OZ < BasicObject; include ::OM; end
p OA.ancestors
p OB.ancestors
p OC.ancestors
p OZ.ancestors
