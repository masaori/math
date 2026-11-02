# SageMath Check: finite_product_of_identity_matrices

## 対象

**対象ラベル**: `finite_product_of_identity_matrices` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_product_of_identity_matrices`（単位行列の有限積は単位行列）
- 範囲: 主張と、帰納法の二つの鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` の行と、`r → r+1` の三行 | `check_induction_lines.sage` | 有限積を `def_finite_product_of_matrices` の帰納法どおり左から掛けて作り（空の積は使わない）、各行の項と帰納法の仮定を確かめる。対照として、単位行列でない因子があれば単位行列にならないこと | **PASS** | `n = 1,…,4`、`r = 1,…,8` の 32 通り |

## 計算の帰属と範囲

`QQ` の 0 と 1 を成分とする単位行列で厳密に確かめた。浮動小数点はない。一般の `n`・`r` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_product_of_identity_matrices
```

実行ログは `sagemath/check/finite_product_of_identity_matrices/logs/` に保存する（2026-11-02）。
