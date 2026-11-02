# SageMath Check: site_sigma_z_is_diagonal

## 対象

**対象ラベル**: `site_sigma_z_is_diagonal` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_claim_site_sigma_z_is_diagonal`（σ_m^z は対角行列）
- 範囲: 主張と、証明の準備（`I`・`σ^z` の非対角成分が 0、`ν` の全単射、`k_n ≠ l_n` となる `n`）と三行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備: `s ≠ t` で `(I)_{st} = δ_{st} = 0`、`(σ^z)_{st} = 0` | `check_entry_chain.sage` | 2 次の行列の非対角成分を直接見る | **PASS** | 2 成分ずつ |
| 準備: `ν` は全単射、`k ≠ l` なら `K ≠ L` で `k_n ≠ l_n` となる `n` がある | `check_entry_chain.sage` | `ν` の値が `1,…,2^M` をちょうど一度ずつ取ること、各 `k ≠ l` で `n` が見つかること | **PASS** | `M = 1,…,5` |
| 三行（クロネッカー積の成分、因子の成分の積、`0`） | `check_entry_chain.sage` | 第一行は Sage の `tensor_product` の成分、第二行は因子の成分を左から順に掛けた積（`def_finite_product_of_complex_numbers` の順）、第三行へ進む前に第 `n` 因子の成分が `0` であること | **PASS** | `M = 1,…,5` の非対角成分 6114 個 |
| 主張そのもの | `check_statement.sage` | 本文の成分の式で組んだ行列の非対角成分を一つずつ見る。対照として、`σ_m^x` は対角行列でないこと | **PASS** | `M = 1,…,5` の 15 行列 |

## 計算の帰属と範囲

`ZZ` で厳密に確かめた。浮動小数点はない。行列の組み方は共通の準備 `sagemath/_shared/site_sigma_z_kronecker.sage` による。
`M ≤ 5` を確かめ、一般の `M` は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh site_sigma_z_is_diagonal
```

実行ログは `sagemath/check/site_sigma_z_is_diagonal/logs/` に保存する。
