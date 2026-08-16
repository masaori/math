# 主セルの F_2 上の一次コサイクル空間の検算

**対象ラベル**: `def_primal_first_cocycle_space_over_f2`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_primal_first_cocycle_space`）
- 範囲: 二次境界行列の転置で零へ写る主辺係数写像を、各主面に対する有限和の条件として定めた一次コサイクル空間

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 反対向きの三角形二面について全八つの主辺係数写像を列挙し、各面の有限和が零である条件、二次境界行列の転置の核、四つの偶数重み係数列が一致することを照合する | PASS | 三つの記述が一致し、四つの一次コサイクルを得た |

## 備考

- 有限集合と `GF(2)` の等号だけを用いる厳密検算である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いていない。
- 主コサイクルの双対一次サイクルへの移送は、後続の別ブロックで扱う。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/primal-first-cocycle-space-over-f2/check_definition.sage
```
