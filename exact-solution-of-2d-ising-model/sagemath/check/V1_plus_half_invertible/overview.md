# SageMath Check: V1_plus_half_invertible

## 対象

**対象ラベル**: `V1_plus_half_invertible`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_claim_V1_plus_half_invertible`（(V_1^{(+)})^{1/2} の可逆性）
- 範囲: 証明の二つの鎖の全ての行と、最後の所属 `(V_1^{(+)})^{1/2} ∈ R^×`

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 第一の鎖の全行 `(V_1^{(+)})^{1/2}h = (V_1^{(+)})^{1/2}exp(-X) = exp((i/2)K_1H_1^{(+)})exp(-X) = exp(X)exp(-X) = exp(-(-X))exp(-X) = I` | `check_exact_chains.sage` | `K_1 = 2 log y` として `exp(±X)` を `iH_1^{(+)}` の固有値の射影の和で `QQ` に作り、各行を本文の積で組んで隣り合う行が等しく I に着く。`-(-X) = X` は肩の行列で厳密に | **PASS** | `M_col = 2..4`、`y ∈ {2, 3, 3/2}` で厳密等号 |
| 第二の鎖の全行 `h(V_1^{(+)})^{1/2} = … = exp(-X)exp(X) = I` | 同上 | 同上 | **PASS** | 同上 |
| 最後の所属 `∈ R^×` | 同上 | Sage の `inverse` で求めた逆行列が `h = exp(-X)` に等しい。対照: `y` を替えた `exp(-X')` は逆元にならない | **PASS** | 同上 |
| 二つの鎖の `exp` の行（本文の部分和で） | `check_inverse_chains.sage` | `X` を `K_1 ∈ {1/4, 1/2, 1}` で `QQ(i)` に作り、`exp` を本文の部分和と尾の上界のボールで囲んで、`exp(X)exp(-X)`・`exp(-(-X))exp(-X)`・`exp(-X)exp(X)` が I と重なる。対照: `K_1` を 2 倍にした `exp(-X')` では I と交わらない成分がある | **PASS** | `M_col = 2..4` |
| 最後の所属（本文の部分和で） | `check_claim.sage` | Sage の `ComplexBallField` の逆行列が `exp(-X)` のボールと重なる | **PASS** | `M_col = 2..4`、`K_1 ∈ {1/4, 1/2, 1}` |

## 計算の帰属と範囲

- 厳密の検算は `K_1 = 2 log y`（`y ∈ QQ, y > 1`）と選ぶ。`X = (log y)·iH_1^{(+)}` で、`iH_1^{(+)}` は整数の固有値をもつ整数行列なので、`exp(±X) = Σ_λ y^{±λ}P_λ` が `QQ` に乗る（共通の準備 `sagemath/_shared/transfer_matrix_factor_inverses.sage` の `exp_V1_half_exact`、`_shared/row_configurations.sage` の `exp_by_spectral_projectors`）。ℝ への脱出は `K_1` の選び方の一点だけである。定義の肩 `(i/2)K_1H_1^{(+)}` と `X = (i/2)(K_1)_ℂ H_1^{(+)}` は同じ行列なので、この二行は同じ値になる（包含を明示する書き換えで、計算の中身は無い）。
- 有理数の `K_1` での検算は、本文の部分和の `exp` を確かめる補助である。`X`・`-X`・`-(-X)` は `QQ(i)` で厳密に作る（共通の準備 `sagemath/_shared/pauli_sites_exact.sage` の `H1_plus`、`_shared/matrix_negation_and_difference_by_definition.sage`）。
- `exp` を含む行だけ、本文の部分和に尾の上界 `Σ_{p>N}‖X‖^p/p!` を半径として足した 256 ビットの複素数のボールで囲み、Sage の `ComplexBallField` の行列の `exp` とも重なることを確かめてから使う（ℝ への脱出: `exp` の極限）。許容誤差は置かず、ボールが重なるか（等号）と、対照では交わらない成分があるかだけで判定する。
- 範囲外: `M_col ≥ 5`。`exp_of_negative_is_left_inverse` と `def_invertible_elements_of_R` の当てはめ（推論）は計算を含まないので、確かめるのはその値である。

## 確かめられない行と理由

- `K_1` の標本は `2 log y` と有理数に限った。主張は任意の `K_1 ∈ ℝ_{>0}` について述べるが、鎖の各行は `X` が何であっても成り立つ等式（`matrix_double_negation`・`exp_of_negative_is_left_inverse`）の当てはめなので、標本で行の形の誤り（符号・順序）を捕まえる。
- 定義の `K_1` を `(K_1)_ℂ` と読み替える行は記法の行であり、検算では同じ行列になることを見るだけである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V1_plus_half_invertible
```

実行ログは `logs/` に保存する。
