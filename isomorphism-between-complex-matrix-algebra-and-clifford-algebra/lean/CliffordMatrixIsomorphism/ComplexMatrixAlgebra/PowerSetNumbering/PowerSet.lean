/-
章「複素行列環」の、{1,…,M} の部分集合全体の集合 P_M の定義。ℂ を含まないので、具体版と必要十分版が同じこのファイルを引く。

  本文のラベル                                  このファイル
  def_power_set_of_first_m_positive_integers    PowerSet・PowerSet.ext

P_M の元 T は、ℕ の部分集合で、どの元 t も 1 ≤ t ≤ M を満たすもの（部分型）。番号 t の所属は `t ∈ T.1` で書く。
S = T は、すべての t ∈ {1,…,M} で t ∈ S と t ∈ T が同値であること（`PowerSet.ext`）。
P_M の二元のクロネッカーのデルタ δ_{S,T} には、P_M の等号の判定として `Classical.decEq` を与える。
-/
import Mathlib.Data.Set.Basic

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- 本文 `def_power_set_of_first_m_positive_integers`：P_M := {T : T ⊆ {1,…,M}}。 -/
def PowerSet (M : ℕ) : Type := {T : Set ℕ // ∀ t : ℕ, t ∈ T → 1 ≤ t ∧ t ≤ M}

namespace PowerSet

/-- 本文 `def_power_set_of_first_m_positive_integers`：S = T は、すべての t ∈ {1,…,M} で t ∈ S と t ∈ T が同値であること。 -/
theorem ext {M : ℕ} {S T : PowerSet M} (h : ∀ t : ℕ, 1 ≤ t → t ≤ M → (t ∈ S.1 ↔ t ∈ T.1)) : S = T := by
  apply Subtype.ext
  apply Set.ext
  intro t
  constructor
  · intro ht
    exact (h t (S.2 t ht).1 (S.2 t ht).2).1 ht
  · intro ht
    exact (h t (T.2 t ht).1 (T.2 t ht).2).2 ht

/-- P_M の等号の判定（クロネッカーのデルタ δ_{S,T} に使う）。 -/
noncomputable instance (M : ℕ) : DecidableEq (PowerSet M) := Classical.decEq _

end PowerSet

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
