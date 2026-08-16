/-
「有理係数の対数順序群の逆元は順序を反転する」の具体版を、
必要十分版 `neg_le_neg_of_le_necSuf` の特殊化として導く。
渡すのは加法単調性 `rationalLogOrderLE_add_right` と逆元律 `add_neg_cancel` だけである。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNegReversesOrder
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupNegReversesOrder

namespace Ising2DLambda.ThermodynamicLimit

theorem rationalLogOrderLE_neg_le_neg_from_necSuf {l m : RationalLogOrderGroup}
    (h : rationalLogOrderLE l m) : rationalLogOrderLE (-m) (-l) :=
  NecSuf.ThermodynamicLimit.neg_le_neg_of_le_necSuf rationalLogOrderLE
    (fun z h => rationalLogOrderLE_add_right h z) add_neg_cancel h

end Ising2DLambda.ThermodynamicLimit
