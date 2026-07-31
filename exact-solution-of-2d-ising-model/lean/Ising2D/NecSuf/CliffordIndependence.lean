/-
# 必要十分版: Clifford 関係を満たす族は線型独立

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル:

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `Z_Y_linearly_independent` | `Ising2D/Part004/Claim001_ZYLinearlyIndependent.lean` |
| （使う反交換関係）`anticommutator_of_Z_and_Y` | `Ising2D/Part006/Claim000_AnticommutatorZY.lean` |

具体版を本ファイルの必要十分版の特殊化として導出したものは
`Ising2D/Part004/Claim001_ZYLinearlyIndependentFromNecSuf.lean` にある。

## 必要十分版が何を明らかにするか

`{Z_1, …, Z_M, Y_1, …, Y_M}` の線型独立性に効いているのは、次の 3 つだけである。

1. **Clifford 関係** `[e_a, e_b]₊ = 2 δ_{ab} · 1`。
2. **スカラーが台の代数へ忠実に入ること** `s · 1 = 0 → s = 0`（`hfaithful`）。
   具体版ではこれが「単位行列の対角成分を見る」という一行にあたる。
3. **`2` が零因子でないこと** `s * 2 = 0 → s = 0`（`hregular`）。

効いていないもの: 台が**行列**であること、**複素数**上であること、テンソル冪であること、
`Z, Y` の具体形（Jordan–Wigner 文字列）、台の可換性、有限次元性、係数環が体であること。
係数は任意の可換環でよく、台は任意の環でよい。
-/
import Ising2D.Part000.Claim046_CommutatorViaAnticommutators
import Mathlib.LinearAlgebra.LinearIndependent.Defs

namespace Ising2D.NecSuf

variable {S A : Type*} [CommRing S] [Ring A] [Algebra S A]

/-- **Clifford 関係の核心の一行**: 線型結合と 1 つの生成元の反交換子は、
その生成元の係数だけを取り出す。

`[∑ₐ gₐ eₐ, e_b]₊ = ∑ₐ gₐ [eₐ, e_b]₊ = (g_b · 2) · 1`。 -/
theorem acomm_sum_smul_clifford_left {ι : Type*} [Fintype ι] [DecidableEq ι]
    (e : ι → A) (g : ι → S)
    (hcl : ∀ a b, acomm (e a) (e b) = (if a = b then (2 : S) else 0) • (1 : A))
    (b : ι) : acomm (∑ a, g a • e a) (e b) = (g b * 2) • (1 : A) := by
  classical
  rw [acomm_sum_smul_left, Finset.sum_eq_single_of_mem b (Finset.mem_univ b)]
  · rw [hcl, if_pos rfl, smul_smul]
  · intro a _ hab
    rw [hcl, if_neg hab, zero_smul, smul_zero]

/-- **必要十分版の本体**: Clifford 関係 `[e_a, e_b]₊ = 2 δ_{ab} · 1` を満たす族は線型独立。

仮定は Clifford 関係のほかに、スカラーの忠実性 `hfaithful` と `2` の非零因子性 `hregular`
だけである（台が行列であることも、係数が複素数であることも使わない）。 -/
theorem linearIndependent_of_clifford_necSuf {ι : Type*} [Fintype ι] [DecidableEq ι]
    (e : ι → A)
    (hcl : ∀ a b, acomm (e a) (e b) = (if a = b then (2 : S) else 0) • (1 : A))
    (hfaithful : ∀ s : S, s • (1 : A) = 0 → s = 0)
    (hregular : ∀ s : S, s * 2 = 0 → s = 0) :
    LinearIndependent S e := by
  classical
  rw [Fintype.linearIndependent_iff]
  intro g hg b
  have hsum := acomm_sum_smul_clifford_left e g hcl b
  have hzero : (g b * 2) • (1 : A) = 0 := by
    rw [← hsum, hg, acomm, zero_mul, mul_zero, add_zero]
  exact hregular _ (hfaithful _ hzero)

end Ising2D.NecSuf
