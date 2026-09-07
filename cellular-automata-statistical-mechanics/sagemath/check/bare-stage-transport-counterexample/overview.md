# SageMath 検算: 一般の舞台で失われる近傍輸送と一様性

## 対象

**対象ラベル**: `claim_bare_stage_loses_uniform_transport`

- 併せて検証するラベル: `def_bare_stage_transport_counterexample`、`def_state_set`。
- 二セルの有限舞台について、近傍元数、近傍間の全単射の不在、交換写像による近傍保存の失敗、
  二元状態集合上の局所入力集合の元数を本文の段ごとに分けて検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_neighborhood_cardinalities.sage` | 二つの近傍の元数 | PASS | 一元と二元で一致 |
| `check_no_neighborhood_bijection.sage` | 小さい近傍から大きい近傍への全写像を全数列挙し、全単射がないこと | PASS | 全二写像を検査し全単射 0 件 |
| `check_swap_not_neighborhood_preserving.sage` | 二セル交換写像による近傍保存の失敗 | PASS | 交換像 `{v}` と交換先近傍 `{u,v}` の不一致を確認 |
| `check_local_input_cardinalities.sage` | 二元状態集合上の局所入力集合の元数 | PASS | 二元と四元で一致 |

## 範囲と限界

- 本文で証人に選んだ二セル舞台を全て走査する。近傍間の写像は、一元集合から二元集合への全二写像を列挙する。
- これは「全ての一般の舞台が一様でない」という主張ではない。一つの有限反例により、近傍の標準的輸送と
  平行移動不変性が一般の舞台の定義だけからは導けないことを検算する。
- 有限集合、有限写像、整数だけを使う。対数、除算、浮動小数点、全配位空間、極限、実数体・複素数体は使わない。
- これは明示した有限反例のプログラミングによる検証であり、一般証明の根拠は構造化記述にある。

## 実行方法

```bash
for file in sagemath/check/bare-stage-transport-counterexample/check_*.sage; do sage "$file"; done
```
