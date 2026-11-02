# SageMath Check: commuting_matrix_commutes_with_exp

## 対象

**対象ラベル**: `commuting_matrix_commutes_with_exp`

- ファイル: `structured-latex/content/003_exp_linear_map.ts`
- ブロック: `exp_linear_map_claim_commuting_matrix_commutes_with_exp`（可換な行列は exp とも可換（`AB = BA` なら `A exp(B) = exp(B)A`））
- 範囲: 証明の全ての鎖の行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| Step 1 の p = 0 の 4 等号と p → p+1 の 7 等号 | `check_powers_chain.sage` | B は不定元の行列、A = a0 I + a1 B + a2 B^2 で、p = 0..3、n = 2, 3。独立な A' では帰納法の仮定の行（p ≥ 1）と仮定 AB = BA の行だけが崩れる | **PASS** | 成り立つ |
| Step 2 の N = 0 の 5 等号と N → N+1 の 8 等号 | `check_partial_sums_chain.sage` | N = 0..4、n = 2, 3。独立な A' では帰納法の仮定の行と Step 1 を引く行だけが崩れる | **PASS** | 成り立つ |
| Step 3 の差の 4 等号、不等号の鎖、η から N_0 を取る段 | `check_left_limit_chain.sage` | 差の鎖は不定元の行列で厳密に。不等号と N_0 は具体の可換な組で exp をボールで囲んで | **PASS** | 成り立つ |
| Step 4 と主張 | `check_claim.sage` | 可換な 3 組でボールが重なり、可換でない組では交わらない成分がある。Step 4 の右からの積の極限 S_NA → EA は単独では確かめず、主張の照合で代える | **PASS** | 成り立つ |

各行は、その行の括弧の形どおりに本文の定め方（`mat_mult` の成分の式の積、`def_matrix_sum`・`def_matrix_scalar_multiple`・`def_matrix_negation`・`def_matrix_difference` の成分の式、`def_finite_sum_of_matrices` の左からの和、`def_kronecker` の成分の式）で組み、隣の行と比べる。両辺を同じ式から作らないため、ε・σ_k^a・Z_m・Y_m は本文の経路と Sage の `tensor_product`・`*` の経路の二通りで作って一致を確かめてから使う（共通の準備 `sagemath/_shared/pauli_sites_exact.sage`）。対照（仮定を外すとどの行が崩れるか、可換でない行列では成り立たないこと）を置いた検算は、表の検査内容にそのことを書いた。

## 計算の帰属と範囲

- 差の鎖と Step 1・2 は厳密。Step 3 の不等号・極限と主張は exp を含むのでボール。exp を含む行だけ、本文の部分和に尾の上界 Σ_{p>N}‖S‖^p/p! を半径として足した 256 ビットの複素数のボールで囲み、Sage の `ComplexBallField` の行列の exp とも重なることを確かめてから使う（ℝ への脱出: exp の極限）。許容誤差は置かず、ボールが重なるか（等号）と、対照では交わらない成分があるかだけで判定する。
- 範囲外: 表に書いた大きさより大きい `M_col`・`n`・`r`。帰納法と極限の推論そのものは計算を含まないので、確かめるのはその中の各段の鎖の行である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh commuting_matrix_commutes_with_exp
```

実行ログは `logs/` に保存する。
