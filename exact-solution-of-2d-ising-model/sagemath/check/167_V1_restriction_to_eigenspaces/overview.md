# SageMath Check: 167_V1_restriction_to_eigenspaces

## 対象

**対象ラベル**: `V1_restriction_to_eigenspaces` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.mjs`

- 範囲: (end(V₁))|_{F^{(±)}} = (end(V₁^{(±)}))|_{F^{(±)}}

ε の固有空間 F^{(±)} の正規直交基底を作り、両辺をその基底の各ベクトルに作用させて比べる。F^{(±)} が V₁ と V₁^{(±)} の両方で不変であること、[ε, H₁^{(±)}] = 0、そして**反対符号の V₁^{(∓)} では一致しない**（複号同順であること）も確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_restriction.sage` | 制限の一致、不変性、複号同順 | 124 | 3.569e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 167
```

実行ログは `sagemath/check/167_V1_restriction_to_eigenspaces/logs/` に保存してある（この表の数値はそのログから取った）。
