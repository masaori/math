# SageMath Check: site_sigma_z_product_diagonal_entry

## 対象

**対象ラベル**: `site_sigma_z_product_diagonal_entry` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_claim_site_sigma_z_product_diagonal_entry`（σ_m^zσ_{m'}^z の対角成分）
- 範囲: 主張と、証明の準備・九つの項の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備（`l ≠ k` で `P_{kl} = 0`、`P_{kl} f_l = 0`） | `check_chain.sage` | 各 `l ≠ k` で成分と積を見る | **PASS** | 下の件数のすべての `l` |
| 鎖の八つの等号 | `check_chain.sage` | 項を順に別の式で作る: `P_{kk}`、`P_{kk}·1`、`P_{kk} f_k`、成分の和 `Σ_l P_{kl} f_l`、Sage の行列とベクトルの積の成分 `(P f)_k`、`(μμ' f)_k`、`μμ' f_k`、`μμ'·1`、`μμ'` | **PASS** | `M = 1,…,4`、すべての `μ`・`m`・`m'` の 346 通り |

## 計算の帰属と範囲

`ZZ` で厳密に確かめた。浮動小数点はない。`μ(m)_C` は整数 `±1` のまま係数に使った（`sagemath/check/sigma_z_diagonal_action/overview.md` と同じ扱い）。
一般の `M` は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh site_sigma_z_product_diagonal_entry
```
