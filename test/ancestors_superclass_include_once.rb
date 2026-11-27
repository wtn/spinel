# A module that a superclass already has is listed once in ancestors and
# included_modules, as CRuby skips the include. A prepend of the same
# module adds the module ahead of the class, as in CRuby.
module M; end
module N; include M; end
class A; include M; end
class B < A; include M; end
p B.ancestors
p B.included_modules
class C < A; include N; end
p C.ancestors
class D < A; prepend M; end
p D.ancestors
class E; include IO::WaitReadable; end
class F < E; include IO::WaitReadable; end
p F.ancestors
p F.included_modules
class G < B; include M; include N; end
p G.ancestors
module Q; end
class H; include Q; end
class I < H; end
class J < I; include Q, M; end
p J.ancestors
class X < Array; include Enumerable; end
p X.ancestors.take(4)
class R; include Comparable; def <=>(o) = 0; end
class S < R; include Comparable; end
p S.ancestors
module N; include M; end
p N.ancestors
class T < A; prepend M; include M; end
p T.ancestors
module MK; include Kernel; end
p MK.ancestors
p MK.include?(Kernel)
module M2; include Comparable; include Kernel; end
module M3; include M2; end
p M3.ancestors
class Array; def anc_probe = 1; end
module Enumerable; def anc_probe2 = 2; end
class Y < Array; include Enumerable; end
p Y.ancestors.take(4)
p Y.included_modules.take(2)
# an include that runs before the superclass's include of the same module
# is listed in both places, as CRuby lists it
module LM; end
class LA; end
class LB < LA; include LM; end
class LA; include LM; end
class LC < LA; include LM; end
p LB.ancestors
p LB.included_modules
p LC.ancestors
module LP; end
class LK; end
class LL < LK; include LP; end
class LK; prepend LP; end
p LL.ancestors
module LN; include LM; end
class LU; end
class LV < LU; include LN; end
class LU; include LM; end
class LW < LU; include LN; end
p LV.ancestors
p LW.ancestors
# a module that the superclass's module includes later
module TM; end
module TN; end
class TA; include TN; end
class TB < TA; include TM; end
module TN; include TM; end
class TC < TA; include TM; end
p TB.ancestors
p TC.ancestors
# a module that the superclass's prepended module includes
module PM; end
module PP; include PM; end
class PA; prepend PP; end
class PB < PA; include PM; end
p PB.ancestors
module PM2; end
module PP2; end
class PA2; prepend PP2; end
class PB2 < PA2; include PM2; end
module PP2; include PM2; end
class PC2 < PA2; include PM2; end
p PB2.ancestors
p PC2.ancestors
# a module the class includes before the superclass does, and that a module
# included ahead of it brings again later
module DM; end
module DN; end
class DA; end
class DB < DA; include DN; include DM; end
class DA; include DM; end
module DN; include DM; end
p DB.ancestors.count(DM)
