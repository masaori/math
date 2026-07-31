/-
# 必要十分版: 「因子がすべて対角なら積も対角」

対応する人手証明のラベル: **`sigma_z_diagonal_action`**
（具体版は `Ising2D/Part010/Claim002_SigmaZDiagonal.lean`）

## この主張に本質的に効いている構造は何か

具体版（`Ising2D.sigmaZ_eq_diagonal`）は
「`σ^z_m = I ⊠ ⋯ ⊠ σ^z ⊠ ⋯ ⊠ I` は基底 `(f_I)` に関して対角行列である」という主張だが、
証明に効いているのは次の 2 点だけである。

1. クロネッカー積の成分が**因子の成分の積**であること
   （`Ising2D.siteProd_apply : siteProd M x s t = ∏ i, x i (s i) (t i)`）。
2. 各因子が対角、すなわち `a ≠ b → d i a b = 0` であること。

したがって効いていないもの:

* 行列であること（結論は「添字つき族の有限積」についての命題である）
* 係数が複素数であること（**零元をもつ可換モノイド**があれば十分。加法も減法も要らない）
* 各サイトの次元が 2 であること、サイト数が有限個の `Fin M` であること
  （添字型は任意の `Fintype`、各サイトの状態型も任意でよい）
* Pauli 行列の具体的な成分

零因子の非存在すら不要である（片方が `0` なら積は `0` という一方向しか使わない）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2D.NecSuf

variable {ι : Type*} [Fintype ι] {κ : ι → Type*} {R : Type*} [CommMonoidWithZero R]

/-- 各因子が「対角」（添字が食い違えば `0`）なら、因子ごとの成分の積も
添字の族が食い違えば `0` になる。 -/
theorem prod_entry_eq_zero_of_ne
    (d : ∀ i, κ i → κ i → R) (hd : ∀ i a b, a ≠ b → d i a b = 0)
    (s t : ∀ i, κ i) (h : s ≠ t) :
    ∏ i : ι, d i (s i) (t i) = 0 := by
  obtain ⟨i, hi⟩ := Function.ne_iff.mp h
  exact Finset.prod_eq_zero (Finset.mem_univ i) (hd i _ _ hi)

/-- 上を「行列の言葉」に寄せた形: 因子ごとの成分の積で定まる `ι` 添字の「積作用素」は、
各因子が対角なら対角である（`s = t` のときの値は対角成分の積、`s ≠ t` のときは `0`）。 -/
theorem prod_entry_eq_ite
    (d : ∀ i, κ i → κ i → R) (hd : ∀ i a b, a ≠ b → d i a b = 0)
    (s t : ∀ i, κ i) [Decidable (s = t)] :
    ∏ i : ι, d i (s i) (t i) = if s = t then ∏ i : ι, d i (s i) (s i) else 0 := by
  by_cases h : s = t
  · subst h; simp
  · rw [if_neg h]
    exact prod_entry_eq_zero_of_ne d hd s t h

end Ising2D.NecSuf
