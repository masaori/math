# SageMath Check: 167_V1_restriction_to_eigenspaces

## 対象

**対象ラベル**: `V1_restriction_to_eigenspaces` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`

- 範囲: (end(V₁))|_{F^{(+)}} = (end(V₁^{(+)}))|_{F^{(+)}}（V₁^{(+)} = exp(iK₁(Y₁Z₂ + ⋯ + Y_{M−1}Z_M − Y_MZ₁))、`def_V1_plus`）

ε の固有空間 F^{(+)} の正規直交基底を作り、両辺をその基底の各ベクトルに作用させて比べる。F^{(+)} が V₁ と V₁^{(+)} の両方で不変であること、[ε, H₁^{(+)}] = 0、そして**行列としては V₁ ≠ V₁^{(+)}**（F^{(+)} へ制限してはじめて一致する）ことも確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_restriction.sage` | F^{(+)} 上での制限の一致、不変性、行列としては不一致 | 64 | 3.295e-15 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 167
```

実行ログは `sagemath/check/167_V1_restriction_to_eigenspaces/logs/` に保存してある（この表の数値はそのログから取った。2026-09-26、SageMath 10.9）。

## (−) セクターの退避に伴う更新（2026-09-26）

本文の主張が F^{(+)} 上の置き換えだけになったので、F^{(−)} 側と「反対符号の V₁^{(∓)} では一致しない（複号同順）」の判定を外し、
代わりに行列としての不一致 V₁ ≠ V₁^{(+)} を確かめる形に書き直した。書き直す前の両符号版は
`sagemath/_old/minus-sector/167_V1_restriction_to_eigenspaces/` にある。
