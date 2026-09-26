# SageMath Check: 第一転送行列の一般生成子による指数表示（両符号版・退避）

## 対象

退避対象ラベル: `V1_pm_exponential_representation`（旧ラベル。`def_V1_pm`・`def_H1_pm` も旧ラベル）

**両符号 `V_1^{(±)}` の主張はもう本文ではない。** (−) セクターを本文から外したとき（2026-09-26）、
本文の主張は (+) だけの `V1_plus_exponential_representation`（`def_V1_plus`・`def_H1_plus`）に改名・縮小された。
(+) 側の検証は `check/V1_plus_exponential_representation/` にある。ここは両符号を検査していた旧版の記録である。

ラベルは本文に実在しないので、`tools/verify-check-linkage.ts`（`check/` 配下だけを見る）の対象外である。

2026-09-26 に移動先で再実行して PASS した（`logs/`）。


- ファイル: `structured-latex/content/004_transfer_matrix.ts`（ブロック `transfer_matrix_011c_claim_V1_pm_exponential_representation`）
- 範囲: `def_V1_pm` の有限和を `def_H1_pm` の `H_1^{(±)}` へ置換する証明行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_generator_substitution.sage` | 両符号、`2 ≤ M ≤ 5` で有限和と `H_1^{(±)}` および指数の肩が一致すること | PASS | 全条件で厳密等号が成立 |

## 備考

- 行列成分を `QQ(i)` に置き、等号を厳密に判定する。浮動小数点と ℝ 脱出は用いない。
- 行列指数関数の引数が等しいことを検査する。関数へ等しい引数を入れた値が等しいことは等号の合同性による。

## 実行方法

```bash
sage sagemath/_old/minus-sector/V1_pm_exponential_representation/check_generator_substitution.sage
```
