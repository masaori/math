/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.AlgebraicEigenvalue.lexLess_trichotomy` / `lexLess_trans` に
  ι := 列番号の集合 ZMod L
  g := 射影 π（`fun k => ((k : ℕ) : ZMod L)`）
  L := 格子の一辺 L
  V := スピン値 SpinValue
  ε := spinIndex
を代入すると、具体版 `AlgebraicEigenvalue.rowConfigLess_trichotomy` / `rowConfigLess_trans` が
そのまま出る。このことは、具体版の証明が格子の形・周期境界条件・スピンの値が `{+1,-1}` で
あること（値が 2 つしかないこと）を使っていないという主張の裏取りになっている。

被覆の仮定（`ι` の各点が `{0,…,L-1}` の番号から届くこと）は、`ZMod L` の各元 `y` に対し
`k := y.val` を取れば満たされる。ここが人手証明で代表を取る写像 `s` を使っている箇所にあたる。

2 つの `≺` の一致は、`Nat.find` の同一性を経由せず、両側を「最小の相違位置での比較」という
明示の形（`rowConfigLess_iff_exists` / `lexLess_iff_exists`）へ書き直して取る。

住処: ℕ のみ。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowConfigOrder
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowConfigOrder

namespace Ising2DLambda.AlgebraicEigenvalue

open PartitionPolynomial TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 必要十分版へ渡す被覆の仮定。人手証明の「`k := s(y)` と置く」にあたる。 -/
lemma rowIndexCover : ∀ y : ZMod L, ∃ k, k < L ∧ ((k : ℕ) : ZMod L) = y := fun y =>
  ⟨y.val, ZMod.val_lt y, by rw [ZMod.natCast_val, ZMod.cast_id]⟩

variable {L}

/-- 具体版の `≺` を「最小の相違位置での比較」という明示の形へ書き直したもの
（必要十分版の `lexLess_iff_exists` と同じ形）。 -/
lemma rowConfigLess_iff_exists {τ τ' : RowConfig L} :
    rowConfigLess L τ τ'
      ↔ ∃ k, k < L ∧ (∀ j < k, τ ((j : ℕ) : ZMod L) = τ' ((j : ℕ) : ZMod L))
          ∧ spinIndex (τ ((k : ℕ) : ZMod L)) < spinIndex (τ' ((k : ℕ) : ZMod L)) := by
  constructor
  · rintro ⟨h, hlt⟩
    exact ⟨firstDifference h, firstDifference_lt h,
      fun j hj => eq_below_firstDifference h hj, hlt⟩
  · rintro ⟨k, hkL, hbelow, hlt⟩
    have hne : τ ((k : ℕ) : ZMod L) ≠ τ' ((k : ℕ) : ZMod L) := fun hcon => by
      rw [hcon] at hlt; exact lt_irrefl _ hlt
    have hneτ : τ ≠ τ' := fun hcon => hne (by rw [hcon])
    have hk : firstDifference hneτ = k :=
      firstDifference_eq_of hneτ ⟨hkL, hne⟩ fun j hj hjmem => hjmem.2 (hbelow j hj)
    exact ⟨hneτ, by rw [hk]; exact hlt⟩

/-- 具体版の `≺` と、必要十分版の `≺` を上の代入で具体化したものが一致すること。 -/
lemma rowConfigLess_eq_lexLess {τ τ' : RowConfig L} :
    rowConfigLess L τ τ'
      ↔ NecSuf.AlgebraicEigenvalue.lexLess spinIndex (rowIndexCover L) τ τ' := by
  rw [rowConfigLess_iff_exists, NecSuf.AlgebraicEigenvalue.lexLess_iff_exists]

/-- 三分律を必要十分版から出したもの（具体版と同じ言明）。 -/
theorem rowConfigLess_trichotomy_from_necSuf (τ τ' : RowConfig L) :
    (rowConfigLess L τ τ' ∧ τ ≠ τ' ∧ ¬ rowConfigLess L τ' τ)
      ∨ (¬ rowConfigLess L τ τ' ∧ τ = τ' ∧ ¬ rowConfigLess L τ' τ)
      ∨ (¬ rowConfigLess L τ τ' ∧ τ ≠ τ' ∧ rowConfigLess L τ' τ) := by
  have h := NecSuf.AlgebraicEigenvalue.lexLess_trichotomy (rowIndexCover L)
    spinIndex_injective τ τ'
  -- 3 つの場合をそのまま移す（`≺` の一致は `rowConfigLess_eq_lexLess`）。
  rcases h with ⟨ha, hb, hc⟩ | ⟨ha, hb, hc⟩ | ⟨ha, hb, hc⟩
  · exact Or.inl ⟨rowConfigLess_eq_lexLess.mpr ha, hb,
      fun hcon => hc (rowConfigLess_eq_lexLess.mp hcon)⟩
  · exact Or.inr (Or.inl ⟨fun hcon => ha (rowConfigLess_eq_lexLess.mp hcon), hb,
      fun hcon => hc (rowConfigLess_eq_lexLess.mp hcon)⟩)
  · exact Or.inr (Or.inr ⟨fun hcon => ha (rowConfigLess_eq_lexLess.mp hcon), hb,
      rowConfigLess_eq_lexLess.mpr hc⟩)

/-- 推移律を必要十分版から出したもの（具体版と同じ言明）。 -/
theorem rowConfigLess_trans_from_necSuf {τ τ' τ'' : RowConfig L}
    (h1 : rowConfigLess L τ τ') (h2 : rowConfigLess L τ' τ'') :
    rowConfigLess L τ τ'' := by
  exact rowConfigLess_eq_lexLess.mpr
    (NecSuf.AlgebraicEigenvalue.lexLess_trans (rowIndexCover L)
      (rowConfigLess_eq_lexLess.mp h1) (rowConfigLess_eq_lexLess.mp h2))

end Ising2DLambda.AlgebraicEigenvalue
