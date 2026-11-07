/-
# 成分が積と和で閉じた性質に入る対称行列の冪（必要十分版）

具体版: `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetric.lean`
（人手 `power_of_real_symmetric_complex_matrix_is_real_symmetric`）。具体版をこのファイルの特殊化として得るのは
`ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetricFromNecSuf.lean`（同じフォルダ）。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 準備 `A^1 = A` の 4 行 | `pow_one_eq_self'` の `calc` の 4 段 |
| `p = 0`: `I` の成分の 3 行と「成分はすべて実数」 | `one_entries_mem'` の場合分け（`S 1` と `S 0`） |
| `p = 0`: `(I^⊤)_{kl}` の 4 行 | `one_transpose_matrix'`（`SeriesOfSymmetricIsSymmetric.lean`） |
| `p + 1`: 成分はすべて実数（`product_of_real_entry_matrices_has_real_entries`、`A → A^p`, `B → A`） | `mul_entries_mem`（`ProductOfClosedEntries.lean`） |
| `p + 1`: `((A^{p+1})^⊤)_{kl}` の 11 行 | `pow_succ_transpose_apply'` の `calc` の 11 段 |
| 帰納法の組み立て | `pow_entries_mem_and_transpose_eq'` |

## 何が効いているか / 効いていないか

- 「成分が実数」（`ℝ` の像に入る）を、係数の型 `R` の任意の性質 `S` に置き換えた。効いているのは、`S` が `0` と `1` を含むこと
  （`p = 0` の `I` の成分）、積と和で閉じていること（`p + 1` の成分。`mul_entries_mem` が要る理由は `ProductOfClosedEntries.lean` に書いた）
  である。`S` が `0` を含むことを落とすと、`n ≥ 2` の `I` の非対角成分 `0` が `S` に入る根拠が無い
  （`S` を「正の実数」に取ると `1` を含み積と和で閉じるが、`0` は入らない）。
- 添字が空でないこと（`Nonempty ι`。人手の `n ≥ 1`）は主張には要らない（`ι` が空なら結論は空虚に成り立つ）。
  具体版と同じ段 `mul_entries_mem`（`product_of_real_entry_matrices_has_real_entries`）が `Nonempty` を要るので置いている。
- 転置の段に効いているのは、**係数の乗法の可換則**（11 行のうち 7 行目 `(A^p)_{jl}A_{kj} = A_{kj}(A^p)_{jl}`）である。
  可換でない係数では対称な `A` でも `A^2` が対称とは限らない: `((A^2)^⊤)_{kl} = Σ_j A_{lj}A_{jk} = Σ_j A_{jl}A_{kj}` と
  `(A^2)_{kl} = Σ_j A_{kj}A_{jl}` は、`A_{kj}` と `A_{jl}` が可換でなければ一致しない。
- 型クラスを `CommSemiring` に置いたのは、上の可換則と、行列の積の結合則・単位元（`A^1 = A` と指数法則）が係数の半環の構造から来るためである。
  加法の逆元、体であること、係数が `ℂ` であることは効いていない。
-/
import Ising2D.NecSuf.PowerExponentLaw
import Ising2D.NecSuf.ProductOfClosedEntries
import Ising2D.NecSuf.SeriesOfSymmetricIsSymmetric
import Ising2D.NecSuf.MatrixProductIdentityAndScalar

namespace Ising2D.NecSuf

open Matrix

variable {R ι : Type*} [CommSemiring R] [Fintype ι] [DecidableEq ι]

/-- 準備 `A^1 = A`（具体版 `matrix_pow_one_eq_self_tensorPow`）。 -/
theorem pow_one_eq_self' (A : Matrix ι ι R) : A ^ 1 = A :=
  calc A ^ 1
      = A ^ (0 + 1) := rfl                                                  -- `1 = 0 + 1`
    _ = A ^ 0 * A := pow_succ A 0                                           -- `a^{m+1} := a^ma`（`m → 0`）
    _ = 1 * A := by rw [pow_zero]                                           -- `a^0 := 1`
    _ = A := one_mul_matrix A                                               -- 単位行列は左単位

omit [Fintype ι] in
/-- `p = 0`: `S` が `0` と `1` を含めば、単位行列の成分はすべて `S` に入る（具体版 `identity_matrix_hasRealEntries_tensorPow`）。 -/
theorem one_entries_mem' (S : R → Prop) (h0 : S 0) (h1 : S 1) (k l : ι) :
    S ((1 : Matrix ι ι R) k l) := by
  rw [Matrix.one_apply]                                                     -- 単位行列の成分
  split_ifs
  · exact h1                                                                -- `k = l`
  · exact h0                                                                -- `k ≠ l`

/-- `p + 1` の転置の 11 段（具体版 `matrix_pow_succ_transpose_apply_tensorPow`）。 -/
theorem pow_succ_transpose_apply' (A : Matrix ι ι R) (hAT : Aᵀ = A) (p : ℕ)
    (ih : (A ^ p)ᵀ = A ^ p) (k l : ι) :
    (A ^ (p + 1))ᵀ k l = (A ^ (p + 1)) k l :=
  calc (A ^ (p + 1))ᵀ k l
      = (A ^ (p + 1)) l k := rfl                                            -- 転置の定義
    _ = (A ^ p * A) l k := by rw [pow_succ]                                 -- `a^{m+1} := a^ma`（`m → p`）
    _ = ∑ j, (A ^ p) l j * A j k := rfl                                     -- 積の定義
    _ = ∑ j, (A ^ p)ᵀ j l * Aᵀ k j := rfl                                   -- 転置の定義を 2 箇所へ
    _ = ∑ j, (A ^ p) j l * Aᵀ k j := by rw [ih]                             -- 帰納法の仮定 `(A^p)^⊤ = A^p`
    _ = ∑ j, (A ^ p) j l * A k j := by rw [hAT]                             -- 仮定 `A^⊤ = A`
    _ = ∑ j, A k j * (A ^ p) j l :=
        Finset.sum_congr rfl fun j _ => mul_comm _ _                        -- 係数の乗法の可換則（効いている）
    _ = (A * A ^ p) k l := rfl                                              -- 積の定義
    _ = (A ^ 1 * A ^ p) k l := by rw [pow_one_eq_self' A]                   -- 準備 `A^1 = A`
    _ = (A ^ (1 + p)) k l := by rw [power_exponent_law' A 1 p]              -- 冪の指数法則（`p → 1`, `q → p`）
    _ = (A ^ (p + 1)) k l := by rw [Nat.add_comm 1 p]                       -- 加法の可換則

/-- **成分が `S` に入る対称行列の冪**（具体版 `power_of_real_symmetric_complex_matrix_is_real_symmetric`）:
すべての `p` について、`A^p` の成分はすべて `S` に入り、`(A^p)^⊤ = A^p`（`p` についての帰納法）。 -/
theorem pow_entries_mem_and_transpose_eq' [Nonempty ι] (S : R → Prop) (h0 : S 0) (h1 : S 1)
    (hmul : ∀ a b, S a → S b → S (a * b)) (hadd : ∀ a b, S a → S b → S (a + b))
    (A : Matrix ι ι R) (hA : ∀ k l, S (A k l)) (hAT : Aᵀ = A) :
    ∀ p : ℕ, (∀ k l, S ((A ^ p) k l)) ∧ (A ^ p)ᵀ = A ^ p
  | 0 => by
      rw [pow_zero]                                                         -- `a^0 := 1`
      exact ⟨one_entries_mem' S h0 h1, one_transpose_matrix'⟩
  | p + 1 => by
      have ih := pow_entries_mem_and_transpose_eq' S h0 h1 hmul hadd A hA hAT p  -- 帰納法の仮定
      refine ⟨?_, ?_⟩
      · rw [pow_succ]                                                       -- `a^{m+1} := a^ma`（`m → p`）
        exact mul_entries_mem S hmul hadd (A ^ p) A ih.1 hA                 -- 積と和で閉じること
      · exact Matrix.ext (pow_succ_transpose_apply' A hAT p ih.2)           -- 転置の 11 段

end Ising2D.NecSuf
