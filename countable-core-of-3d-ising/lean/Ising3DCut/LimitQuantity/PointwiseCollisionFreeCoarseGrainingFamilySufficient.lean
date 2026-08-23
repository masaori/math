/-
「各箱で有限箱データを区別する粗視化の族は極限量に対して十分である」の Lean 具体版。

有限箱データはサイト数と正の有理数の素指数データの組である。人手証明と同じ順に、各箱で
粗視化の値が一致する段、値の衝突が無いことから有限箱データが一致する段、素指数データの
一致から分配多項式の値が一致する段、既存の健全性の橋で極限量が一致する段を辿る。
-/
import Ising3DCut.LimitQuantity.FiniteBoxEqualitiesTransfer

namespace Ising3DCut.LimitQuantity

open NullModel Filter Topology

/-- 有理点 `q` における箱 `L` の有限箱データ：サイト数と素指数データの組。 -/
noncomputable def finiteBoxPrimeExponentData (L : ℕ) (q : ℚ) : ℕ × (ℕ → ℤ) :=
  (L ^ 3, fun p ↦ padicValRat p (evalAtRational q (partitionPolynomial L)))

/-- 各箱の粗視化が有限箱データ上で値の衝突を持たなければ、粗視化像の一致から
有限箱データの列の項別一致が従う。 -/
theorem finiteBoxPrimeExponentData_eq_of_pointwise_collision_free_coarse_graining
    {P : ℕ → Type*} (tau : ∀ L, (ℕ × (ℕ → ℤ)) → P L)
    (hfree : ∀ L s t, tau L s = tau L t → s = t)
    {q q' : ℚ}
    (hagree : ∀ L : ℕ, 0 < L →
      tau L (finiteBoxPrimeExponentData L q) =
        tau L (finiteBoxPrimeExponentData L q')) :
    ∀ L : ℕ, 0 < L →
      finiteBoxPrimeExponentData L q = finiteBoxPrimeExponentData L q' := by
  intro L hL
  exact hfree L _ _ (hagree L hL)

/-- 十分性：各箱の有限箱データを区別する粗視化像が全箱で一致するなら、両側の極限量が
存在するとき、その値は一致する。 -/
theorem limitQuantity_eq_of_pointwise_collision_free_coarse_graining
    {P : ℕ → Type*} (tau : ∀ L, (ℕ × (ℕ → ℤ)) → P L)
    (hfree : ∀ L s t, tau L s = tau L t → s = t)
    {q q' : ℚ} (hqpos : 0 < q) (hq'pos : 0 < q')
    (hagree : ∀ L : ℕ, 0 < L →
      tau L (finiteBoxPrimeExponentData L q) =
        tau L (finiteBoxPrimeExponentData L q'))
    (N : ℕ → ℕ) (ℓ ℓ' : ℝ)
    (hq : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (nhds ℓ))
    (hq' : Tendsto (rootSeq (finiteBoxValueSeq q') N) atTop (nhds ℓ')) : ℓ = ℓ' := by
  -- 人手証明の「粗視化像の一致と衝突なしから有限箱データが一致する」の段。
  have hdata := finiteBoxPrimeExponentData_eq_of_pointwise_collision_free_coarse_graining
    tau hfree hagree
  -- 人手証明の「有限箱データの第二成分、すなわち素指数データが一致する」の段。
  have hexponents : ∀ L : ℕ, 0 < L → ∀ p : ℕ, p.Prime →
      padicValRat p (evalAtRational q (partitionPolynomial L)) =
        padicValRat p (evalAtRational q' (partitionPolynomial L)) := by
    intro L hL p _
    exact congrFun (congrArg Prod.snd (hdata L hL)) p
  -- 人手証明の「素指数データから有限箱の値を一意に復元する」の段。
  have hvalues := partitionPolynomial_evalAtRational_eq_of_prime_exponent_sequence_eq
    hqpos hq'pos hexponents
  -- 人手証明の「既存の健全性の橋により極限量が一致する」の段。
  exact limitQuantity_eq_of_finiteBox_eq N hvalues ℓ ℓ' hq hq'

end Ising3DCut.LimitQuantity
