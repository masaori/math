/-
# 正定値行列のトレースは正（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTraceOfPositiveDefiniteIsPositive.lean`
（人手 `trace_of_positive_definite_is_positive`）。具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTraceOfPositiveDefiniteIsPositiveFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `star_kroneckerDelta`（`δ` は `1_ℂ` か `0_ℂ` なので共役で動かない） | `star_delta'`（仮定 `star 1 = 1`・`star 0 = 0`） |
| `conjugate_bilinear_value_basis_eq_diag` の 11 段（`def_conjugate_bilinear_value` → 共役 → 結合律 → 分配律 → 単位行列の定義 → `mat_mult` → 右単位元 → `δ` の対称性 → 単位行列の定義 → `mat_mult` → 左単位元） | `conjBilin_basis_eq_diag'`（同じ並びの 11 段） |
| `standardBasisVec_ne_zero`（`b^{(k)}_k = 1_ℂ ≠ 0_ℂ`） | `basis_ne_zero'`（`1 ≠ 0`） |
| `trace_of_positive_definite_is_positive` のトレースの鎖の 3 段と、`Σ r_k ≥ r_1 > 0` の 2 段 | 1 段目 `def_trace` は `trace_pos_of_conjBilin_pos'` の最後の `calc`、残りの 2 段と `Σ r_k ≥ r_1 > 0` の 2 段は `trace_eq_incl_of_diag'`（同じ並び） |
| `trace_of_positive_definite_is_positive` | `trace_pos_of_conjBilin_pos'` |

## 何が効いているか / 効いていないか

- **成分の鎖（`b^{(k)*}Ab^{(k)} = A_{kk}`）に効いているのは、係数の半環の公理のうち積の結合律・左分配律
  （`Finset.mul_sum`）・`1` が左右の単位元であること・`0` が積を零にすることと、共役が `1`・`0` を動かさないこと
  （仮定 `h1`・`h0`）だけである。** 係数の積の可換律は効いていない（`δ_{ik} = δ_{ki}` は添字の等号の対称性
  `i = k ↔ k = i` から出て、係数の性質を使わない）。係数の符号反転・逆元も使わないので、環でなく半環 `Semiring` でよい。
  共役は写像 `star : R → R`（`Star`）だけを仮定し、`star 1 = 1`・`star 0 = 0` を明示の仮定に置く
  （共役が和・積を保つこと・対合であることは使わない。`StarRing` は仮定しない）。
  `Semiring` は鎖の積の結合律・単位元・零と、行列の積 `A * 1`・`1 * A`（`Matrix.mul_one`・`Matrix.one_mul`）のために要る。
- 添字は `Fin n` でなくてよい。有限で（和のため）、等号が決定可能（`δ` を `if` で定めるため）なら何でもよい。
  人手の `n ∈ ℤ_{≥1}` は、トレースの段の「`r_1` がある」にだけ効く（`Nonempty`）。
- `b^{(k)} ≠ 0` に効いているのは `1 ≠ 0`（`Nontrivial`）だけである。
- **トレースの段に効いているのは、包含 `ι : S → R` が和を保つこと（人手の `real_inclusion_preserves_finite_sum`）と、
  `S` が前順序を持ち、左から同じ元を足しても大小が保たれること（`Preorder`・`AddLeftMono`。`Σ r_k ≥ r_1`・`r_1 > 0`）だけである。**
  反対称律は使わない。`AddLeftMono` を外すと `Σ r_k ≥ r_1` が通らない（各項を足し込む段で要る）。
  `finite_sum_ge_term_fin'` は帰納法の段で `add_le_add` を左右の両方の因子に当てるので `AddRightMono` も仮定するが、
  ここで引く補題は `AddLeftMono` だけで閉じる（`S` の加法は可換なので、`AddLeftMono` から `AddRightMono` も従う）。
  `Σ r_k ≥ r_1` は具体版が引く
  `finite_sum_of_nonnegative_reals_is_at_least_each_term` と同じ主張である。その必要十分版 `finite_sum_ge_term_fin'`
  （`NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`）は添字が `Fin m` に限るので、添字が任意の有限型のここでは
  同じ主張の mathlib の `Finset.single_le_sum`（前順序と `AddLeftMono` の上の初等的な補題）を引く。 `S = ℝ` であること、ℝ の積・完備性、
  包含が単射であることは効いていない。`R` の順序も使わない（正値性は「正の元の包含である」の形で受け渡す）。
- 正定値性は「零でない全ての `x` について `x^*Ax = ι(r)` を満たす `r > 0` がある」の形で仮定する
  （人手 `def_hermitian_positive_definite` の略記 `z ∈ ℝ_{>0}` を `ι` で一般化した形）。エルミート性は効いていない。
-/
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.Star.Basic
import Mathlib.LinearAlgebra.Matrix.Trace

namespace Ising2D.NecSuf

open Matrix

section Basis

variable {ι : Type*} [DecidableEq ι] {R : Type*} [Semiring R]

/-- 人手 `def_conjugate_bilinear_value` の式 `x^*Ay := Σ_k Σ_l (\overline{x_k} A_{kl}) y_l`（係数は半環）。 -/
def conjBilin' [Fintype ι] [Star R] (x : ι → R) (A : Matrix ι ι R) (y : ι → R) : R :=
  ∑ k, ∑ l, (star (x k) * A k l) * y l

/-- 人手 `def_kronecker_delta` の `δ_{ik}`（係数は半環）。 -/
def delta' (i k : ι) : R := if i = k then 1 else 0

/-- 標準基底ベクトル `b^{(k)}_i := δ_{ik}`。 -/
def basis' (k : ι) : ι → R := fun i => delta' i k

/-- `\overline{δ_{ik}} = δ_{ik}`（`star 1 = 1`・`star 0 = 0` だけ）。 -/
theorem star_delta' [Star R] (h1 : star (1 : R) = 1) (h0 : star (0 : R) = 0) (i k : ι) :
    star (delta' i k : R) = delta' i k := by
  unfold delta'
  split
  · exact h1
  · exact h0

/-- `δ_{ik} = δ_{ki}`（添字の等号の対称性だけ）。 -/
theorem delta_comm' (i k : ι) : (delta' i k : R) = delta' k i := by
  unfold delta'
  simp only [eq_comm]

/-- `(I)_{lk} = δ_{lk}`。 -/
theorem one_apply_eq_delta' (l k : ι) : (1 : Matrix ι ι R) l k = delta' l k :=
  Matrix.one_apply

/-- **`b^{(k)*}Ab^{(k)} = A_{kk}`**（具体版 `conjugate_bilinear_value_basis_eq_diag`。11 段の並びは同じ）。 -/
theorem conjBilin_basis_eq_diag' [Fintype ι] [Star R] (h1 : star (1 : R) = 1) (h0 : star (0 : R) = 0)
    (A : Matrix ι ι R) (k : ι) :
    conjBilin' (basis' k) A (basis' k) = A k k :=
  calc conjBilin' (basis' k) A (basis' k)
      = ∑ i, ∑ l, (star (delta' i k : R) * A i l) * delta' l k := rfl            -- `x^*Ay` の式と `b^{(k)}` の定義
    _ = ∑ i, ∑ l, ((delta' i k : R) * A i l) * delta' l k := by                    -- 共役を各項へ
        simp only [star_delta' h1 h0]
    _ = ∑ i, ∑ l, (delta' i k : R) * (A i l * delta' l k) :=                       -- 積の結合律を各項へ
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => mul_assoc _ _ _
    _ = ∑ i, (delta' i k : R) * ∑ l, A i l * delta' l k :=                         -- 左分配律
        Finset.sum_congr rfl fun i _ => (Finset.mul_sum _ _ _).symm
    _ = ∑ i, (delta' i k : R) * ∑ l, A i l * (1 : Matrix ι ι R) l k := by          -- 単位行列の定義を各項へ
        simp only [one_apply_eq_delta']
    _ = ∑ i, (delta' i k : R) * (A * (1 : Matrix ι ι R)) i k := rfl                -- 行列の積の定義
    _ = ∑ i, (delta' i k : R) * A i k := by rw [Matrix.mul_one]                    -- 右単位元
    _ = ∑ i, (delta' k i : R) * A i k := by simp only [delta_comm' _ k]            -- `δ` の対称性を各項へ
    _ = ∑ i, (1 : Matrix ι ι R) k i * A i k := by simp only [one_apply_eq_delta']  -- 単位行列の定義を各項へ
    _ = ((1 : Matrix ι ι R) * A) k k := rfl                                        -- 行列の積の定義
    _ = A k k := by rw [Matrix.one_mul]                                            -- 左単位元

/-- `b^{(k)} ≠ 0`（`1 ≠ 0` だけ）。 -/
theorem basis_ne_zero' [Nontrivial R] (k : ι) : basis' k ≠ (0 : ι → R) := by
  intro h
  have hk : (basis' k : ι → R) k = 0 := by rw [h]; rfl
  have h1 : (basis' k : ι → R) k = 1 := if_pos rfl
  exact one_ne_zero (h1.symm.trans hk)

end Basis

section Trace

variable {ι : Type*} [Fintype ι] {S : Type*} [AddCommMonoid S] [Preorder S] [AddLeftMono S]
  {R : Type*} [AddCommMonoid R]

/-- **トレースの段**（具体版 `trace_of_positive_definite_is_positive` の後半）: 各対角成分が正の元の包含なら、
その和も正の元の包含である。 -/
theorem trace_eq_incl_of_diag' [Nonempty ι] (incl : S →+ R) (d : ι → R) (r : ι → S)
    (hr : ∀ k, 0 < r k) (hd : ∀ k, d k = incl (r k)) :
    ∃ s : S, 0 < s ∧ ∑ k, d k = incl s := by
  obtain ⟨k₁⟩ := ‹Nonempty ι›
  have htr : ∑ k, d k = incl (∑ k, r k) :=
    calc ∑ k, d k
        = ∑ k, incl (r k) := Finset.sum_congr rfl fun k _ => hd k                   -- `r_k` の取り方を各項へ
      _ = incl (∑ k, r k) := (map_sum incl r Finset.univ).symm                       -- 包含は和を保つ
  have hpos : ∑ k, r k > 0 :=
    calc ∑ k, r k
        ≥ r k₁ :=                                                                   -- 非負の元の有限和は各項以上
          Finset.single_le_sum (fun k _ => (hr k).le) (Finset.mem_univ k₁)
      _ > 0 := hr k₁                                                                -- `r_1 > 0`
  exact ⟨∑ k, r k, hpos, htr⟩

end Trace

section Main

variable {ι : Type*} [Fintype ι] [DecidableEq ι] [Nonempty ι]
  {S : Type*} [AddCommMonoid S] [Preorder S] [AddLeftMono S]
  {R : Type*} [Semiring R] [Star R] [Nontrivial R]

/-- **正定値行列のトレースは正**（具体版 `trace_of_positive_definite_is_positive`）。 -/
theorem trace_pos_of_conjBilin_pos' (h1 : star (1 : R) = 1) (h0 : star (0 : R) = 0)
    (incl : S →+ R) (A : Matrix ι ι R)
    (hA : ∀ x : ι → R, x ≠ 0 → ∃ r : S, 0 < r ∧ conjBilin' x A x = incl r) :
    ∃ s : S, 0 < s ∧ A.trace = incl s := by
  choose r hr hrA using fun k : ι => hA (basis' k) (basis_ne_zero' k)
  have hd : ∀ k, A k k = incl (r k) := fun k =>
    calc A k k
        = conjBilin' (basis' k) A (basis' k) := (conjBilin_basis_eq_diag' h1 h0 A k).symm  -- 成分の鎖
      _ = incl (r k) := hrA k                                                         -- 正定値性
  obtain ⟨s, hs, hsum⟩ := trace_eq_incl_of_diag' incl (fun k => A k k) r hr hd
  refine ⟨s, hs, ?_⟩
  calc A.trace
      = ∑ k, A k k := rfl                                                             -- トレースの定義
    _ = incl s := hsum                                                                -- トレースの段

end Main

end Ising2D.NecSuf
