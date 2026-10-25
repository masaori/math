# SageMath Check: 第一色の端点列の置換像

## 対象

**対象ラベル**: `claim_matching_pair_word_map`

- 帰属: 有限番号集合と整数。浮動小数点は使わない。
- 実行日: 2026-10-25

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | 各点への写像、第一色の相手への置換、第二色の相手への置換、列の一致 | PASS | マッチング対 235 組と空集合で通過 |

有限標本の検算であり、一般の有限集合についての証明は本文と Lean が担う。

## 実行方法

```sh
sage sagemath/check/matching-pair-word-map/check.sage
```
