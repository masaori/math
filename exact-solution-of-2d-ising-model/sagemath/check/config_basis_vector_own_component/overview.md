# SageMath Check: config_basis_vector_own_component

## 対象

**対象ラベル**: `config_basis_vector_own_component` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_claim_config_basis_vector_own_component`（f_I の第 ν(I) 成分は 1）
- 範囲: 主張と、証明の四つの項の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の三つの等号 | `check_chain.sage` | 第 1 項は Sage の `tensor_product` で組んだ `f_I` の成分（本文の成分の式で組んだものとの一致も確かめる）、第 2 項は因子の成分を左から掛けた積、第 3 項は 1 を `M` 個掛けた積。各因子の成分 `(e_{i_k})_{i_k}` が 1 であることも確かめる。対照として、第 `ν(J)` 成分（`J ≠ I`）は 0 であること | **PASS** | `M = 1,…,6` のすべての `I`（126 通り） |

## 計算の帰属と範囲

`ZZ` で厳密に確かめた。浮動小数点はない。行列とベクトルの組み方は共通の準備 `sagemath/_shared/site_sigma_z_kronecker.sage` による。
一般の `M` は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh config_basis_vector_own_component
```
