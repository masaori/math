# SageMath Check: site_sigma_z_product_is_diagonal

## 対象

**対象ラベル**: `site_sigma_z_product_is_diagonal` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_claim_site_sigma_z_product_is_diagonal`（σ_m^zσ_{m'}^z は対角行列）
- 範囲: 主張と、証明の準備（各項が `0` になる二つの場合）と三行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備: `q ≠ k` なら `(σ_m^z)_{kq} = 0` で項は `0·(…) = 0`、`q = k` なら `(σ_{m'}^z)_{kl} = 0` で項は `(…)·0 = 0` | `check_entry_chain.sage` | 各 `q` で、場合ごとに成分が `0` であることと、項・`0` との積が `0` であること | **PASS** | 下の件数のすべての `q` |
| 三行（`mat_mult` の成分の和、`0` の和、`0`） | `check_entry_chain.sage` | 第一行の左辺は Sage の行列の積の成分、右辺は項を一つずつ足した和 | **PASS** | `M = 1,…,4`、`m = m'` を含む非対角成分 4394 個 |
| 主張そのもの | `check_statement.sage` | 本文の成分の式で組んだ行列の積の非対角成分を見る。対照として、`σ_m^zσ_{m'}^x` は対角行列でないこと | **PASS** | `M = 1,…,5` の 55 通り |

## 計算の帰属と範囲

`ZZ` で厳密に確かめた。浮動小数点はない。行列の組み方は共通の準備 `sagemath/_shared/site_sigma_z_kronecker.sage` による。
`M ≤ 5`（鎖は `M ≤ 4`）を確かめ、一般の `M` は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh site_sigma_z_product_is_diagonal
```

実行ログは `sagemath/check/site_sigma_z_product_is_diagonal/logs/` に保存する。
