/-
# クロネッカー積の各因子についての線型性（必要十分版）

具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerMultilinear.lean`
（人手 `kronecker_multilinear`）。具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerMultilinearFromNecSuf.lean`。

クロネッカー積は `KroneckerTranspose.lean` の `kroneckerProdOf`（`(A_1⊠⋯⊠A_M)_{s,t} := ∏_k (A_k)_{s_k t_k}`）、
数ベクトルのクロネッカー積はここで置く `vecKronOf`（`(v_1⊠⋯⊠v_M)_s := ∏_k (v_k)_{s_k}`）である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `siteProd_update_apply`（`⊠` の定義を、第 `j` 因子とそれ以外の積に分けて読む） | `kroneckerProdOf_update_apply` |
| `siteProd_update_sum_smul_apply` の 5 段（`⊠` の定義 → 成分ごと → 分配律 → `⊠` の定義 → 成分ごと） | `kroneckerProdOf_update_sum_smul_apply` の 5 段（同じ並び） |
| `siteProd_update_sum_smul`（すべての成分が一致する） | `kroneckerProdOf_update_sum_smul` |
| `siteProd_update_smul`（`r = 1`） | `kroneckerProdOf_update_smul` |
| 数ベクトルの `vecKron_update_apply`・`vecKron_update_sum_smul_apply` の 5 段・`vecKron_update_sum_smul`・`vecKron_update_smul` | `vecKronOf_update_apply`・`vecKronOf_update_sum_smul_apply` の 5 段・`vecKronOf_update_sum_smul`・`vecKronOf_update_smul` |

## 何が効いているか / 効いていないか

- 係数の型 `R` に置いたのは `CommSemiring` である。効いているのは次のものである。
  - 積の可換則と結合則（1 段目・4 段目）: 全因子の積 `∏_k` から第 `j` 因子を取り出して右端へ置く（`Finset.prod_erase_mul`）。
    `j` が並びの途中にあるとき、第 `j` 因子を右端へ動かすには可換則が要る。ただしこの段の可換則・結合則は、
    `Finset.prod` が並びに依らない積を定めるのに `CommMonoid` を要求することと切り離せず、外した場合の反例は示していない。
  - 分配律（3 段目）: `(∏_{k≠j}) · Σ_a c_a(B_a)_{s_jt_j} = Σ_a (∏_{k≠j}) · (c_a(B_a)_{s_jt_j})`（`Finset.mul_sum`。
    `NonUnitalNonAssocSemiring` を要求する）。外した場合の反例は示していない。
  - 3 段目で `c_a` を `∏_{k≠j}` の前へ出す `p · (c q) = c · (p q)`（`mul_left_comm`、可換則と結合則）。
    この段の可換則は外せない。係数が可換でなければ、成分を左から掛ける積で定義し直しても主張は偽になる: `R := Mat(2, ℂ)`、
    `α = β := Unit`、サイトを 2 つ、`j` を 2 つ目（右端）のサイトとし（1 段目の並べ替えが効かない形）、1 つ目の因子の唯一の成分を
    `E_{12}`、`t` を 1 元、`c := E_{21}`、`B := I` と取ると、左辺の成分は `E_{12}(E_{21}I) = E_{11}`、
    右辺の成分は `E_{21}(E_{12}I) = E_{22}` で一致しない。
  - 乗法の単位元: `ι` が `j` だけのとき（人手の `M = 1`）、1 段目・4 段目の `∏_{k≠j}` は空積 `1` で、`1 · C = C` を使う。
- 加法の単位元と `0` との積は、`t` が空のときの両辺（どちらも `0`）を述べるのに要るだけで、`t` が空でなければ鎖のどの段でも使わない
  （`Finset.sum` が加法可換モノイドを要求し、`Finset.mul_sum` が `NonUnitalNonAssocSemiring` を要求する）。
- 加法の逆元（環であること）、体であること、係数が ℂ であることは効いていない。
- 因子の添字 `α`・`β` は任意の型で、正方であることも 2 次であることも効いていない（成分を読むだけである）。
- サイトの添字 `ι` に置いたのは `Fintype`（積を取る）と `DecidableEq`（第 `j` 因子を置き換える `Function.update` と、
  `j` を除いた集合 `Finset.univ.erase j`）だけで、`Fin M` の順序は効いていない。
- スカラー倍の添字 `κ` は任意の型の有限部分集合 `t` で、人手の `r ≥ 1` は効いていない。
-/
import Ising2D.NecSuf.KroneckerTranspose
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι α β κ R : Type*} [Fintype ι] [DecidableEq ι] [CommSemiring R]

/-- **`⊠` の定義を第 `j` 因子とそれ以外の積に分けて読む**（具体版 `siteProd_update_apply`）。 -/
theorem kroneckerProdOf_update_apply (x : ι → Matrix α β R) (j : ι) (C : Matrix α β R)
    (s : ι → α) (u : ι → β) :
    kroneckerProdOf (Function.update x j C) s u
      = (∏ k ∈ Finset.univ.erase j, x k (s k) (u k)) * C (s j) (u j) := by
  show ∏ k, Function.update x j C k (s k) (u k) = _
  rw [← Finset.prod_erase_mul _ _ (Finset.mem_univ j), Function.update_self]
  congr 1
  exact Finset.prod_congr rfl fun k hk => by
    rw [Function.update_of_ne (Finset.ne_of_mem_erase hk)]

/-- **成分の鎖**（具体版 `siteProd_update_sum_smul_apply` の 5 段）。 -/
theorem kroneckerProdOf_update_sum_smul_apply (x : ι → Matrix α β R) (j : ι)
    (t : Finset κ) (c : κ → R) (B : κ → Matrix α β R) (s : ι → α) (u : ι → β) :
    kroneckerProdOf (Function.update x j (∑ a ∈ t, c a • B a)) s u
      = (∑ a ∈ t, c a • kroneckerProdOf (Function.update x j (B a))) s u :=
  calc kroneckerProdOf (Function.update x j (∑ a ∈ t, c a • B a)) s u
      = (∏ k ∈ Finset.univ.erase j, x k (s k) (u k)) * (∑ a ∈ t, c a • B a) (s j) (u j) :=
        kroneckerProdOf_update_apply x j _ s u                              -- `⊠` の定義
    _ = (∏ k ∈ Finset.univ.erase j, x k (s k) (u k)) * (∑ a ∈ t, c a * B a (s j) (u j)) := by
        rw [Matrix.sum_apply]
        simp only [Matrix.smul_apply, smul_eq_mul]                           -- 和・スカラー倍は成分ごと
    _ = ∑ a ∈ t, c a * ((∏ k ∈ Finset.univ.erase j, x k (s k) (u k)) * B a (s j) (u j)) := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun a _ => mul_left_comm _ _ _            -- 分配律（と可換則・結合則）
    _ = ∑ a ∈ t, c a * kroneckerProdOf (Function.update x j (B a)) s u :=
        Finset.sum_congr rfl fun a _ => by rw [kroneckerProdOf_update_apply] -- `⊠` の定義
    _ = (∑ a ∈ t, c a • kroneckerProdOf (Function.update x j (B a))) s u := by
        rw [Matrix.sum_apply]
        simp only [Matrix.smul_apply, smul_eq_mul]                           -- 和・スカラー倍は成分ごと

/-- **`A_1⊠⋯⊠(Σ_a c_aB_a)⊠⋯⊠A_M = Σ_a c_a(A_1⊠⋯⊠B_a⊠⋯⊠A_M)`**（具体版 `siteProd_update_sum_smul`）。 -/
theorem kroneckerProdOf_update_sum_smul (x : ι → Matrix α β R) (j : ι)
    (t : Finset κ) (c : κ → R) (B : κ → Matrix α β R) :
    kroneckerProdOf (Function.update x j (∑ a ∈ t, c a • B a))
      = ∑ a ∈ t, c a • kroneckerProdOf (Function.update x j (B a)) :=
  Matrix.ext (kroneckerProdOf_update_sum_smul_apply x j t c B)   -- すべての成分が一致する

/-- **`r = 1` の場合**（具体版 `siteProd_update_smul`）。 -/
theorem kroneckerProdOf_update_smul (x : ι → Matrix α β R) (j : ι) (c : R) (A : Matrix α β R) :
    kroneckerProdOf (Function.update x j (c • A)) = c • kroneckerProdOf (Function.update x j A) := by
  have h := kroneckerProdOf_update_sum_smul x j (Finset.univ : Finset (Fin 1)) (fun _ => c) (fun _ => A)
  simpa only [Finset.univ_unique, Finset.sum_singleton] using h

/-- 数ベクトルのクロネッカー積 `(v_1⊠⋯⊠v_M)_s := ∏_k (v_k)_{s_k}`（具体版の `vecKron` の成分の式）。 -/
def vecKronOf (v : ι → α → R) : (ι → α) → R :=
  fun s => ∏ k, v k (s k)

/-- 数ベクトルの「`⊠` の定義を第 `j` 因子とそれ以外の積に分けて読む」（具体版 `vecKron_update_apply`）。 -/
theorem vecKronOf_update_apply (v : ι → α → R) (j : ι) (w : α → R) (s : ι → α) :
    vecKronOf (Function.update v j w) s = (∏ k ∈ Finset.univ.erase j, v k (s k)) * w (s j) := by
  show ∏ k, Function.update v j w k (s k) = _
  rw [← Finset.prod_erase_mul _ _ (Finset.mem_univ j), Function.update_self]
  congr 1
  exact Finset.prod_congr rfl fun k hk => by
    rw [Function.update_of_ne (Finset.ne_of_mem_erase hk)]

/-- 数ベクトルの成分の鎖（具体版 `vecKron_update_sum_smul_apply` の 5 段）。 -/
theorem vecKronOf_update_sum_smul_apply (v : ι → α → R) (j : ι)
    (t : Finset κ) (c : κ → R) (w : κ → α → R) (s : ι → α) :
    vecKronOf (Function.update v j (∑ a ∈ t, c a • w a)) s
      = (∑ a ∈ t, c a • vecKronOf (Function.update v j (w a))) s :=
  calc vecKronOf (Function.update v j (∑ a ∈ t, c a • w a)) s
      = (∏ k ∈ Finset.univ.erase j, v k (s k)) * (∑ a ∈ t, c a • w a) (s j) :=
        vecKronOf_update_apply v j _ s                                       -- `⊠` の定義
    _ = (∏ k ∈ Finset.univ.erase j, v k (s k)) * (∑ a ∈ t, c a * w a (s j)) := by
        rw [Finset.sum_apply]
        simp only [Pi.smul_apply, smul_eq_mul]                               -- 和・スカラー倍は成分ごと
    _ = ∑ a ∈ t, c a * ((∏ k ∈ Finset.univ.erase j, v k (s k)) * w a (s j)) := by
        rw [Finset.mul_sum]
        exact Finset.sum_congr rfl fun a _ => mul_left_comm _ _ _            -- 分配律（と可換則・結合則）
    _ = ∑ a ∈ t, c a * vecKronOf (Function.update v j (w a)) s :=
        Finset.sum_congr rfl fun a _ => by rw [vecKronOf_update_apply]       -- `⊠` の定義
    _ = (∑ a ∈ t, c a • vecKronOf (Function.update v j (w a))) s := by
        rw [Finset.sum_apply]
        simp only [Pi.smul_apply, smul_eq_mul]                               -- 和・スカラー倍は成分ごと

/-- 数ベクトルの `v_1⊠⋯⊠(Σ_a c_aw_a)⊠⋯⊠v_M = Σ_a c_a(v_1⊠⋯⊠w_a⊠⋯⊠v_M)`（具体版 `vecKron_update_sum_smul`）。 -/
theorem vecKronOf_update_sum_smul (v : ι → α → R) (j : ι)
    (t : Finset κ) (c : κ → R) (w : κ → α → R) :
    vecKronOf (Function.update v j (∑ a ∈ t, c a • w a))
      = ∑ a ∈ t, c a • vecKronOf (Function.update v j (w a)) :=
  funext (vecKronOf_update_sum_smul_apply v j t c w)   -- すべての成分が一致する

/-- 数ベクトルの `r = 1` の場合（具体版 `vecKron_update_smul`）。 -/
theorem vecKronOf_update_smul (v : ι → α → R) (j : ι) (c : R) (w : α → R) :
    vecKronOf (Function.update v j (c • w)) = c • vecKronOf (Function.update v j w) := by
  have h := vecKronOf_update_sum_smul v j (Finset.univ : Finset (Fin 1)) (fun _ => c) (fun _ => w)
  simpa only [Finset.univ_unique, Finset.sum_singleton] using h

end Ising2D.NecSuf
