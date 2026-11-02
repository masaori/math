# SageMath Check: sigma_z_product_action

## 対象

**対象ラベル**: `sigma_z_product_action` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_transfer_matrix_representation.ts`
- ブロック: `transfer_matrix_claim_sigma_z_product_action`（σ_m^zσ_{m'}^z の基底 f_{ι(μ)} への作用）
- 範囲: 主張 `σ_m^zσ_{m'}^z f_{ι(μ)} = μ(m)_C μ(m')_C f_{ι(μ)}` と、証明の六行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 六行（結合律、`sigma_z_diagonal_action` を `m'` で、スカラーを外へ、`m` で、スカラー倍の結合律、乗法の交換律） | `check_product_chain.sage` | 各行を別々の式で作る（第一行は積の行列をベクトルに掛ける、第二行はベクトルに順に掛ける、第三行以降はスカラー倍の位置を変えた式） | **PASS** | `M = 1,…,4`、`m = m'` を含む 346 通り |
| 主張そのもの | `check_statement.sage` | 本文の成分の式で組んだ行列で確かめる。対照として、積の符号を反転した値では成り立たないこと | **PASS** | `M = 1,…,5` の 1146 通り |

## 計算の帰属と範囲

`ZZ` で厳密に確かめた。浮動小数点はない。`μ(m)_C` の扱いと、行列の組み方（共通の準備 `sagemath/_shared/site_sigma_z_kronecker.sage`）は
`sagemath/check/sigma_z_diagonal_action/overview.md` と同じである。`M ≤ 5`（鎖は `M ≤ 4`）を確かめ、一般の `M` は人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sigma_z_product_action
```

実行ログは `sagemath/check/sigma_z_product_action/logs/` に保存する。
