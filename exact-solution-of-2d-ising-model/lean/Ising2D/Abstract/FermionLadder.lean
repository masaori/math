/-
# 抽象版: CAR から出る「生成消滅対の和」との交換子（`X̌` の梯子作用）

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル: `action_of_T_check_Vprime_on_check_psi`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_006_claim_action_T_check_Vprime`。具体版は
`Ising2D/Part016/Claim006_ActionTCheckVprime.lean`）。

対応する人手証明の Step は次のとおり。

| 人手証明 | 本ファイル |
| --- | --- |
| Step 1（`[ψ̌_ν^† ψ̌_{M+1-ν}, ψ̌_μ^†] = δ_{μν} ψ̌_ν^†`） | `lie_creAnn_cre` |
| Step 1'（`[ψ̌_ν^† ψ̌_{M+1-ν}, ψ̌_μ] = -δ_{μ,M+1-ν} ψ̌_{M+1-ν}`） | `lie_creAnn_ann` |
| Step 2（`[X̌, ψ̌_μ^†] = γ_μ ψ̌_μ^†`） | `lie_carHam_cre` |
| Step 2'（`[X̌, ψ̌_μ] = -γ_μ ψ̌_μ`） | `lie_carHam_ann` |

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

* Step 1 / Step 1' に効いているのは**恒等式 `[a b, c] = a [b,c]₊ - [a,c]₊ b`
  （`Ising2D.commutator_via_anticommutators`、任意の環）と、反交換子の値が
  「係数のスカラー倍の `1`」であることだけ**である。
  `ψ̌` の具体形（`Ž, Y̌` の線型結合）も、複素行列であることも、テンソル冪であることも、
  `M`・`γ_2`・`θ̃` も一切効いていない。
* Step 2 / Step 2' に効いているのは、それに加えて
  **添字型が有限であること**と、`½ I` の項が**中心の元**であること（交換子に寄与しない）だけである。
  減じる量は `½` である必要すらなく、任意のスカラー `κ` でよい（`carHam` の `κ`）。
* 人手証明が `μ ∈ 𝓜̌` に絞ることで「合同式を解く段」を消しているのは、
  抽象版では**「反交換子の値がクロネッカーのデルタになる」という仮定 `hed` / `hde` の形**に
  そのまま吸収される。すなわち原文の「場合分けが要らない」という改善は、
  **添字集合の取り方だけの問題であって、代数的な内容ではない**ことが分かる。
* 係数の住む場所は ℂ である必要がなく、**任意の可換環**でよい。
  台となる代数も**任意の環**でよい（可換性・有限次元性・ノルム・体であることは不要）。

## 記法

`d : ι → A` が生成演算子（原文の `ψ̌^†`）、`e : ι → A` が消滅演算子（原文の `ψ̌`）、
`σ : ι → ι` が対になる添字の対合（原文の `μ ↦ M+1-μ`）である。
-/
import Ising2D.Part000.Claim046_CommutatorViaAnticommutators
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Tactic.NoncommRing

namespace Ising2D.Abstract

variable {S A : Type*} [CommRing S] [Ring A] [Algebra S A]

/-! ## Step 1 / Step 1': 1 項ぶんの交換子 -/

/-- **人手証明 Step 1 の抽象版**: `[d · a, c] = δ · d`。

仮定は反交換子 2 本だけ（`[a, c]₊ = δ·1`, `[d, c]₊ = 0`）。 -/
theorem lie_creAnn_cre (d a c : A) (δ : S)
    (hac : acomm a c = δ • (1 : A)) (hdc : acomm d c = 0) :
    (d * a) * c - c * (d * a) = δ • d := by
  rw [commutator_via_anticommutators, hac, hdc, zero_mul, sub_zero,
    mul_smul_comm, mul_one]

/-- **人手証明 Step 1' の抽象版**: `[d · a, b] = -(δ · a)`。

仮定は反交換子 2 本だけ（`[a, b]₊ = 0`, `[d, b]₊ = δ·1`）。 -/
theorem lie_creAnn_ann (d a b : A) (δ : S)
    (hab : acomm a b = 0) (hdb : acomm d b = δ • (1 : A)) :
    (d * a) * b - b * (d * a) = -(δ • a) := by
  rw [commutator_via_anticommutators, hab, hdb, mul_zero, zero_sub,
    smul_mul_assoc, one_mul]

/-! ## Step 2 / Step 2': 和との交換子 -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 原文 `def_check_Vprime` の `X̌ = Σ_ν γ_ν (ψ̌_ν^† ψ̌_{σν} - ½ I)` の抽象版。

`κ` は原文の `½` にあたるが、値は何でもよい（中心の元なので交換子に寄与しない）。 -/
def carHam (g : ι → S) (d e : ι → A) (σ : ι → ι) (κ : S) : A :=
  ∑ ν : ι, g ν • (d ν * e (σ ν) - κ • (1 : A))

/-- **人手証明 Step 2 の抽象版**: `[X̌, d μ] = g μ · d μ`。 -/
theorem lie_carHam_cre (g : ι → S) (d e : ι → A) (σ : ι → ι) (κ : S) (μ : ι)
    (hed : ∀ ν : ι, acomm (e (σ ν)) (d μ) = (if ν = μ then (1 : S) else 0) • (1 : A))
    (hdd : ∀ ν : ι, acomm (d ν) (d μ) = 0) :
    carHam g d e σ κ * d μ - d μ * carHam g d e σ κ = g μ • d μ := by
  have hterm : ∀ ν : ι,
      (g ν • (d ν * e (σ ν) - κ • (1 : A))) * d μ
        - d μ * (g ν • (d ν * e (σ ν) - κ • (1 : A)))
        = (g ν * (if ν = μ then (1 : S) else 0)) • d ν := by
    intro ν
    have h := lie_creAnn_cre (d ν) (e (σ ν)) (d μ) _ (hed ν) (hdd ν)
    have hsplit :
        (g ν • (d ν * e (σ ν) - κ • (1 : A))) * d μ
          - d μ * (g ν • (d ν * e (σ ν) - κ • (1 : A)))
          = g ν • ((d ν * e (σ ν)) * d μ - d μ * (d ν * e (σ ν))) := by
      simp only [sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm, smul_sub,
        smul_smul, one_mul, mul_one]
      abel
    rw [hsplit, h, smul_smul]
  rw [carHam, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_congr rfl fun ν _ => hterm ν]
  rw [Finset.sum_eq_single μ]
  · simp
  · intro ν _ hν
    simp [hν]
  · intro h
    exact absurd (Finset.mem_univ μ) h

/-- **人手証明 Step 2' の抽象版**: `[X̌, e μ] = -(g μ · e μ)`。

`σ` が対合（`σ (σ μ) = μ`）であることと、重みが対合で不変（`g (σ μ) = g μ`）であることを使う。
これは原文の `periodicity_of_check_fermi` (3)（`γ(θ̃_{M+1-μ}) = γ(θ̃_μ)`）にあたる。 -/
theorem lie_carHam_ann (g : ι → S) (d e : ι → A) (σ : ι → ι) (κ : S) (μ : ι)
    (hσ : σ (σ μ) = μ) (hg : g (σ μ) = g μ)
    (hee : ∀ ν : ι, acomm (e (σ ν)) (e μ) = 0)
    (hde : ∀ ν : ι, acomm (d ν) (e μ) = (if ν = σ μ then (1 : S) else 0) • (1 : A)) :
    carHam g d e σ κ * e μ - e μ * carHam g d e σ κ = -(g μ • e μ) := by
  have hterm : ∀ ν : ι,
      (g ν • (d ν * e (σ ν) - κ • (1 : A))) * e μ
        - e μ * (g ν • (d ν * e (σ ν) - κ • (1 : A)))
        = (-(g ν * (if ν = σ μ then (1 : S) else 0))) • e (σ ν) := by
    intro ν
    have h := lie_creAnn_ann (d ν) (e (σ ν)) (e μ) _ (hee ν) (hde ν)
    have hsplit :
        (g ν • (d ν * e (σ ν) - κ • (1 : A))) * e μ
          - e μ * (g ν • (d ν * e (σ ν) - κ • (1 : A)))
          = g ν • ((d ν * e (σ ν)) * e μ - e μ * (d ν * e (σ ν))) := by
      simp only [sub_mul, mul_sub, smul_mul_assoc, mul_smul_comm, smul_sub,
        smul_smul, one_mul, mul_one]
      abel
    rw [hsplit, h, smul_neg, smul_smul, ← neg_smul]
  rw [carHam, Finset.sum_mul, Finset.mul_sum, ← Finset.sum_sub_distrib]
  rw [Finset.sum_congr rfl fun ν _ => hterm ν]
  rw [Finset.sum_eq_single (σ μ)]
  · simp [hσ, hg]
  · intro ν _ hν
    simp [hν]
  · intro h
    exact absurd (Finset.mem_univ (σ μ)) h

end Ising2D.Abstract
