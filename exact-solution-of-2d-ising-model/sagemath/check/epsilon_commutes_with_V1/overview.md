# SageMath Check: epsilon_commutes_with_V1

## 対象

**対象ラベル**: `epsilon_commutes_with_V1`

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- ブロック: `bridge_010_claim_epsilon_commutes_with_V1`（ε は V_1 と可換）
- 範囲: 証明の全ての鎖の行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 ε(K_1 D) = (K_1 D)ε | `check_prep.sage` | K_1 は不定元、M_col = 1..4。厳密 | **PASS** | 成り立つ |
| 主の 3 行の鎖 | `check_exp_chain.sage` | K_1 ∈ {1/4, 1/2, 1}、M_col = 1..3。exp(K_1 D) は成分の式の V_1 とも重なる。対照: σ_1^x（M_col ≥ 2）では交わらない成分がある | **PASS** | 成り立つ |
| 主張 | `check_claim_from_components.sage` | V_1 を成分の式で組み exp の値を不定元に置いて、M_col = 1..5 で厳密に | **PASS** | 成り立つ |

各行は、その行の括弧の形どおりに本文の定め方（`mat_mult` の成分の式の積、`def_matrix_sum`・`def_matrix_scalar_multiple`・`def_matrix_negation`・`def_matrix_difference` の成分の式、`def_finite_sum_of_matrices` の左からの和、`def_kronecker` の成分の式）で組み、隣の行と比べる。両辺を同じ式から作らないため、ε・σ_k^a・Z_m・Y_m は本文の経路と Sage の `tensor_product`・`*` の経路の二通りで作って一致を確かめてから使う（共通の準備 `sagemath/_shared/pauli_sites_exact.sage`）。対照（仮定を外すとどの行が崩れるか、可換でない行列では成り立たないこと）を置いた検算は、表の検査内容にそのことを書いた。

## 計算の帰属と範囲

- 準備と主張は厳密。主の鎖は exp を含むのでボール。exp を含む行だけ、本文の部分和に尾の上界 Σ_{p>N}‖S‖^p/p! を半径として足した 256 ビットの複素数のボールで囲み、Sage の `ComplexBallField` の行列の exp とも重なることを確かめてから使う（ℝ への脱出: exp の極限）。許容誤差は置かず、ボールが重なるか（等号）と、対照では交わらない成分があるかだけで判定する。
- 範囲外: 表に書いた大きさより大きい `M_col`・`n`・`r`。帰納法と極限の推論そのものは計算を含まないので、確かめるのはその中の各段の鎖の行である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh epsilon_commutes_with_V1
```

実行ログは `logs/` に保存する。
