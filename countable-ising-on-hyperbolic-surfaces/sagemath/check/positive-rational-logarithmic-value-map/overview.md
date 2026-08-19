# 正有理数の素指数データを対数順序群へ送る写像の検算

**対象ラベル**: `def_quotient_tower_positive_rational_logarithmic_value_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_positive_rational_logarithmic_value_map`）
- 範囲: 正有理数の既約分数表示から有限台の整数素指数座標を作り、対数順序群の元とする写像

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_logarithmic_value_map.sage` | `1`, `12`, `1/18`, `45/28` について、既約な分子・分母の指定素数反復除算から有限台整数座標を構成し、元の正有理数を厳密に復元する | PASS | `1` は空の台、分母の素因数は負の座標となり、全例で有限積が入力有理数と一致 |

## 備考

- 素指数は、既約分数の分子と分母を指定素数で割り切れる間だけ反復除算して求めた。
- 検算例では候補素数を有限範囲で列挙したが、本文の写像は完全因数分解のアルゴリズムを定義に含めず、非零座標の有限性だけを正整数の素数約数の有限性から得る。
- 自然数、整数、正有理数、有限タプルだけを用いた厳密検算であり、浮動小数点、実対数、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-logarithmic-value-map/check_logarithmic_value_map.sage
```
