# SageMath Check: V2_invertible

## 対象

**対象ラベル**: `V2_invertible`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_claim_V2_invertible`（V_2 の可逆性と逆元）
- 範囲: 準備の鎖 `a = (2s_2)^{M_col/2} ∈ ℝ_{>0}`、二つの鎖の全ての行、最後の所属 `V_2 ∈ R^×` と逆元 `V_2^{-1} = (a^{-1})_C exp(-Y)`（主張の a・Y は 2026-11-02 に証明の中から主張へ上げた）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `a = (2 sinh 2K_2)^{M_col/2} ∈ ℝ_{>0}`、`a^{-1} ∈ ℝ` | `check_prefactor_positive.sage` | `K_2 = log x` で、`s_2` を式 `(x^2 - x^{-2})/2` と `def_cosh_sinh` の `(exp(2K_2) - exp(-2K_2))/2` の二経路で、`a` を平方根の `M_col` 回の積と Sage の `AA` の有理数冪の二経路で作って一致し、正で `aa^{-1} = a^{-1}a = 1`。`K_2` が有理数のときは本文の部分和のボール（`body_real_exp_ball`）で `s_2 > 0`・`a > 0` | **PASS** | `M_col = 1..5`、`x ∈ {2, 3, 3/2}`、`K_2 ∈ {1/4, 1/2, 1}` |
| 二つの鎖の、係数を左・右の因子から出す行、係数をまとめる行、`1_ℂ` を外す行 | `check_scalar_factor_lines.sage` | `exp(±Y)` を独立な不定元の行列、`a_ℂ`・`(a^{-1})_ℂ` を独立な不定元 `a`・`b` に置き、本文の積とスカラー倍の成分の式で組んで隣り合う行が多項式として等しい。Sage の `*` とも一致。対照: `ab = 1` を課さないと `(ab)(EF) ≠ EF` | **PASS** | `n = 2, 4` で厳密等号 |
| 二つの鎖の `a_ℂ(a^{-1})_ℂ = (aa^{-1})_ℂ = (1)_ℂ = 1_ℂ` | 同上 | ℂ を実数の対で持つ `_shared/complex_as_real_pairs.sage`（`definition_of_cc` の積、`inclusion_rr_to_cc` の `r_ℂ = (r, 0)`）で、`(a,0)(a^{-1},0) = (aa^{-1},0) = (1,0)` | **PASS** | `M_col = 1..4`、`x ∈ {2, 3, 3/2}` |
| `exp(Y)exp(-Y) = exp(-(-Y))exp(-Y) = I`、`exp(-Y)exp(Y) = I`（本文の部分和で） | `check_exp_lines.sage` | `H_2` を `def_H2` どおり本文の積と和で作り、`-(-Y) = Y` を厳密に。`exp` の行はボールで I と重なる。対照: `K_2^*` を 2 倍にした `exp(-Y')` では I と交わらない成分がある | **PASS** | `M_col = 1..4`、`K_2^* ∈ {1/4, 1/2, 1}` |
| 二つの鎖の全行（`h` の代入、`V2_exponential_representation` の代入、`a_ℂ`・`(K_2^*)_ℂ` への読み替え、係数を出す行、包含の三行、`exp(-(-Y))`、I）と最後の所属・逆元の形 | `check_claim_exact.sage` | `K_2 = log x` として `V_2` を `def_transfer_matrix` の成分 `x^n` で、`exp(±Y)` をスペクトル射影で `AA` に作り、`V_2 = a exp(Y)`、各行を本文の積とスカラー倍で組んで隣り合う行が等しく I に着くこと、Sage の `inverse` で求めた `V_2^{-1}` が `h` に等しいこと | **PASS** | `M_col = 1..4`、`x ∈ {2, 3, 3/2}` で厳密等号 |

## 計算の帰属と範囲

- `K_2 = log x`（`x ∈ QQ, x > 1`）と選ぶと、`exp(K_2 n) = x^n`、`s_2`・`tanh K_2 =: t` が `QQ`、`exp(-2K_2^*) = t` となり、`a = (√(2s_2))^{M_col}` と `exp(±K_2^*λ) = (√t)^{∓λ}` が `AA` に入る。`iH_2` は整数の固有値をもつ実対称行列なので、`exp(±Y) = exp(±K_2^*·iH_2)` を固有値ごとの射影の線型結合として厳密に作る（共通の準備 `sagemath/_shared/transfer_matrix_factor_inverses.sage`、`_shared/row_configurations.sage` の `exp_by_spectral_projectors`）。ℝ への脱出は `K_2` の選び方の一点だけで、等号はすべて厳密に判定する。
- 有理数の `K_2^*` で確かめる `exp` の行と、有理数の `K_2` で確かめる `s_2 > 0` だけは、本文の部分和を囲む 256 ビットのボールを使う（ℝ への脱出: `exp` の極限）。許容誤差は置かない。
- 範囲外: 表に書いた大きさより大きい `M_col`。

## 確かめられない行と理由

- `V2_exponential_representation` の係数・`K_2^*` を `a_ℂ`・`(K_2^*)_ℂ` と読み替える行は記法の行であり、検算では同じ値（係数は `AA` の有理数冪と実数の対の実部）になることを見るだけである。
- 準備の第一行は略記 `s_2 := sinh 2K_2` の代入で、確かめられるのは `s_2` を作る二つの経路の一致である。
- `a ≠ 0` から `ℝ` に逆数があること、`def_invertible_elements_of_R` の当てはめは推論であり、検算はその値（`aa^{-1} = 1`、`V_2h = hV_2 = I`）を確かめるにとどまる。
- `K_2` の標本は `log x` の形に限った。任意の `K_2 ∈ ℝ_{>0}` での `exp` の値は有理数の `K_2^*` のボールの検算が補う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V2_invertible
```

実行ログは `logs/` に保存する。
