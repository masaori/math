/-
# `det A = 1` の正体は可換環の多項式恒等式である（**抽象版**）

対応する人手証明のラベル: `det_A_theta_tilde`
（`structured-latex/content/015_A_theta_tilde_diagonalization.ts` の
`Athetatilde_006_claim_det_A`。008 章の `det_A_theta` も同じ計算）

具体版: `Ising2D/Part015/Claim006_DetATilde.lean`
（既存の `Ising2D.det_AMat_eq_one`（`Part008/Claim027_EigenATheta.lean`）も具体版）。

## この主張に本質的に効いている構造は何か（具体版が過剰な構造を要求していないかの検査）

人手証明の Step 1〜Step 5 は
`γ_1(θ)^2 + γ_2(θ)γ_2(-θ) = 1` を、`u = cos θ`, `v = sin θ` と置いて

  (0) `u^2 + v^2 = 1`,
  (i) `c_1^2 - s_1^2 = 1`,
  (ii) `(c_2^*)^2 - (s_2^*)^2 = 1`,
  (iii) `c_2 s_2^* = c_2^*`

の 4 本だけから導いている。したがってこの主張に効いているのは
**可換環の 4 本の関係式だけ**であり、

* `u, v` が三角関数であること（`θ` の存在自体）
* `θ` が半整数運動量か整数運動量か
* 実数であること・複素数であること
* `c_1 = cosh 2K_1` などの双曲線関数としての出自
* `e^{iθ}e^{-iθ} = 1`（`γ_2(θ)γ_2(-θ)` を実部表示に直す段で使うが、
  それは下の `γ_2` の積の**表示**の話であって、恒等式そのものには現れない）

は一切効いていない。とくに (iii)（双対関係の帰結）を落とすと恒等式は成り立たない
（`u` の 1 次の項が相殺しなくなる）。これは 008 章の `det_A_theta` について
`Part008/Claim027_EigenATheta.lean` が指摘している原文の穴と同じ構造である。
-/
import Mathlib.Algebra.Ring.Basic
import Mathlib.Tactic.LinearCombination

namespace Ising2D.Abstract

/-- **抽象版**: `det A = 1` の中身は**任意の可換環の恒等式**である。

`γ_1 = c_1c_2^* - s_1s_2^* u`、`γ_2(θ)γ_2(-θ) = -(s_2^*)^2((c_1u - s_1c_2)^2 + v^2)`
と置いたときの `γ_1^2 + γ_2γ_2(-θ) = 1`。 -/
theorem gamma_det_identity {R : Type*} [CommRing R]
    (c1 s1 c2 c2star s2star u v : R)
    (hpy : u ^ 2 + v ^ 2 = 1)
    (h1 : c1 ^ 2 - s1 ^ 2 = 1)
    (h2 : c2star ^ 2 - s2star ^ 2 = 1)
    (h3 : c2 * s2star = c2star) :
    (c1 * c2star - s1 * s2star * u) ^ 2
      - s2star ^ 2 * ((c1 * u - s1 * c2) ^ 2 + v ^ 2) = 1 := by
  linear_combination
    (c2star ^ 2 - s2star ^ 2 * u ^ 2) * h1
      + h2
      + (-(s2star ^ 2)) * hpy
      + (2 * c1 * s1 * s2star * u - s1 ^ 2 * (c2 * s2star + c2star)) * h3

end Ising2D.Abstract
