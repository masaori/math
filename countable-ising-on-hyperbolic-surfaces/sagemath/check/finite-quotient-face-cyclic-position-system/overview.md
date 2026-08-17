# 剰余類面の巡回位置系の検算

**対象ラベル**: `def_finite_quotient_face_cyclic_position_system`

## 対象

- ファイル: `structured-latex/content/finite-quotient-lattice.ts`（ブロック `finite_quotient_lattice_definition_face_cyclic_position_system`）
- 範囲: 面剰余類の元を形式的にタグ付けした位置集合と、面回転の右作用による次位置写像

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 位数 `168` の明示的有限置換群の全ての面剰余類について、面回転の右作用が剰余類を保ち、明示した前位置写像と互いに逆で、全位置を一つの巡回列として尽くすことを照合する | PASS | `56` 面のそれぞれで `3` 位置からなる一つの巡回列になった |

## 備考

- 位置は整数添字ではなく、形式的位置ラベルと面剰余類の元の順序対である。
- 巡回位置系は面剰余類の代表元を選ばずに定まる。
- この検算は巡回位置系だけを対象とする。各位置へ辺と向きを置く面境界語、および生成したセルデータの閉曲面性・正則性・向き付けは後続の主張に含める。
- 有限置換と有限集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-quotient-face-cyclic-position-system/check_definition.sage
```
