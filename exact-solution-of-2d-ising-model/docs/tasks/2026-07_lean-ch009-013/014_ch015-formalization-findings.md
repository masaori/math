# 章 015「半整数運動量における `A(θ~)` の対角化」の Lean 形式化で分かったこと

対象: `structured-latex/content/015_A_theta_tilde_diagonalization.ts`（9 主張）。
形式化の成果物は `lean/Ising2D/Part015/`（具体版）と `lean/Ising2D/Abstract/`
（`OddModePhase.lean` / `NegConjPair.lean` / `TwoByTwoSkew.lean` / `GammaDetIdentity.lean` /
`ArcoshExp.lean`。抽象版）。一覧は `lean/docs/ch015-formalization.md`。

**結論: 9 主張はすべて Lean で閉じた。人手証明の誤り（偽の主張）は見つからなかった。**
以下は誤りではないが、本文を触る担当者が知っておくべき 3 点である。

---

## 1. `gamma_2_theta_tilde_nonzero` の仮定 `μ ∈ 𝓜̌` は必要以上に強い（誤りではない）

**どの主張のどの条件か**: `Athetatilde_002_claim_gamma2_nonzero`（ラベル
`gamma_2_theta_tilde_nonzero`）の statement は `μ ∈ 𝓜̌ = {1,…,M}`（`def_check_index_set`）と
`M ∈ ℤ_{≥2}` を仮定している。

**一次情報**: Lean 側の

```
theorem gamma2_thetaTilde_ne_zero (P : IsingParam) {M : ℕ} (hM : M ≠ 0) (μ : ℤ) :
    gamma2 P.const (thetaTilde M μ) ≠ 0
```

（`lean/Ising2D/Part015/Claim002_Gamma2TildeNonzero.lean`）は **`μ ∈ ℤ` 全体・`M ≥ 1`** で
証明できている。人手証明の Step 1〜Step 4 を辿っても `μ` の範囲は一度も使われない
（使うのは `M θ~_μ = (2μ-1)π` の右辺が `π` の**奇数**倍であることと、`c_1, s_1, c_2, s_2^* > 0` だけ）。
`M ≥ 2` も `M ≠ 0` で足りる。

**扱い**: 本文は他章と量化範囲を揃える方針（2026-07-27 に 013〜017 章を `𝓜̌` へ揃えた経緯）で
`μ ∈ 𝓜̌` としているので、**このままでよい**。Lean 側には人手証明と 1 対 1 に対応する
`𝓜̌` 版（`gamma2_thetaTilde_ne_zero_checkIndex`）も置いてある。

## 2. `det_A_theta_tilde` は双対関係 (iii) が無いと成り立たない（本文は明示しており、穴ではない）

**どの主張のどの条件か**: `Athetatilde_006_claim_det_A`（ラベル `det_A_theta_tilde`）Step 0 の
(iii) `c_2 s_2^* = c_2^*`（`duality_c2_star_eq_s2_star_c2`）。

**一次情報**: `Ising2D.Abstract.gamma_det_identity`（`lean/Ising2D/Abstract/GammaDetIdentity.lean`）は
`det A = 1` が **(0) `u^2+v^2=1`, (i) `c_1^2-s_1^2=1`, (ii) `(c_2^*)^2-(s_2^*)^2=1`, (iii) `c_2s_2^*=c_2^*`
の 4 本だけからなる可換環の多項式恒等式**であることを示す。(iii) を落とすと `u`（= `cos θ`）の
1 次の項が相殺せず、`det A` は `θ` に依存して `1` にならない。

**扱い**: 015 章の本文は Step 0 で (iii) を明示的に引用しているので**問題なし**。
008 章の `det_A_theta` では (iii) が明示されていない（`lean/README.md` の「原文の問題」表を参照）が、
015 章はその点が改善されている。Lean 側では `IsingParam` が `K_1, K_2, K_2^*` を独立な正数として
持つだけなので、(iii) は仮定 `hdual` として引き回している（数学的に必要な仮定であり、
未形式化に由来する穴ではない）。

## 3. (3)(4)(5) の複素平方根は、形式化では「2 乗の等式」に退化する

**どの主張のどの条件か**: `Athetatilde_003_claim_relation_of_gamma2`（ラベル
`relation_of_gamma_2_theta_tilde`）の (3) `arg^{[0,2π)}(γ_2γ_2(-θ~)) = π`、
(4) `√(-γ_2γ_2(-θ~)) = |γ_2|`、(5) `√(γ_2γ_2(-θ~)) = i|γ_2|`。

**一次情報**: Lean 側は複素平方根 `def_sqrt_cc` を導入せず、
`sq_absGamma2 : (|γ_2|)^2 = -(γ_2(θ~)γ_2(-θ~))` と
`sq_I_absGamma2 : (i|γ_2|)^2 = γ_2(θ~)γ_2(-θ~)` として述べた
（`lean/Ising2D/Part015/Claim003_RelationGamma2Tilde.lean`。抽象版は
`Ising2D/Abstract/NegConjPair.lean`）。後段（固有値・固有ベクトル・対角化）が実際に使うのは
この 2 つの値の 2 乗だけであり、この形にすると **(3)（偏角の計算）が不要になる**。

**扱い**: 本文を変える必要はない（人手証明の読者にとっては `arg` 経由の説明が自然）。
ただし「(3) は (4)(5) を出すための中間段階であって、後段が (3) を直接使ってはいない」ことは
本文の依存関係を整理するときの参考になる。
