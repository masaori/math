/-
# 抽象版: 反交換関係を満たす 2 元ずつの線型結合の反交換子（`ψ` の CAR の骨格）

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明（具体版は下記のファイルにあり、本ファイルの抽象版からの特殊化として
`Ising2D/Part008/Claim032_AnticommutatorPsiAbstract.lean` で導出される）:

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `<anticommutator_of_psi>` | `Ising2D/Part008/Definition030_Fermi.lean` |
| （係数の由来）`<def_fermi>` | 同上 |

## 抽象版が何を明らかにするか

* 原文 `anticommutator_of_psi` の a), b), c) の計算に効いているのは
  **`hat(Z)_μ^{(-)}, hat(Y)_μ` が満たす 4 本の反交換関係だけ**である
  （`acomm_lincomb_clifford`）。`hat(Z)`, `hat(Y)` の具体形（フーリエ和・Jordan–Wigner 文字列）も、
  それが複素行列であることも、テンソル冪であることも一切効いていない。
* さらに **`M`・`δ^M_{μ+ν,0}`・`γ_2` も効いていない。** それらが入ってくるのは
  「反交換子の右辺のスカラー `D`」と「係数 `p, q`」を通してだけで、結論に必要なのは
  スカラーの恒等式 2 本（`(p p' + q q')·D = 0` と `(-(p p') + q q')·D = δ`）である
  （`car_of_coeffs`）。
* 係数の住む場所は ℂ である必要がなく、**任意の可換環**でよい。
  台となる代数も**任意の環**でよい（可換性・有限次元性・ノルム・体であることは不要）。

## 記法

原文の `ψ_μ^†` にあたるのが `p · z + q · y`、`ψ_μ` にあたるのが `(-p) · z + q · y`。
第 1 係数の符号だけが反転する形になるのは、原文 `def_fermi` の
`±i√(γ_2(θ_μ)γ_2(-θ_μ))` の複号がそこにしか現れないからである。
-/
import Ising2D.Part000.Claim046_CommutatorViaAnticommutators
import Mathlib.Algebra.Algebra.Basic
import Mathlib.Tactic.Module

namespace Ising2D.Abstract

variable {S A : Type*} [CommRing S] [Ring A] [Algebra S A]

/-- **反交換子の双線型性**（原文 `anticommutator_of_psi` の「反交換子の双線型性より」の行）。

係数環 `S` は任意の可換環でよく、台 `A` は任意の環でよい。 -/
theorem acomm_lincomb (p q p' q' : S) (z y z' y' : A) :
    acomm (p • z + q • y) (p' • z' + q' • y')
      = (p * p') • acomm z z' + (p * q') • acomm z y'
        + (q * p') • acomm y z' + (q * q') • acomm y y' := by
  simp only [acomm, add_mul, mul_add, smul_add, smul_mul_assoc, mul_smul_comm, smul_smul]
  module

/-- **抽象版の本体**: `z, y, z', y'` が
`[z, z']₊ = D·1`, `[z, y']₊ = 0`, `[y, z']₊ = 0`, `[y, y']₊ = D·1`
を満たすとき、線型結合どうしの反交換子は `((p p' + q q')·D)·1` である。

原文 `anticommutator_of_psi` の a), b), c) の計算はすべてこの 1 本に帰着する。 -/
theorem acomm_lincomb_clifford (p q p' q' D : S) (z y z' y' : A)
    (hzz : acomm z z' = D • (1 : A)) (hzy : acomm z y' = 0)
    (hyz : acomm y z' = 0) (hyy : acomm y y' = D • (1 : A)) :
    acomm (p • z + q • y) (p' • z' + q' • y') = ((p * p' + q * q') * D) • (1 : A) := by
  rw [acomm_lincomb, hzz, hzy, hyz, hyy, smul_zero, smul_zero, add_zero, add_zero,
    smul_smul, smul_smul, ← add_smul]
  congr 1
  ring

/-- **抽象版の CAR（正準反交換関係）**。

必要な仮定は 4 本の反交換関係のほかには、**係数についてのスカラー恒等式 2 本だけ**である:
`hzero`（消える方）と `hone`（残る方）。 -/
theorem car_of_coeffs (p q p' q' D δ : S) (z y z' y' : A)
    (hzz : acomm z z' = D • (1 : A)) (hzy : acomm z y' = 0)
    (hyz : acomm y z' = 0) (hyy : acomm y y' = D • (1 : A))
    (hzero : (p * p' + q * q') * D = 0)
    (hone : (-(p * p') + q * q') * D = δ) :
    acomm (p • z + q • y) (p' • z' + q' • y') = 0
      ∧ acomm (p • z + q • y) ((-p') • z' + q' • y') = δ • (1 : A)
      ∧ acomm ((-p) • z + q • y) ((-p') • z' + q' • y') = 0 := by
  refine ⟨?_, ?_, ?_⟩
  · rw [acomm_lincomb_clifford p q p' q' D z y z' y' hzz hzy hyz hyy, hzero, zero_smul]
  · rw [acomm_lincomb_clifford p q (-p') q' D z y z' y' hzz hzy hyz hyy]
    rw [show (p * -p' + q * q') * D = (-(p * p') + q * q') * D by ring, hone]
  · rw [acomm_lincomb_clifford (-p) q (-p') q' D z y z' y' hzz hzy hyz hyy]
    rw [show (-p * -p' + q * q') * D = (p * p' + q * q') * D by ring, hzero, zero_smul]

end Ising2D.Abstract
