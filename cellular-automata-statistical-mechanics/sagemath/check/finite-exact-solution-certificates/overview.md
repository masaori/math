# SageMath 検算: 厳密解候補を限定する個別の有限証明書

## 対象

**対象ラベル**: `claim_finite_pair_map_classical_nondegeneracy_decidable`

- 併せて検証するラベル: `claim_classical_nondegeneracy_does_not_imply_yang_baxter`。
- 古典的非退化性の有限判定、本文の明示写像の非退化性、Yang--Baxter 条件を満たさない三体入力を分離して検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_classical_nondegeneracy_finite_decision.sage` | 二元集合上の全二体写像で、片側値表の重複検査と全単射判定を照合する | PASS | 256 写像・1,024 片側表を全走査し、16 写像が古典的非退化 |
| `check_explicit_classical_nondegeneracy.sage` | 本文の明示写像の四つの片側写像が全単射であることを検査する | PASS | 左片側表 `(0,1),(1,0)`、右片側表 `(0,1),(0,1)` は全て全単射 |
| `check_nondegenerate_yang_baxter_counterexample.sage` | 三体入力 `(1,0,0)` における二つの合成を一段ずつ計算し、不一致を検査する | PASS | 左辺 `(0,1,1)`、右辺 `(1,1,1)` |

## 範囲と限界

- 有限判定の検算は二元集合上の二体写像 256 個を全数列挙する。これは指定した有限範囲を尽くすが、任意の有限集合についての一般証明ではない。
- 反例の検算は本文に固定した一つの二元二体写像を対象とする。古典的非退化性が Yang--Baxter 条件を含意しないことの有限証人であり、二条件の一般的な分類ではない。
- 既存の Yang--Baxter 条件と二元体線形性の有限判定は、それぞれ `finite-yang-baxter-boundary` と `binary-field-linear-rule-class` の検算が担う。入力型を結ぶ比較写像や可解性一般の判定は検算しない。
- 有限集合と自然数だけを使う。対数、除算、浮動小数点、極限、実数体・複素数体は使わない。
- これは明示した有限範囲のプログラミングによる検証であり、一般命題の証明とは区別する。
- 初回実行では、検算コードに置いた合成途中の期待値二つが誤っていたため `AssertionError` になった。本文の最終値は変えず、各写像を適用した実際の中間値へ修正して再実行した。

## 実行方法

```bash
for file in sagemath/check/finite-exact-solution-certificates/check_*.sage; do sage "$file"; done
```
