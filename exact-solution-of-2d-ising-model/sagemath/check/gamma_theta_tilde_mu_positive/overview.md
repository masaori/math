# SageMath Check: gamma_theta_tilde_mu_positive

## 対象

**対象ラベル**: `gamma_theta_tilde_mu_positive`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `Athetatilde_008_claim_gamma_theta_tilde_positive`（γ(θ̃_μ) > 0）
- 範囲: 証明の準備（g > 1、t ≥ 0、cosh t = g）、背理の鎖の 7 行、主張

記号は証明のとおり g = γ_1(θ̃_μ)、t = γ(θ̃_μ) = arccosh(g)。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備: g > 1（`gamma1_gt_1_theta_tilde`） | `check_values_and_claim.sage` | 具体値で g > 1 | **PASS** | 厳密（AA） |
| 準備: cosh t = g（`arccosh_properties` (2)） | 同上 | `def_arccosh` の w := g + √(g^2 − 1) について (w + 1/w)/2 = g | **PASS** | 厳密（AA） |
| 準備: t ≥ 0（`arccosh_properties` (1)） | 同上 | t = log w を囲むボールの下端 ≥ 0 | **PASS** | ボール（ℝ への脱出） |
| 背理の鎖の 6 本の等号（`arccosh_properties` (2)・仮定 t = 0・`def_cosh_sinh`・−0 = 0・`scalar_exp_zero`・ℝ の四則） | `check_generic_chain.sage` | 各行の値を不定元に置き、隣り合う行の差がその行の根拠の関係 1 本のイデアルに入ること（関係なしでは異なる対照つき） | **PASS** | 厳密 |
| 主張 | `check_values_and_claim.sage` | 具体値で t を囲むボールの下端 > 0（0 を含まない）。対照: g = 1 では w = 1、t = log 1 = 0 で狭義の不等号が成り立たない | **PASS** | 140 組 |

## 計算の帰属と範囲

- 一般の点は `QQ` 上の多項式環（浮動小数点なし）。
- 具体値は `gamma1_gt_1_theta_tilde` の検算の準備（`../gamma1_gt_1_theta_tilde/_prelude.sage`）と同じ 4 組の結合定数 × M_col = 2..8 の全 μ（140 組）。
  g と w は `AA` の元として厳密に扱う。
- **浮動小数点を使う箇所**: t = log w の値（実対数。ℝ への脱出）だけを `RealBallField(200)` のボールで囲む。ボールは丸めの誤差を半径に含むので、
  下端が正であれば t > 0 は確定する。log の単調性を使って w > 1 から t > 0 を言う代わりに、値そのものを囲んで確かめた。

## 確かめられない行と理由

- 実数の exp・log そのもの（部分和の極限）は扱わない。`scalar_exp_zero` の当てはめは exp 0 の値を不定元に置いた関係として確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh gamma_theta_tilde_mu_positive
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
