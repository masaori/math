/-
# 双対結合定数の関係に効く代数計算（必要十分版）

対応する人手証明のラベル: `second_dual_coupling_relation`
（正本は `structured-latex/content/004_transfer_matrix.ts`）。

具体版は `Ising2D/Part004/ClaimSecondDualCouplingRelation.lean` に置く。

## 何が効いているか / 効いていないか

人手証明の後半に効くのは、体の四則演算と次の五つの等式だけである。

* `t=s/c` と `s≠0`, `c≠0`
* `e₊=1/t`, `e₋=t`
* `s*= (e₊-e₋)/2`
* `s₂=2sc` と `2≠0`
* `c²-s²=1`

実数の順序、指数関数、対数、双曲線関数そのものは、具体版でこれらの等式を供給するためにだけ
使う。本定理は、人手証明の `sinh(2K₂*)` の指数表示、倍角表示、`tanh` の商表示、通分、
`cosh²-sinh²=1` という同じ順序を、`2` が非零である可換体で実行する。`2≠0` は、
`s*= (e₊-e₋)/2` と `s₂=2sc` の係数を消去するために必要である。
-/
import Mathlib.Algebra.Field.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace Ising2D.NecSuf

/-- **必要十分版**: 双対関係の後半で実際に使う代数的仮定だけから積が `1` になる。

人手証明 `second_dual_coupling_relation` の指数表示以後と同じ計算順である。 -/
theorem dualCouplingProduct_eq_one
    {F : Type*} [Field F] [NeZero (2 : F)]
    (s c t ePlus eMinus sTwo sStar : F)
    (hs : s ≠ 0) (hc : c ≠ 0)
    (ht : t = s / c)
    (hePlus : ePlus = 1 / t)
    (heMinus : eMinus = t)
    (hsStar : sStar = (ePlus - eMinus) / 2)
    (hsTwo : sTwo = 2 * s * c)
    (hhyperbolic : c ^ 2 - s ^ 2 = 1) :
    sTwo * sStar = 1 := by
  have ht0 : t ≠ 0 := by
    rw [ht]
    exact div_ne_zero hs hc
  have hsc : s * c ≠ 0 := mul_ne_zero hs hc
  calc
    sTwo * sStar = (2 * s * c) * sStar := by rw [hsTwo]
    _ = (2 * s * c) * ((ePlus - eMinus) / 2) := by rw [hsStar]
    _ = s * c * (ePlus - eMinus) := by
      field_simp
    _ = s * c * (1 / t - eMinus) := by rw [hePlus]
    _ = s * c * (1 / t - t) := by rw [heMinus]
    _ = s * c * (1 / (s / c) - s / c) := by rw [ht]
    _ = s * c * (c / s - s / c) := by
      congr 1
      field_simp
    _ = s * c * ((c ^ 2 - s ^ 2) / (s * c)) := by
      congr 1
      field_simp
    _ = (s * c * (c ^ 2 - s ^ 2)) / (s * c) := by
      rw [mul_div_assoc]
    _ = c ^ 2 - s ^ 2 := by
      exact mul_div_cancel_left₀ (c ^ 2 - s ^ 2) hsc
    _ = 1 := hhyperbolic

end Ising2D.NecSuf
