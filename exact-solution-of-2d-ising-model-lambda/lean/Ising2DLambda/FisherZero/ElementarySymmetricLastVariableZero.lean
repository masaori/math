/-
節「多変数多項式と基本対称式」の具体版。

  人手証明                                                  このファイル
  定義 `def_qbar_multivariate_polynomial_ring`              `QbarMvPoly`
  定義 `def_qbar_multivariate_substitution`                 `qbarMvSubst`
  定義 `def_qbar_elementary_symmetric_polynomial`           `qbarElementarySymmetric`
  定義 `def_last_variable_zero_substitution`                `lastVariableZeroValues`・`lastVariableZero`
  主張 `claim_last_variable_zero_elementary_symmetric`      `lastVariableZero_elementarySymmetric`
    第一の等号（基本対称式の定義）                          `qbarElementarySymmetric`
    第二の等号（B_0 と B_1 への分割）                        `Finset.sum_filter_add_sum_filter_not`
    第三の等号（代入は和と積を保つ）                        `map_sum`・`map_prod`
    第四の等号（π(X_k) = X_k、π(X_n) = 0）                  `lastVariableZero_X_castSucc`・`lastVariableZero_X_last`
    第五の等号（零を因子に持つ積は零、B_0 は I_n の j 元部分集合）
                                                            `Finset.prod_eq_zero`・`Finset.sum_nbij'`

本文の添字集合 `I_n = {k ∈ ℕ | k < n}` は `Fin n` で読む。本文では `I_n ⊆ I_{n+1}` が集合の包含であるが、
Lean では型が違うので、その包含を `Fin.castSucc` で書き、末尾の `n ∈ I_{n+1}` を `Fin.last n` で書く。
本文の変数 `X^{(n)}_k` は `MvPolynomial.X k : QbarMvPoly n`。
代入が和・積・定数を保つことは本文の定義 `def_qbar_multivariate_substitution` に置いた約束
（多項式環からの代入が環準同型であること）であり、`MvPolynomial.aeval` の準同型の性質で読む。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalIndeterminatePow
import Mathlib.Algebra.MvPolynomial.Basic
import Mathlib.Data.Finset.Powerset

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_qbar_multivariate_polynomial_ring` の具体版。添字集合 `I_n` の変数 `X^{(n)}_k` の多項式環。 -/
abbrev QbarMvPoly (n : ℕ) : Type := MvPolynomial (Fin n) Qbar

/-- `def_qbar_multivariate_substitution` の具体版。各変数 `X^{(n)}_k` に `y k` を代入する写像。 -/
noncomputable def qbarMvSubst {n m : ℕ} (y : Fin n → QbarMvPoly m) :
    QbarMvPoly n →ₐ[Qbar] QbarMvPoly m :=
  MvPolynomial.aeval y

/-- `def_qbar_elementary_symmetric_polynomial` の具体版。`e_{n,j} = Σ_{S ⊆ I_n, |S| = j} ∏_{k ∈ S} X^{(n)}_k`。 -/
noncomputable def qbarElementarySymmetric (n j : ℕ) : QbarMvPoly n :=
  ∑ S ∈ Finset.powersetCard j (Finset.univ : Finset (Fin n)), ∏ k ∈ S, X k

/-- `def_last_variable_zero_substitution` の代入する値。`k < n` には `X^{(n)}_k`、末尾の `n` には `0`。 -/
noncomputable def lastVariableZeroValues (n : ℕ) : Fin (n + 1) → QbarMvPoly n :=
  Fin.lastCases 0 (fun k => X k)

/-- `def_last_variable_zero_substitution` の具体版 `π_n`。 -/
noncomputable def lastVariableZero (n : ℕ) : QbarMvPoly (n + 1) →ₐ[Qbar] QbarMvPoly n :=
  qbarMvSubst (lastVariableZeroValues n)

/-- `def_last_variable_zero_substitution` の第一の値: `k < n` なら `π_n(X^{(n+1)}_k) = X^{(n)}_k`。 -/
theorem lastVariableZero_X_castSucc (n : ℕ) (k : Fin n) :
    lastVariableZero n (X k.castSucc) = X k := by
  simp [lastVariableZero, qbarMvSubst, lastVariableZeroValues]

/-- `def_last_variable_zero_substitution` の第二の値: `π_n(X^{(n+1)}_n) = 0`。 -/
theorem lastVariableZero_X_last (n : ℕ) :
    lastVariableZero n (X (Fin.last n)) = 0 := by
  simp [lastVariableZero, qbarMvSubst, lastVariableZeroValues]

/-- `claim_last_variable_zero_elementary_symmetric` の具体版。`π_n(e_{n+1,j}) = e_{n,j}`。 -/
theorem lastVariableZero_elementarySymmetric (n j : ℕ) :
    lastVariableZero n (qbarElementarySymmetric (n + 1) j) = qbarElementarySymmetric n j := by
  classical
  unfold qbarElementarySymmetric
  -- 第二の等号: B_1（末尾を含む）と B_0（末尾を含まない）に分ける。
  rw [← Finset.sum_filter_add_sum_filter_not _ (fun S => Fin.last n ∈ S)]
  -- 第三の等号: π_n は和と積を保つ。
  rw [map_add, map_sum, map_sum]
  simp_rw [map_prod]
  -- 第五の等号の前半: B_1 の各項は因子 π_n(X_n) = 0 を持つので零。
  have hB1 : ∑ S ∈ (Finset.powersetCard j (Finset.univ : Finset (Fin (n + 1)))).filter
      (fun S => Fin.last n ∈ S), ∏ k ∈ S, lastVariableZero n (X k) = 0 := by
    apply Finset.sum_eq_zero
    intro S hS
    exact Finset.prod_eq_zero (Finset.mem_filter.mp hS).2 (lastVariableZero_X_last n)
  rw [hB1, zero_add]
  -- 第五の等号の後半: B_0 は I_n の j 元部分集合と一対一で、各項は ∏_{k ∈ S} X^{(n)}_k。
  -- 本文では B_0 の元はそのまま I_n の部分集合である。Lean では型が違うので、
  -- 包含 `Fin.castSucc` の像と逆像で一対一を書く。
  refine Finset.sum_nbij' (fun S => Finset.univ.filter (fun k : Fin n => k.castSucc ∈ S))
    (fun T => T.map Fin.castSuccEmb) ?_ ?_ ?_ ?_ ?_
  · -- 逆像は j 元部分集合。
    intro S hS
    simp only [Finset.mem_filter, Finset.mem_powersetCard] at hS
    obtain ⟨⟨-, hcard⟩, hlast⟩ := hS
    simp only [Finset.mem_powersetCard, Finset.subset_univ, true_and]
    have hmap : (Finset.univ.filter (fun k : Fin n => k.castSucc ∈ S)).map Fin.castSuccEmb = S := by
      ext x
      induction x using Fin.lastCases with
      | last => simp [hlast, Fin.castSucc_ne_last]
      | cast k => simp
    rw [← hcard]
    conv_rhs => rw [← hmap]
    rw [Finset.card_map]
  · -- 像は末尾を含まない j 元部分集合。
    intro T hT
    simp only [Finset.mem_powersetCard, Finset.subset_univ, true_and] at hT
    simp only [Finset.mem_filter, Finset.mem_powersetCard, Finset.subset_univ,
      true_and, Finset.card_map, hT, Finset.mem_map, Fin.castSuccEmb_apply, not_exists, not_and]
    exact fun k _ => Fin.castSucc_ne_last k
  · -- 像の逆像はもとの集合。
    intro S hS
    simp only [Finset.mem_filter] at hS
    ext x
    induction x using Fin.lastCases with
    | last => simp [hS.2, Fin.castSucc_ne_last]
    | cast k => simp
  · -- 逆像の像はもとの集合。
    intro T _
    ext k
    simp
  · -- 各項: π_n(X^{(n+1)}_k) = X^{(n)}_k（k < n）。
    intro S hS
    simp only [Finset.mem_filter] at hS
    have hmap : (Finset.univ.filter (fun k : Fin n => k.castSucc ∈ S)).map Fin.castSuccEmb = S := by
      ext x
      induction x using Fin.lastCases with
      | last => simp [hS.2, Fin.castSucc_ne_last]
      | cast k => simp
    conv_lhs => rw [← hmap]
    rw [Finset.prod_map]
    exact Finset.prod_congr rfl (fun k _ => lastVariableZero_X_castSucc n k)

end Ising2DLambda.FisherZero
