/-
# 成分を 1 つずつ `1` に取り替えるごとに符号が反転する値（**必要十分版**）

人手のラベル: **`epsilon_eigenvalue_on_check_Q`** (3) `η_ε = η_{(1,…,1)}(-1)^{M_col-|ε|}`
（正本 `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`）。
具体版は `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimEpsilonEigenvalueOnCheckQ.lean` の
`CheckFermi.eta_eq_neg_eta_insert`（帰納法の段の 1 行目の根拠）・`eta_eq_eta_univ_mul_of_sub_card`（`k := M_col − |ε|` の帰納法）・
`eta_eq_eta_univ_mul` で、本ファイルの `eq_neg_of_insert`・`eq_univ_mul_neg_one_pow_of_sub_card`・`eq_univ_mul_neg_one_pow` が
それぞれ同じ行の calc を持つ。人手の `ε ∈ {0,1}^{M_col}` は Lean の `T : Finset ι`（`ε_μ = 1` の `μ` の集合）、
`ε[μ→1]` は `insert μ T`、`(1,…,1)` は `univ`、`|ε|` は `T.card`、`M_col` は `Fintype.card ι` である。

## 何が効いているか / 効いていないか

- 効いているのは、(2) の符号の反転則（仮定 `h`: `μ ∉ T` なら `η(insert μ T) = −η(T)`）と、値の集合 `R` の次の性質だけである。
  - 積の結合則・単位元と冪 `x^{m+1} = x^m x`・`x^0 = 1`（`Monoid`）。
  - 符号反転を二回すると元に戻ること（帰納法の段の 1 行目）、`−x = (−1)x`（人手の `multiply_by_minus_one`）、
    `(−1)x = x(−1)`（`HasDistribNeg`）。
- **人手の鎖の「乗法の交換則」の行（`(−1)(ηs) = (ηs)(−1)`）に効いているのは、`−1` が任意の元と可換であることだけ**で、
  それは `(−1)x = −x = x(−1)`（`HasDistribNeg`）から出る。`R` の積の可換則は効いていない。
- 加法（和・零・差）は効いていない。`η` の値が `±1` であることも、`η` が `ε Q̌_ε = η_ε Q̌_ε` の固有値であることも、
  添字の集合が `Fin M_col` であることも効いていない。添字の集合について効いているのは、有限であること
  （`|ε| ≤ M_col` と、`M_col − |ε| = 0` なら `ε = (1,…,1)`、`M_col − |ε| ≥ 1` なら `ε_μ = 0` の `μ` が取れること）と、
  等号が決定できること（`DecidableEq ι`。`ε[μ→1]` にあたる `insert μ T` を作るのに要る。外すと主張の型が書けない）だけである。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Commute.Defs
import Mathlib.Algebra.Ring.Commute
import Mathlib.Data.Fintype.Card

namespace Ising2D.NecSuf

section SignAfterReplacingComponents

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {R : Type*} [Monoid R] [HasDistribNeg R]
  {η : Finset ι → R}

omit [Fintype ι] in
/-- 帰納法の段の 1 行目の根拠: (2) の `η_{ε'} = −η_ε` の両辺の符号を反転して `η_ε = −η_{ε'}`。
具体版 `CheckFermi.eta_eq_neg_eta_insert` と同じ 2 行。 -/
theorem eq_neg_of_insert (h : ∀ (T : Finset ι) (μ : ι), μ ∉ T → η (insert μ T) = -η T)
    {T : Finset ι} {μ : ι} (hμ : μ ∉ T) : η T = -η (insert μ T) :=
  calc η T = -(-η T) := (neg_neg _).symm                -- 符号反転を二回すると元に戻る
    _ = -η (insert μ T) := by rw [h T μ hμ]             -- (2)

/-- **人手 (3) の `k := M_col − |ε|` の帰納法**（必要十分版）。`k = 0` の 4 行と `k ≥ 1` の 7 行は、
具体版 `CheckFermi.eta_eq_eta_univ_mul_of_sub_card` と同じ行である。 -/
theorem eq_univ_mul_neg_one_pow_of_sub_card
    (h : ∀ (T : Finset ι) (μ : ι), μ ∉ T → η (insert μ T) = -η T) (k : ℕ) :
    ∀ T : Finset ι, Fintype.card ι - T.card = k →
      η T = η Finset.univ * (-1 : R) ^ (Fintype.card ι - T.card) := by
  induction k with
  | zero =>
      intro T hk
      -- `k = 0` なら全ての `μ` で `ε_μ = 1`、すなわち `ε = (1,…,1)`
      have hT : T = Finset.univ := by
        apply Finset.eq_univ_of_card
        have hle : T.card ≤ Fintype.card ι := Finset.card_le_univ T
        omega
      calc η T = η Finset.univ := by rw [hT]                                       -- `ε = (1,…,1)`
        _ = η Finset.univ * 1 := (mul_one _).symm                                  -- 乗法の単位元
        _ = η Finset.univ * (-1 : R) ^ 0 := by rw [pow_zero]                       -- `z^0 = 1`
        _ = η Finset.univ * (-1 : R) ^ (Fintype.card ι - T.card) := by rw [hk]     -- `0 = M_col − |ε|`
  | succ k ih =>
      intro T hk
      -- `k ≥ 1` より `ε_μ = 0` なる `μ` が取れる
      obtain ⟨μ, hμ⟩ : ∃ μ, μ ∉ T := by
        by_contra hall
        have hT : T = Finset.univ :=
          Finset.eq_univ_iff_forall.2 fun μ => by_contra fun hμ => hall ⟨μ, hμ⟩
        rw [hT, Finset.card_univ, Nat.sub_self] at hk
        omega
      -- `|ε'| = |ε| + 1`、すなわち `M_col − |ε'| = k − 1`
      have hcard : (insert μ T).card = T.card + 1 := Finset.card_insert_of_notMem hμ
      have hk' : Fintype.card ι - (insert μ T).card = k := by rw [hcard]; omega
      have hpos : 1 ≤ Fintype.card ι - T.card := by omega
      calc η T = -η (insert μ T) := eq_neg_of_insert h hμ                           -- (2)
        _ = -(η Finset.univ * (-1 : R) ^ (Fintype.card ι - (insert μ T).card)) := by
            rw [ih (insert μ T) hk']                                                 -- 帰納法の仮定
        _ = -(η Finset.univ * (-1 : R) ^ (Fintype.card ι - T.card - 1)) := by
            rw [hcard, Nat.sub_add_eq]                                               -- `|ε'| = |ε| + 1`
        _ = (-1) * (η Finset.univ * (-1 : R) ^ (Fintype.card ι - T.card - 1)) :=
            (neg_one_mul _).symm                                                     -- `multiply_by_minus_one`
        _ = (η Finset.univ * (-1 : R) ^ (Fintype.card ι - T.card - 1)) * (-1) :=
            (Commute.neg_one_left _).eq                                              -- `−1` は任意の元と可換
        _ = η Finset.univ * ((-1 : R) ^ (Fintype.card ι - T.card - 1) * (-1)) :=
            mul_assoc _ _ _                                                          -- 乗法の結合則
        _ = η Finset.univ * (-1 : R) ^ (Fintype.card ι - T.card) := by
            rw [← pow_succ, Nat.sub_add_cancel hpos]                                 -- `z^{m+1} = z^m z`

/-- **人手 (3)**（必要十分版）: `η_ε = η_{(1,…,1)}(-1)^{M_col-|ε|}`。帰納法を `k := M_col − |ε|` で使う。 -/
theorem eq_univ_mul_neg_one_pow
    (h : ∀ (T : Finset ι) (μ : ι), μ ∉ T → η (insert μ T) = -η T) (T : Finset ι) :
    η T = η Finset.univ * (-1 : R) ^ (Fintype.card ι - T.card) :=
  eq_univ_mul_neg_one_pow_of_sub_card h (Fintype.card ι - T.card) T rfl

end SignAfterReplacingComponents

end Ising2D.NecSuf
